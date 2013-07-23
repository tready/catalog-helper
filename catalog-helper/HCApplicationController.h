//
//  HCApplicationController.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HCParentControllerDelegate.h"

#import "HCSubViewController.h"
#import "HCHomeViewController.h"
#import "HCWorkspaceViewController.h"

#import "HCWorkspaceHelper.h"
#import "HCWorkspace.h"


@interface HCApplicationController : NSObject<HCParentControllerDelegate>

@property (weak) IBOutlet NSButton *bottomBarWorkspaceControll;

@property (weak) IBOutlet NSView *appView;
@property (weak) IBOutlet NSTextField *bottomPathLabel;

@property (nonatomic ,strong) HCSubViewController* appViewController;

@property (nonatomic, strong) HCWorkspace *workspace;

- (void)changeViewController:(NSInteger)tag;

- (IBAction)switchWorkspaceState:(id)sender;


@end
