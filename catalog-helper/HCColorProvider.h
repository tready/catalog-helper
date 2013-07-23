//
//  HCColorProvider.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCColorProvider : NSObject

@property (nonatomic, strong) NSColor *color1;
@property (nonatomic, strong) NSColor *color2;
@property (nonatomic, strong) NSColor *color3;
@property (nonatomic, strong) NSColor *color4;
@property (nonatomic, strong) NSColor *color5;

@property (nonatomic, strong) NSColor *gradientGray1;
@property (nonatomic, strong) NSColor *gradientGray2;

+(HCColorProvider *) sharedColorProvider;

@end
