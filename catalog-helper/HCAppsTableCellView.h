//
//  HCAppsTableCellView.h
//  catalog-helper
//
//  Created by Andreas Pohle on 14.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCAppsTableCellView : NSTableCellView

@property (assign) IBOutlet NSTextField *elementTypeLabel;
@property (assign) IBOutlet NSTextField *nameLabel;
@property (assign) IBOutlet NSTextField *pathLabel;
@property (assign) IBOutlet NSButton *infoButton;

@end
