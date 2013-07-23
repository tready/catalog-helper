//
//  HCApplicationController.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCApplicationController.h"

@implementation HCApplicationController

@synthesize appView;
@synthesize workspace;
@synthesize bottomPathLabel;

enum {
    hcHomeViewTag = 0,
    hcWorkspaceViewTag
};

NSString *const hcHomeView = @"HCHomeViewController";
NSString *const hcWorkspaceView = @"HCWorkspaceViewController";


- (id)init
{
    self = [super init];
    if (self) {
        [self setValue:[HCWorkspace sharedWorkspace] forKey:@"workspace"];
        [[[self bottomPathLabel] cell] setBackgroundStyle:NSBackgroundStyleLowered];
        //appView.layer.backgroundColor = CGColorCreateGenericRGB(0.2, 0.5, 0, 1);
        
        NSString *path = [[NSBundle mainBundle] resourcePath];
        NSLog(@"path: %@", path);
        NSString *xmlPath = [path stringByAppendingPathComponent:@"index-coffee.txt"];
        NSLog(@"xmlPath: %@", xmlPath);
        NSString *xmlString = [NSString stringWithContentsOfFile:xmlPath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@", xmlString);
    }
    return self;
}

-(void)awakeFromNib
{
    [self changeViewController:hcHomeViewTag];
}


- (IBAction)switchWorkspaceState:(id)sender {
    
    if ([[HCWorkspace sharedWorkspace] initialized] == NO) {
        NSLog(@"switchWorkspaceState: %@", @"select");
        [[HCWorkspaceHelper sharedWorkspaceHelper] selectWorkspace];
    } else {
        NSLog(@"switchWorkspaceState: %@", @"close");
        [[HCWorkspaceHelper sharedWorkspaceHelper] closeWorkspace];
        [self changeViewController:hcHomeViewTag];
    }
    
}

-(void)changeViewController:(NSInteger)tag
{
    [[[self appViewController] view] removeFromSuperview];
    
    switch (tag) {
        case hcHomeViewTag:
            [self setAppViewController: [[HCHomeViewController alloc] initWithNibName:hcHomeView bundle:nil]];
            break;
        case hcWorkspaceViewTag:
            [self setAppViewController: [[HCWorkspaceViewController alloc] initWithNibName:hcWorkspaceView bundle:nil]];
            break;
    }
    
    [[self appView] addSubview:[[self appViewController] view]];
    [[self appViewController] setDelegate:self];
    
    [[[self appViewController] view] setFrame:[[self appView] bounds]];
    [[[self appViewController] view] setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];

}

-(void)initialisationDidFinish:(id)sender
{
    NSLog(@"initialisationDidFinish: %@", [sender className]);
    [self changeViewController:hcWorkspaceViewTag];
}

-(void)initCloseWorkspace
{
    
}

@end
