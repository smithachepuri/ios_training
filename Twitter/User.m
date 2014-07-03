//
//  User.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/2/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "User.h"

@implementation User
static User *currentUser =nil;


+(User *)currentUser {
    
    if(currentUser ==nil) {
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"current_user"];
        if(dict) {
            currentUser = [[User alloc] initWthDictionary:dict] ;
        }
                           
        
    }
    
    return currentUser;
}

+(void)setCurrentUser:(User *)user {
    currentUser =user;
}


@end
