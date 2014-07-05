//
//  User.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/2/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

@implementation User
static User *_currentUser =nil;
NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";


+ (User *)currentUser {
    if (!_currentUser) {
        NSData *userData = [[NSUserDefaults standardUserDefaults] dataForKey:@"current_user"];
        if (userData) {
            NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
            _currentUser = [[User alloc] initWithDictionary:userDictionary];
        }
    }
    
    return _currentUser;
}

+ (void)setCurrentUser:(User *)currentUser {
    if (currentUser) {
        NSData *userData = [NSJSONSerialization dataWithJSONObject:currentUser.data options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"current_user"];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"current_user"];
       // TwitterClient *client = [TwitterClient instance];
        //[client.requestSerializer removeAccessToken];
 
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (!_currentUser && currentUser) {
        _currentUser = currentUser;
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:nil];
    } else if (_currentUser && !currentUser) {
        _currentUser = currentUser;
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
    }
}


@end
