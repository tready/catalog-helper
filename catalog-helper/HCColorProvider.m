//
//  HCColorProvider.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCColorProvider.h"

@implementation HCColorProvider


static HCColorProvider *sharedColorProvider = nil;

+(HCColorProvider *) sharedColorProvider
{
    if (sharedColorProvider == nil) {
        sharedColorProvider = [[super allocWithZone:NULL] init];
    }
    return sharedColorProvider;
}


+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedColorProvider];
}


- (id)init
{
    self = [super init];
    if (self) {
        self.color1 = [NSColor colorWithDeviceRed:(43.0/256.0)
                                            green:(50.0/256.0)
                                             blue:(51.0/256.0)
                                            alpha:1];
        self.color2 = [NSColor colorWithDeviceRed:(78.0/256.0)
                                            green:(85.0/256.0)
                                             blue:(86.0/256.0)
                                            alpha:1];
        self.color3 = [NSColor colorWithDeviceRed:(125.0/256.0)
                                            green:(129.0/256.0)
                                             blue:(129.0/256.0)
                                            alpha:1];
        self.color4 = [NSColor colorWithDeviceRed:(193.0/256.0)
                                            green:(201.0/256.0)
                                             blue:(202.0/256.0)
                                            alpha:1];
        self.color5 = [NSColor colorWithDeviceRed:(255.0/256.0)
                                            green:(255.0/256.0)
                                             blue:(255.0/256.0)
                                            alpha:1];
        self.gradientGray1 = [NSColor colorWithDeviceRed:(235.0/256.0)
                                            green:(235.0/256.0)
                                             blue:(235.0/256.0)
                                            alpha:1];
        self.gradientGray2 = [NSColor colorWithDeviceRed:(178.0/256.0)
                                                   green:(178.0/256.0)
                                                    blue:(178.0/256.0)
                                                   alpha:1];
    }
    return self;
}

@end
