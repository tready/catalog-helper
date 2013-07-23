//
//  HCAppDelegate.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCAppDelegate.h"


@implementation HCAppDelegate

@synthesize mainview;
@synthesize appView;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
//    CALayer *viewLayer = [CALayer layer];
//    [viewLayer setBackgroundColor: (__bridge CGColorRef)([[HCColorProvider sharedColorProvider] color3])]; //RGB plus Alpha Channel
//    [[self mainview] setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
//    [[self mainview] setLayer:viewLayer];
//    
    
    //mainview.layer.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 0.9);
    id transformer = [[HCBottomStateImageTransformer alloc] init];
    [NSValueTransformer setValueTransformer:transformer forName:@"HCBottomStateImageTransformer"];
    [NSValueTransformer setValueTransformer:[[HCStateImageTransformer alloc] init] forName:@"HCStateImageTransformer"];
    
    [[self appView] setWantsLayer:YES];
    
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints"];
}

@end
