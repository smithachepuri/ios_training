//
//  ResponseObject.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/2/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "ResponseObject.h"

@implementation ResponseObject


- (id)initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
    }
    
    return self;
}

- (id)objectForKey:(id)key {
    return [_data objectForKey:key];
}

- (id)valueOrNilForKeyPath:(NSString *)keyPath {
    return nil;
    //return [_data valueOrNilForKeyPath:keyPath];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([_data respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:_data];
    else
        [super forwardInvocation:anInvocation];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector] || [_data respondsToSelector:aSelector])
        return YES;
    
    return NO;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:selector];
    
    if (sig == nil)
        sig = [[_data class] instanceMethodSignatureForSelector:selector];
    
    return sig;
}



@end
