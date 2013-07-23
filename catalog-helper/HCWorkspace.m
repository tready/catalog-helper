//
//  HCWorkspace.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCWorkspace.h"

@implementation HCWorkspace

@synthesize initialized;
@synthesize initProcessFinished;
@synthesize name;
@synthesize path;
@synthesize appsFolder;
@synthesize containersFolder;

@synthesize appsFolderDetected;
@synthesize containersFolderDetected;


static HCWorkspace *sharedWorkspace = nil;

+(HCWorkspace *) sharedWorkspace
{
    if (sharedWorkspace == nil) {
        sharedWorkspace = [[super allocWithZone:nil] init];
    }
    return sharedWorkspace;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedWorkspace];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setValue:@NO forKey:@"initialized"];
        [self setValue:nil forKey:@"appsFolder"];
        [self addObserver:self forKeyPath:@"appsFolder" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"containersFolder" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"initialized" options:NSKeyValueObservingOptionNew context:nil];
        
        [self setValue:@NO forKey:@"appsFolderDetected"];
        [self setValue:@NO forKey:@"containersFolderDetected"];
        
        [self setValue:@NO forKey:@"initProcessFinished"];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath: %@", keyPath);
    if ([keyPath isEqualToString:@"appsFolder"] || [keyPath isEqualToString:@"containersFolder"]) {
        [self readFolderContent:[self valueForKey:keyPath]];
    }
    if ([keyPath isEqualToString:@"initialized"]) {
        if ([self initialized] == NO) {
            [self setValue:@"" forKey:@"name"];
            [self setValue:@"" forKey:@"path"];
        }
    }
}

- (void)readFolderContent:(HCWorkspaceFolder *)folder
{
    if (folder != nil) {
        NSString *folderPath = [folder path];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray* subfolders = [fm contentsOfDirectoryAtPath:folderPath error:nil];
        for (NSString *subfoldersEntry in subfolders) {
            
            BOOL isDir = FALSE;
            [fm fileExistsAtPath:[folderPath stringByAppendingPathComponent:subfoldersEntry] isDirectory:(&isDir)];
            if (isDir) {
                HCWorkspaceFolder *subFolder = [[HCWorkspaceFolder alloc] init];
                [subFolder setName:subfoldersEntry];
                [subFolder setPath:[folderPath stringByAppendingPathComponent:subfoldersEntry]];
                [[folder subfolders] addObject:subFolder];
            }
            
        }
    }
}

-(void)checkInitalized
{
    if ([self valueForKey:@"appsFolder"] != nil) {
        [self setValue:@YES forKey:@"initialized"];
        
        [self setValue:@YES forKey:@"appsFolderDetected"];
        
    } else {
        [self setValue:@NO forKey:@"initialized"];
        [self setValue:@NO forKey:@"appsFolderDetected"];
    }
    
    if ([self valueForKey:@"containersFolder"] != nil) {
        [self setValue:@YES forKey:@"containersFolderDetected"];
        
    } else {
        [self setValue:@NO forKey:@"containersFolderDetected"];
    }
    
    [self setValue:@YES forKey:@"initProcessFinished"];
}

-(void)reset
{
    [self setValue:@"" forKey:@"name"];
    [self setValue:@"" forKey:@"path"];
    
    [self setValue:@NO forKey:@"initialized"];
    [self setValue:@NO forKey:@"initProcessFinished"];
    [self setValue:nil forKey:@"appsFolder"];
    [self setValue:nil forKey:@"containersFolder"];
}

@end
