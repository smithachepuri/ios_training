//
//  CreateTweetViewController.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/7/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "CreateTweetViewController.h"

@interface CreateTweetViewController ()

@end

@implementation CreateTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title =@"Create Tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStyleBordered target:self action:@selector(onTweetButton)];
    
}

- (void)onTweetButton {
    [self persistTweet];
}

-(void)persistTweet {
    
    NSLog(@"Inside persist tweet method");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
