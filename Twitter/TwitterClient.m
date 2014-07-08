//
//  TwitterClient.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/1/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "TwitterClient.h"

@implementation TwitterClient


+ (TwitterClient *) instance {
    static TwitterClient *instance =nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance
        = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com"] consumerKey:@"WcznQ00KKfQtx6zvvUVyD4Tgg" consumerSecret:@"ul7ipGrxyiFhuOsfevH6sttVQlqJFiibw6QyOPVHh8Zs3famj8"];
    });
    
    return instance;
}


-(void) login {
    [self.requestSerializer removeAccessToken];
    
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString:@"cptwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"Got the request token");
        
        NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
     
    } failure:^(NSError *error) {
        NSLog(@"Error when getting the request token, %@", error);
    }];
    
}


-(AFHTTPRequestOperation *)homeTimelineWithSuccess: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:success failure:failure];
}




-(AFHTTPRequestOperation *)updateTweetsWithSuccess: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                                        parameters:(NSMutableDictionary*)params
{
    NSLog(@"Inside the updateTweets %@", params);
    
   return [self POST:@"1.1/statuses/update.json" parameters:params success:success
       failure:failure];
    
    
}

-(AFHTTPRequestOperation *)userWithSuccess: (void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                                parameters:(NSMutableDictionary*)param
{
    return [self GET:@"1.1/users/show.json" parameters:param success:success failure:failure];
}




@end
