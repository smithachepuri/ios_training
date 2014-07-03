//
//  User.h
//  Twitter
//
//  Created by Smitha Chepuri on 7/2/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseObject.h"

@interface User : ResponseObject


+(User *) currentUser;
+ (void)setCurrentUser:(User *) user;

@end
