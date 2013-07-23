//
//  HCHomeViewController.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCHomeViewController.h"

@interface HCHomeViewController ()

@end

@implementation HCHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)selectWorkspace:(id)sender {
    [[HCWorkspaceHelper sharedWorkspaceHelper] selectWorkspace];
}

- (IBAction)openSelectedWorkspace:(id)sender {
    [[self delegate] initialisationDidFinish:self];
}
@end
