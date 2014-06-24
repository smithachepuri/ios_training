//
//  FilterViewController.h
//  Yelp
//
//  Created by Smitha Chepuri on 6/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterOptions.h"

@protocol FilterViewControllerDelegate <NSObject>
- (void)searchWithFilterOption:(FilterOptions *)fiterOption;
@end

@interface FilterViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *cancel;
@property (strong, nonatomic) IBOutlet UIButton *search;
@property (weak, nonatomic) id<FilterViewControllerDelegate> delegate;

@end
