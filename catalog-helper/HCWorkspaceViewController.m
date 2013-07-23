//
//  HCWorkspaceViewController.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCWorkspaceViewController.h"

@interface HCWorkspaceViewController ()

@end

@implementation HCWorkspaceViewController

@synthesize colorProvider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setColorProvider:[HCColorProvider sharedColorProvider]];
        [[self view] setWantsLayer:YES];
    }
    
    return self;
}

@end
