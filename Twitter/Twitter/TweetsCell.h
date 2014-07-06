//
//  TweetsCell.h
//  Twitter
//
//  Created by Smitha Chepuri on 7/4/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *screenName;
@property (strong, nonatomic) IBOutlet UILabel *twitterId;
@property (strong, nonatomic) IBOutlet UILabel *tweetText;

@end
