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
#import "TweetsCell.h"
#import "UIImageView+AFNetworking.h"
#import "TweetDetailViewController.h"
#import "ComposeViewController.h"

//#import "CreateTweetViewController.h"


@interface TweetsViewController ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;



- (IBAction)onClickOfNew:(id)sender;


- (IBAction)onSignOut:(id)sender;

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
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetsCell" bundle:nil] forCellReuseIdentifier:@"TweetsCell"];
    
    /*
    UINavigationBar *headerView = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,74)];
    UINavigationItem *buttonCarrier = [[UINavigationItem alloc]initWithTitle:@"Sign Out"];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleDone target:self action:@selector(filter)];
    [buttonCarrier setLeftBarButtonItem:cancelButton];
    NSArray *barItemArray = [[NSArray alloc]initWithObjects:buttonCarrier,nil];
    [headerView setItems:barItemArray];
    //[self.tableView setTableHeaderView:headerView];
    
//    self.tableView
    
    [headerView setBarTintColor:[UIColor blueColor]];
    [headerView setTintColor:[UIColor whiteColor]];
    
    
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    
    NSLog(@"self.navigationContro %@",self.navigationController);
     
     
     */
    
    
    // on pull reload the tweets
    //UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
   // [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    //[self.tableView addSubview:refreshControl];

    
    [self reload];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"cell For RowAt Index path :%d", indexPath.row);
    TweetsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"TweetsCell"];
   NSDictionary *tweetsDic = self.tweets[indexPath.row] ;
    cell.screenName.text = tweetsDic[@"user"] [@"screen_name"];
    NSURL *url = [NSURL URLWithString:tweetsDic[@"user"][@"profile_image_url"]];
    [cell.imageView setImageWithURL:url];
    cell.tweetText.text = tweetsDic[@"text"];
    cell.timestamp.text = tweetsDic[@"created_at"];
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Inside didselectrow %@", self.tweets[indexPath.row][@"text"]);
     NSLog(@"Inside didselectrow %@", self.tweets[indexPath.row][@"user"][@"screen_name"]);
    //TweetDetailViewController *detailvc = [[TweetDetailViewController alloc] init];
    
    TweetDetailViewController *detailvc = [[TweetDetailViewController alloc] initWithNibName:@"TweetDetailViewController" bundle:nil];
   
    NSDictionary *tweetsDic = self.tweets[indexPath.row] ;
    detailvc.screenName = tweetsDic[@"user"][@"screen_name"];
   // NSLog(@"screenName from tweetsviewcontrolle %@",detailvc.screenName);
    detailvc.posterImage =tweetsDic[@"user"][@"profile_image_url"];
    detailvc.tweetText = tweetsDic[@"text"];
    detailvc.timestamp = tweetsDic[@"created_at"];
    [self.navigationController pushViewController:detailvc animated:YES];
    
}


- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
      NSLog(@"response object %@", responseObject);
        self.tweets = responseObject;
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



- (IBAction)onClickOfNew:(id)sender {
    
    NSDictionary *tweetsDic = self.tweets[0] ;
    
    
    ComposeViewController *composevc = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    composevc.screenName = tweetsDic[@"user"][@"screen_name"];
    composevc.posterImage = tweetsDic[@"user"][@"profile_image_url"];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:composevc];
     [self.navigationController pushViewController:composevc animated:YES];
    
}

/*
- (IBAction)onClickOfNew:(id)sender {
    
    NSDictionary *tweetsDic = self.tweets[0] ;
    
    
    CreateTweetViewController *composevc = [[ComposeViewController alloc] initWithNibName:@"CreateTweetViewController" bundle:nil];
    composevc.screenName = tweetsDic[@"user"][@"screen_name"];
    composevc.posterImage = tweetsDic[@"user"][@"profile_image_url"];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:composevc];
    [self.navigationController pushViewController:composevc animated:YES];
    
}
*/
- (IBAction)onSignOut:(id)sender {
}

@end
