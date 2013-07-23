//
//  HCAppsTableViewController.h
//  catalog-helper
//
//  Created by Andreas Pohle on 14.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCWorkspace.h"
#import "HCWorkspaceFolder.h"
#import "HCWorkspaceHelper.h"
#import "HCAppsTableCellView.h"

#import "HCColorProvider.h"

@interface HCAppsTableViewController : NSObject <NSTableViewDelegate, NSTableViewDataSource> {
    
    IBOutlet NSTableView *table;
    NSMutableArray *subfolders;
    NSMutableArray *favorites;
}

@property (weak) IBOutlet NSSegmentedControl *tableDataFilter;

@property (nonatomic, strong) HCColorProvider* colorProvider;

@property (nonatomic, readwrite, copy) NSString *infoTypeLabelText;
@property (nonatomic, readwrite, copy) NSString *infoNameLabelText;
@property (nonatomic, readwrite, copy) NSString *infoPathLabelText;

@property (weak) IBOutlet NSComboBox *entryTypeNew;
@property (weak) IBOutlet NSComboBoxCell *entryTypeNewCell;
@property (weak) IBOutlet NSTextField *entryNameNew;

@property (nonatomic, readwrite) BOOL entryTypeNewValidationError;
@property (nonatomic, readwrite) BOOL entryNameNewValidationError;
@property (nonatomic, readwrite) BOOL entryNewValidationProcessFinished;

- (IBAction)showElementInfo:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)filterElements:(id)sender;
- (IBAction)stopAddElement:(id)sender;
- (IBAction)submitNewElement:(id)sender;

@end
