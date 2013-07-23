//
//  HCAppsTableToolbar.m
//  catalog-helper
//
//  Created by Andreas Pohle on 15.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCAppsTableToolbar.h"

@implementation HCAppsTableToolbar

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setWantsLayer:YES];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(dirtyRect.origin.x, dirtyRect.origin.y, dirtyRect.size.width, dirtyRect.size.height);
    
    NSColor *color1 = [[HCColorProvider sharedColorProvider] gradientGray1];
    NSColor *color2 = [[HCColorProvider sharedColorProvider] gradientGray1];
    //NSColor *color3 = NSColorPanelGrayModeMask
    
    gradient.colors = @[ (id)color2.CGColor, (id)color1.CGColor ];
        [[self layer] insertSublayer:gradient atIndex:0];
}


@end
