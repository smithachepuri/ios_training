//
//  ComposeViewCell.h
//  Twitter
//
//  Created by Smitha Chepuri on 7/7/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

@property (strong, nonatomic) IBOutlet UILabel *screenName;
- (IBAction)onEndEditing:(id)sender;



@property (strong, nonatomic) IBOutlet UITextField *textInput;


@end
