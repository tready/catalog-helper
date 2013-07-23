//
//  HCParentControllerDelegate.h
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HCParentControllerDelegate

-(void)initialisationDidFinish:(id)sender;
-(void)initCloseWorkspace;

@end
