//
//  YelpViewCell.h
//  Yelp
//
//  Created by Smitha Chepuri on 6/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YelpViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *posterImage;

@property (strong, nonatomic) IBOutlet UIImageView *ratingImg;

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *distance;

@property (strong, nonatomic) IBOutlet UILabel *reviewsCount;

@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *cuisine;

@end
