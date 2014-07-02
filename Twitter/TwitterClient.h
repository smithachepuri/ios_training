//
//  TwitterClient.h
//  Twitter
//
//  Created by Smitha Chepuri on 7/1/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBOAuth1RequestOperationManager.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) instance;

-(void)login;

-(AFHTTPRequestOperation *)homeTimeline;

@end
