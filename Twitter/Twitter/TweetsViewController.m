//
//  TweetsViewController.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/2/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "TweetsViewController.h"
#import "Tweet.h"
#import "User.h"
#import "TwitterClient.h"

@interface TweetsViewController ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (void)onSignOutButton;
- (void)reload;

@end

@implementation TweetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    
    [self reload];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    Tweet *tweet = self.tweets[indexPath.row];
    cell.textLabel.text = tweet.text;
    
    return cell;
}


- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSLog(@"response object %@", responseObject);
        self.tweets = [Tweet tweetsWithArray:responseObject];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error when getting the response %@",[error description]);
    }];
    
    
  }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
