//
//  HCWorkspaceViewHelper.h
//  catalog-helper
//
//  Created by Andreas Pohle on 16.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCWorkspaceViewHelper : NSObject

@property (nonatomic, readwrite) BOOL blockedForAddProcess;

+(HCWorkspaceViewHelper *) sharedViewHelper;

@end
