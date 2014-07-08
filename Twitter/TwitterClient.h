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

-(AFHTTPRequestOperation *)homeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


-(AFHTTPRequestOperation *)updateTweetsWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure parameters:(NSMutableDictionary*)params;


-(AFHTTPRequestOperation *)userWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                                parameters:(NSMutableDictionary*)params;


@end
