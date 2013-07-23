//
//  HCAppDelegate.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "HCColorProvider.h"
#import "HCBottomStateImageTransformer.h"
#import "HCStateImageTransformer.h"


@interface HCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSView *mainview;
@property (weak) IBOutlet NSView *appView;

@end
