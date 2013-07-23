//
//  HCWorkspaceFolder.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCWorkspaceFolder : NSObject

@property (nonatomic, readwrite) BOOL workspaceFolder;
@property (nonatomic, readwrite, copy) NSString* path;
@property (nonatomic, readwrite, copy) NSString* workspaceFolderTyp;
@property (nonatomic, readwrite, copy) NSString* name;
@property (nonatomic, readwrite) NSMutableArray* subfolders;

-(void)addSubFolder:(HCWorkspaceFolder *)subFolder;

@end
