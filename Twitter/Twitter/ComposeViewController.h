//
//  ComposeViewController.h
//  Twitter
//
//  Created by Smitha Chepuri on 7/6/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) NSString *posterImage;

@property (weak, nonatomic) NSString  *scrnName;

@property (weak, nonatomic) NSString  *replyTo;

@end
