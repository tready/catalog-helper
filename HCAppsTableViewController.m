//
//  HCAppsTableViewController.m
//  catalog-helper
//
//  Created by Andreas Pohle on 14.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCAppsTableViewController.h"

@implementation HCAppsTableViewController

# pragma mark Properties

@synthesize infoNameLabelText;
@synthesize infoPathLabelText;
@synthesize infoTypeLabelText;
@synthesize entryNameNew;
@synthesize entryTypeNew;

@synthesize entryNameNewValidationError;
@synthesize entryTypeNewValidationError;
@synthesize entryNewValidationProcessFinished;


- (id)init
{
    self = [super init];
    if (self) {
        [self setColorProvider:[HCColorProvider sharedColorProvider]];
        [table setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleSourceList];
        subfolders = [NSMutableArray array];
        [self filterFolders:0 needsUpdate:YES];
        NSLog(@"init selectedSegment: %ld", (long)[[self tableDataFilter] selectedSegment]);
    }
    return self;
}

-(void)filterFolders:(NSInteger)tag needsUpdate:(BOOL)needsUpdate {
    
    if ([subfolders count] != 0) {
        [subfolders removeAllObjects];
    }
    
    NSPredicate *filter;
    switch (tag) {
        case 0:
            filter = [NSPredicate predicateWithFormat:@"workspaceFolder == %@", @YES];
            break;
        case 1:
            filter = [NSPredicate predicateWithFormat:@"workspaceFolderTyp == %@", @"Element"];
            break;
        case 2:
            filter = [NSPredicate predicateWithFormat:@"workspaceFolderTyp == %@", @"Module"];
            break;
    }
    
    for (HCWorkspaceFolder *folder in [[[HCWorkspace sharedWorkspace] appsFolder] subfolders]) {
        if ([filter evaluateWithObject:folder]) {
            [subfolders addObject:folder];
        }
    }
    
    if (needsUpdate) {
        [table reloadData];
        //[self.tableViewModel reloadBoundValues];  // reload the model
        //[self.tableViewModel.tableView reloadData];  // reload the table view
    }
    [self displayElementInformations:0];
}

#pragma mark TableView DataSource

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [subfolders count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [subfolders objectAtIndex:row];
}

-(void)tableViewSelectionIsChanging:(NSNotification *)notification
{
    NSLog(@"%@", notification);
    NSLog(@"%ld", (long)[table selectedRow]);
    [self displayElementInformations:[table selectedRow]];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    HCWorkspaceFolder *folder = [subfolders objectAtIndex:row];
    HCAppsTableCellView *cellView = [tableView makeViewWithIdentifier:@"FolderCell" owner:self];
    
    
    if([folder valueForKey:@"name"] != nil) {
        cellView.textField.stringValue = [folder valueForKey:@"name"];
        cellView.nameLabel.stringValue = [folder valueForKey:@"name"];
    }
    if([folder valueForKey:@"workspaceFolderTyp"] != nil) {
        cellView.elementTypeLabel.stringValue = [folder valueForKey:@"workspaceFolderTyp"];
    }
    cellView.infoButton.tag = row;
    return cellView;
}

-(void)showElementInfo:(id)sender
{
    [self displayElementInformations:[sender tag]];
}

- (void) displayElementInformations:(NSInteger)entry
{
    HCWorkspaceFolder *folder = [subfolders objectAtIndex:entry];
    [self setValue:[folder workspaceFolderTyp] forKey:@"infoTypeLabelText"];
    [self setValue:[folder name] forKey:@"infoNameLabelText"];
    [self setValue:[folder path] forKey:@"infoPathLabelText"];
}


# pragma mark Actions

- (IBAction)add:(id)sender {
    NSLog(@"%@", sender);
    [[HCWorkspaceHelper sharedWorkspaceHelper] setValue:@YES forKey:@"blockedForAddProcess"];
}

- (IBAction)filterElements:(NSSegmentedControl *)sender {
    [self filterFolders:[sender selectedSegment] needsUpdate:TRUE];
    NSLog(@"%ld", (long)[sender selectedSegment]);
}


- (IBAction)stopAddElement:(id)sender {
    [[HCWorkspaceHelper sharedWorkspaceHelper] setValue:@NO forKey:@"blockedForAddProcess"];
}

- (IBAction)submitNewElement:(id)sender {
    
    
    if ([[[self entryTypeNewCell] stringValue] isEqual: @""]) {
        [self setValue:@YES forKey:@"entryTypeNewValidationError"];
    } else {
        [self setValue:@NO forKey:@"entryTypeNewValidationError"];
    }
    
    if ([[[self entryNameNew] stringValue] isEqual: @""]) {
        [self setValue:@YES forKey:@"entryNameNewValidationError"];
    } else {
        if ([[[self entryNameNew] stringValue] rangeOfString:@"App"].location != NSNotFound)
        {
            [self setValue:@YES forKey:@"entryNameNewValidationError"];
        } else {
            [self setValue:@NO forKey:@"entryNameNewValidationError"];
        }
    }
    
    NSString *name = [[self entryTypeNewCell] stringValue];
    name = [name stringByAppendingString:[[self entryNameNew] stringValue]];
    name = [name stringByAppendingString:@"App"];
    
    NSString *path = [[[HCWorkspace sharedWorkspace] appsFolder] path];
    
    if ([[HCWorkspaceHelper sharedWorkspaceHelper] checkIfEntryNameExist:name]) {
        NSLog(@"%@", @"NameExistError");
        return;
    }
    
    [self setValue:@YES forKey:@"entryNewValidationProcessFinished"];
    if ([self entryNameNewValidationError] == NO && [self entryTypeNewValidationError] == NO) {
      
        BOOL created = [[HCWorkspaceHelper sharedWorkspaceHelper] createNewFolderEntry:path withName:name];
        if (created) {
           [[HCWorkspaceHelper sharedWorkspaceHelper] setValue:@NO forKey:@"blockedForAddProcess"];
        }
        
    }
    //[[HCWorkspaceHelper sharedWorkspaceHelper] setValue:@NO forKey:@"blockedForAddProcess"];
}
@end
