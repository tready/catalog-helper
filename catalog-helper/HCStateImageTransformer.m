//
//  HCStateImageTransformer.m
//  catalog-helper
//
//  Created by Andreas Pohle on 14.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCStateImageTransformer.h"

@implementation HCStateImageTransformer

+(Class)transformedValueClass
{
    return [NSString self];
}

+(BOOL)allowsReverseTransformation
{
    return NO;
}

-(id)transformedValue:(id)value
{
    if (value == nil) return nil;
    BOOL state = [value boolValue];
    
    if (state) {
        return [NSImage imageNamed:@"checkmark"];
    } else {
        return [NSImage imageNamed:@"warning"];
    }
    return nil;

}

@end
