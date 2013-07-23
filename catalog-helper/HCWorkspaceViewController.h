//
//  HCWorkspaceViewController.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HCSubViewController.h"
#import "HCColorProvider.h"
#import "HCWorkspaceViewHelper.h"

@interface HCWorkspaceViewController : HCSubViewController

@property (nonatomic, strong) HCColorProvider* colorProvider;

@end
