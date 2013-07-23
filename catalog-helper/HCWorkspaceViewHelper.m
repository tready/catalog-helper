//
//  HCWorkspaceViewHelper.m
//  catalog-helper
//
//  Created by Andreas Pohle on 16.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCWorkspaceViewHelper.h"

@implementation HCWorkspaceViewHelper

@synthesize blockedForAddProcess;


static HCWorkspaceViewHelper *sharedViewHelper = nil;

+(HCWorkspaceViewHelper *)sharedViewHelper
{
    if (sharedViewHelper == nil) {
        sharedViewHelper = [[super allocWithZone:nil] init];
    }
    return sharedViewHelper;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedViewHelper];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setValue:@NO forKey:@"blockedForAddProcess"];
    }
    return self;
}

@end
