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
        = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com"] consumerKey:@"ey0U9JM3BgEum0oNyK04frJko" consumerSecret:@"XF8jcUtmTc3gJAaSvODZi6DeKkqskpOPbnpgALjDL4zfy4Jwzv"];
    });
    
    return instance;
}


-(void) login {
    
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString:@"cptwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"Got the request token");
        
        NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
     
    } failure:^(NSError *error) {
        NSLog(@"Error when getting the request token");
    }];
    
}

-(AFHTTPRequestOperation *)homeTimeline {
    return [self GET:<#(NSString *)#> parameters:<#(id)#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>]
}

@end
