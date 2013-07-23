//
//  HCBottomStateImageTransformer.m
//  catalog-helper
//
//  Created by Andreas Pohle on 12.07.13.
//  Copyright (c) 2013 Andreas Pohle. All rights reserved.
//

#import "HCBottomStateImageTransformer.h"

@implementation HCBottomStateImageTransformer

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
        return [NSImage imageNamed:@"shut_down"];
    } else {
        return [NSImage imageNamed:@"target"];
    }
    return nil;
}


@end
