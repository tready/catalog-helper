//
//  HCWorkspaceHelper.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCWorkspaceHelper.h"


@interface HCWorkspaceHelper()

- (void)openSelectWorkspaceDialog;
- (void)handleSelectWorkspaceDialogResult:(NSArray *)URLs;

@end

@implementation HCWorkspaceHelper

static HCWorkspaceHelper *sharedWorkspaceHelper = nil;

+(HCWorkspaceHelper *)sharedWorkspaceHelper
{
    if (sharedWorkspaceHelper == nil) {
        sharedWorkspaceHelper = [[super allocWithZone:nil] init];
    }
    return sharedWorkspaceHelper;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedWorkspaceHelper];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setValue:[HCWorkspace sharedWorkspace] forKey:@"sharedWorkspace"];
    }
    return self;
}

-(void)selectWorkspace
{
    [self openSelectWorkspaceDialog];
}

-(void)closeWorkspace
{
    [[HCWorkspace sharedWorkspace] reset];
}

-(void)openSelectWorkspaceDialog
{
    // Create a File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable options in the dialog.
    [openDlg setCanChooseFiles:FALSE];
    [openDlg setCanChooseDirectories:TRUE];
    [openDlg setAllowsMultipleSelection:FALSE];
    
    // Display the dialog box.
    if ( [openDlg runModal] == NSOKButton ) {
        [self handleSelectWorkspaceDialogResult:[openDlg URLs]];
    }
}

-(void)handleSelectWorkspaceDialogResult:(NSArray *)URLs
{
    if ([URLs count] != 1) {
        NSLog(@"ERROR !");
    }
    
    NSURL* url = [URLs objectAtIndex:0];
    if (url) {
        
        NSString *folder = [url path];
        
        
        [[self sharedWorkspace] setValue:folder forKey:@"path"];
        [[self sharedWorkspace] setValue:[[folder componentsSeparatedByString:@"/" ] lastObject] forKey:@"name"];
        
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray* folders = [fm contentsOfDirectoryAtPath:folder error:nil];
        NSMutableArray *directoryList = [NSMutableArray arrayWithCapacity:10];
        
        for (NSString *folderEntry in folders) {
            
            
            
            NSString *path = [folder stringByAppendingPathComponent:folderEntry];
            BOOL isDir = FALSE;
            [fm fileExistsAtPath:path isDirectory:(&isDir)];
            if (isDir) {
                [directoryList addObject:folderEntry];
                if ([folderEntry isEqualToString:@"apps"]) {
                    
                    HCWorkspaceFolder *appsFolder = [[HCWorkspaceFolder alloc] init];
                    [appsFolder setName:folderEntry];
                    [appsFolder setPath:path];
                    [[self sharedWorkspace] setValue:appsFolder forKey:@"appsFolder"];
                    
                } else if ([folderEntry isEqualToString:@"containers"]) {
                    //NSLog(@"create containers folder");
                    HCWorkspaceFolder *containersFolder = [[HCWorkspaceFolder alloc] init];
                    [containersFolder setName:folderEntry];
                    [containersFolder setPath:path];
                    [[self sharedWorkspace] setValue:containersFolder forKey:@"containersFolder"];
                } else {
                    //NSLog(@"create other folder");
                }
            }
        }
        
        
        
    }
    [[self sharedWorkspace] checkInitalized];
}

-(BOOL)checkIfEntryNameExist:(NSString *)entryName {
   
    BOOL returnValue = NO;
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name == %@", entryName];
    
    for (HCWorkspaceFolder *folder in [[[self sharedWorkspace] appsFolder] subfolders]) {
        if ([filter evaluateWithObject:folder]) {
            returnValue = YES;
        }
    }
    return returnValue;
}

# pragma mark Folder creation

-(BOOL)createNewFolderEntry:(NSString *)path withName:(NSString *)name
{
    HC_DBG_LOG_FUNC_ENTER;
    
    BOOL entryCreated = NO;
    @try {
        [self createFolder:path withName:name];
        [self createFolder:[path stringByAppendingPathComponent:name] withName:@"src"];
        NSString *srcDir = [[path stringByAppendingPathComponent:name] stringByAppendingPathComponent:@"src"];
        [self createFolder:srcDir withName:@"scripts"];
        [self createFolder:srcDir withName:@"styles"];
        [self createFolder:srcDir withName:@"templates"];
        [self createFile:[srcDir stringByAppendingPathComponent:@"scripts"] withName:@"index.coffee" withTemplate:@"index-coffee.txt" withEntryName:name];
        [self createFile:[srcDir stringByAppendingPathComponent:@"styles"] withName:@"style.scss" withTemplate:nil  withEntryName:name];
        [self createFile:[srcDir stringByAppendingPathComponent:@"templates"] withName:@"index.html" withTemplate:@"index-html.txt"  withEntryName:name];
        
        
        entryCreated = YES;
    }
    @catch (NSException *exception) {
        HC_DLog(@"Create new Folder failed: %@", [exception reason]);
        
    }
    @finally {
        if (!entryCreated) {
            HC_DLog(@"Try to delete main entry");
        } else {
            HCWorkspaceFolder *folder = [[HCWorkspaceFolder alloc] init];
            folder.name = name;
            folder.path = [path stringByAppendingPathComponent:name];
            [[[HCWorkspace sharedWorkspace] appsFolder] addSubFolder:folder];
        }
    }
    HC_DBG_LOG_FUNC_EXIT;
    return entryCreated;
}

-(void)createFolder:(NSString *)path withName:(NSString *)folderName
{
    HC_DBG_LOG_FUNC_ENTER;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    @try {
        NSError *error = nil;
        NSString *newFolder = [path stringByAppendingPathComponent:folderName];
        if ([fileManager fileExistsAtPath:newFolder]) {
            NSException *theException = [NSException exceptionWithName:@"CreateFolderException" reason:@"Folder or file already exist" userInfo:nil];
            @throw theException;
        }
        BOOL success = [fileManager createDirectoryAtPath:newFolder withIntermediateDirectories:NO attributes:nil error:&error];
        if (!success) {
            NSException *theException = [NSException exceptionWithName:@"CreateFolderException" reason:[error description] userInfo:nil];
            @throw theException;
        }
    }
    @catch (NSException *exception) {
        HC_DLog(@"Create Folder failed: %@", [exception reason]);
        @throw exception;
    }
    HC_DBG_LOG_FUNC_EXIT;
}

-(void)createFile:(NSString *)path
         withName:(NSString *)name
     withTemplate:(NSString *)template
    withEntryName:(NSString *)entryName
{
    HC_DBG_LOG_FUNC_ENTER;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    @try {
        NSError *error = nil;
        NSString *newFile = [path stringByAppendingPathComponent:name];
        if ([fileManager fileExistsAtPath:newFile]) {
            NSException *theException = [NSException exceptionWithName:@"CreateFileException" reason:@"File or file already exist" userInfo:nil];
            @throw theException;
        }
        
        NSString *content;
        
        if (template != nil) {
            NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
            NSString *templatePath = [resourcePath stringByAppendingPathComponent:template];
            content = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
            
            content = [content stringByReplacingOccurrencesOfString:@"HCNewModulePlaceholder"
                                                         withString:entryName];
        } else {
            content = @"";
        }
        
        BOOL success = [content writeToFile:newFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        if (!success) {
            NSException *theException = [NSException exceptionWithName:@"CreateFileException" reason:[error description] userInfo:nil];
            @throw theException;
        }
    }
    @catch (NSException *exception) {
        
    }
    
    HC_DBG_LOG_FUNC_EXIT;
}


@end
