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

@end
