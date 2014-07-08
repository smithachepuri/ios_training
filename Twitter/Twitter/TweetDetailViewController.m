//
//  TweetDetailViewController.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/6/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "TwitterClient.h"

@interface TweetDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profileImage;


@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *text;
@property (strong, nonatomic) IBOutlet UILabel *time;

- (IBAction)onClickReply:(id)sender;

- (IBAction)onClickRetweet:(id)sender;
- (IBAction)onClickFav:(id)sender;

@end

@implementation TweetDetailViewController

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
    
    
   // UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:self];
    //[self presentModalViewController: navController animated:YES];
    //[self.window addSubview:navController.view];
    
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    
    NSLog(@"inside detailView");
    NSLog(@"screeNName %@",self.screenName1);
        NSLog(@"time %@",self.timestamp);
    
    [self.name setText:self.screenName1];
    [self.text setText:self.tweetText];
    [self.time setText:self.timestamp];

    
    
    NSURL *url = [NSURL URLWithString:self.posterImage];
    
    [self.profileImage setImageWithURL: url];
    

}


-(void)onTweetButton {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickReply:(id)sender {
    
    NSLog(@"On REploy clicked");
    
    ComposeViewController *composevc = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"smithac07" forKey:@"screen_name"];
    [[TwitterClient instance] userWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response object for user %@", responseObject);
        composevc.scrnName = @"Smitha";//responseObject[@"name"];
        composevc.replyTo= self.screenName1;
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:composevc];
        [self.navigationController pushViewController:composevc animated:YES];
        
        // composevc.posterImage = responseObject[@"profile_image_url"];
        //NSLog(@"screenName %@",responseObject)
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error when getting the response %@",[error description]);
    }parameters: dict];

    
    
    
    
}

- (IBAction)onClickRetweet:(id)sender {
    NSLog(@"On Retweet clicked");
}

- (IBAction)onClickFav:(id)sender {
    NSLog(@"On Favorite clicked");
}
@end
