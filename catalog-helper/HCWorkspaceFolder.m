//
//  HCWorkspaceFolder.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCWorkspaceFolder.h"

@implementation HCWorkspaceFolder

@synthesize workspaceFolder;
@synthesize name;
@synthesize path;
@synthesize subfolders;
@synthesize workspaceFolderTyp;


- (id)init
{
    self = [super init];
    if (self) {
        [self setValue:[NSMutableArray array] forKey:@"subfolders"];
        [self setValue:@YES forKey:@"workspaceFolder"];
        [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"name"]) {
        if ([[self name] rangeOfString:@"Element"].location != NSNotFound)
        {
            [self setValue:@"Element" forKey:@"workspaceFolderTyp"];
        } else if ([[self name] rangeOfString:@"Module"].location != NSNotFound) {
            [self setValue:@"Module" forKey:@"workspaceFolderTyp"];
        }
        [self removeObserver:self forKeyPath:@"name"];
    }
}

-(void)addSubFolder:(HCWorkspaceFolder *)subFolder
{
    [self willChangeValueForKey:@"subfolders"];
    [[self subfolders] addObject:subFolder];
    [self didChangeValueForKey:@"subfolders"];
}


@end
