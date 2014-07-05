//
//  ResponseObject.h
//  Twitter
//
//  Created by Smitha Chepuri on 7/2/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseObject : NSObject

- (id)initWithDictionary:(NSDictionary *)data;

@property (nonatomic, strong) NSDictionary *data;

@end

@interface ResponseObject (ForwardedMethods)

- (id)objectForKey:(id)key;
- (id)valueOrNilForKeyPath:(NSString *)keyPath;

@end
