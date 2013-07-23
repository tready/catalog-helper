//
//  HCWorkspaceHelper.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCDebug.h"
#import "HCWorkspace.h"
#import "HCWorkspaceFolder.h"

@interface HCWorkspaceHelper : NSObject 

@property (nonatomic, readwrite) BOOL blockedForAddProcess;

@property (assign) HCWorkspace *sharedWorkspace;

+(HCWorkspaceHelper *) sharedWorkspaceHelper;


-(void) selectWorkspace;
-(void) closeWorkspace;
-(BOOL)checkIfEntryNameExist:(NSString *)entryName;

-(BOOL)createNewFolderEntry:(NSString *)path withName:(NSString *)name;

@end
