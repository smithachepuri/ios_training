//
//  Tweet.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/3/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet



+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
    
}





@end
