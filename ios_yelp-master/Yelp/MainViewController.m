//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "YelpViewCell.h"
#import "UIImageView+AFNetworking.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController ()

@property (nonatomic, strong) YelpClient *client;

@property (strong, nonatomic) IBOutlet UITableView *yelpTableView;

@property (strong, nonatomic) NSMutableAttributedString *results;



@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            //NSLog(@"respo.nse: %@", response);
           // self.results = [[NSMutableArray alloc] init];
            
            self.results = [response mutableCopy];
            
            NSLog(@"self.results from the initWithNib %@",self.results);
            // self.results = response;
            // NSLog(@"search results  from initwithnibnmae%@", self.results);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
        
                self.title = @"Yelp";
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    self.yelpTableView.delegate =self;
    self.yelpTableView.dataSource =self;
    
    [self.yelpTableView reloadData ];
    [self.yelpTableView registerNib:[UINib nibWithNibName:@"YelpViewCell" bundle:nil] forCellReuseIdentifier:@"YelpCell"];
    
    
    NSLog(@"inside viewDidLoad and results %@",self.results);
    
}



-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"count of records =%i",self.results.count);
   // return self.results.count;
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YelpViewCell *yelpCell =[tableView dequeueReusableCellWithIdentifier:@"YelpCell"];
   // NSLog(@"cell For RowAt Index path :%d", indexPath.row);
    
 // NSLog(@"search results from inside cellForRowatindexPath = %@",self.results);
     //  NSDictionary *searchRes = self.results[indexPath.row] ;
   // NSLog(@"searchResult for the given row %@",searchRes);
    //yelpCell.title.text =searchRes[@"businesses"][@"id"];
    //NSLog(@"title Text @",yelpCell.title.text);
   //NSURL *url = [NSURL URLWithString:searchRes[@"image_url"]];
    
  // [yelpCell.posterImage setImageWithURL:url];
   
    return yelpCell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
