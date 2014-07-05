//
//  Tweet.h
//  Twitter
//
//  Created by Smitha Chepuri on 7/3/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "ResponseObject.h"

@interface Tweet : ResponseObject

@property (nonatomic, strong, readonly) NSString *text;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;


@property (nonatomic,strong, readonly) NSString *retweeted;



@end
