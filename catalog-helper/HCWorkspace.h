//
//  HCWorkspace.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCWorkspaceFolder.h"


@interface HCWorkspace : NSObject

@property (nonatomic, readwrite) BOOL initialized;
@property (nonatomic, readwrite) BOOL initProcessFinished;
@property (nonatomic, readwrite) BOOL appsFolderDetected;
@property (nonatomic, readwrite) BOOL containersFolderDetected;

@property (nonatomic, readwrite, copy) NSString *path;
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, strong) HCWorkspaceFolder *appsFolder;
@property (nonatomic, strong) HCWorkspaceFolder *containersFolder;

+(HCWorkspace *) sharedWorkspace;

-(void)checkInitalized;
-(void)reset;


@end
