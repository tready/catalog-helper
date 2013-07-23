//
//  HCHomeViewController.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HCSubViewController.h"
#import "HCWorkspaceHelper.h"

@interface HCHomeViewController : HCSubViewController

- (IBAction)selectWorkspace:(id)sender;
- (IBAction)openSelectedWorkspace:(id)sender;

@end
