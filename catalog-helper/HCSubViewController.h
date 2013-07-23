//
//  HCSubViewController.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HCParentControllerDelegate.h"

@interface HCSubViewController : NSViewController

@property(nonatomic, assign) id<HCParentControllerDelegate> delegate;

@end
