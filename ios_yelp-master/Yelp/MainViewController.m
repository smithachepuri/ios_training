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
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController ()

@property (nonatomic, strong) YelpClient *client;

@property (strong, nonatomic) IBOutlet UITableView *yelpTableView;

@property (strong, nonatomic) NSMutableArray *results;



@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    }
    return self;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"the search bar text changed");
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSLog(@"Search bar entered %@",searchBar.text);
    [self loadSearchResults:searchBar.text];
}

-(void) loadSearchResults:(NSString *)searchTerm {
    //default search on load
    [self.client searchWithTerm:searchTerm success:^(AFHTTPRequestOperation *operation, id response) {
        self.results = [response[@"businesses"] mutableCopy];
        NSLog(@"self.results from the initWithNib %@",self.results);
        [self.yelpTableView reloadData ];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //search bar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(1.0, 0.0, 300.0, 44.0)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.barTintColor= [UIColor redColor];
 
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 44.0)];
    searchBarView.autoresizingMask = 0;
    searchBar.delegate = self;
    [searchBarView addSubview:searchBar];
    self.navigationItem.titleView = searchBarView;
    
    
    //Filter Button
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Filter" forState:UIControlStateNormal];
    button.frame = CGRectMake(1.0, 10.0, 100.0, 44.0);
    [self.yelpTableView addSubview:button];
    
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Filter"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(flipView)];
    self.navigationItem.leftBarButtonItem = flipButton;
   */
    
    
    //delegate and datasource
    self.yelpTableView.delegate =self;
    self.yelpTableView.dataSource =self;
    
    
    //register the YelpViewCell
    [self.yelpTableView registerNib:[UINib nibWithNibName:@"YelpViewCell" bundle:nil] forCellReuseIdentifier:@"YelpCell"];
    
    [self loadSearchResults:@"Asian"];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
        //self.navigationItem.leftBarButtonItem initWith
    
}

- (void)onFilterButton {
    [self.navigationController pushViewController:[[FilterViewController alloc] init] animated:YES];
}


-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count of records =%i",self.results.count);
   return self.results.count;
   // return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YelpViewCell *yelpCell =[tableView dequeueReusableCellWithIdentifier:@"YelpCell"];
    NSLog(@"results indexPath %i", indexPath.row);
    NSDictionary *searchRes = self.results[indexPath.row] ;
    NSString *id =searchRes[@"id"];
    yelpCell.title.text = [id capitalizedString];
    NSURL *url = [NSURL URLWithString:searchRes[@"image_url"]];
    [yelpCell.posterImage setImageWithURL:url];
    NSString *address =searchRes[@"location"][@"address"][0];
    NSArray *nghbrList = searchRes[@"location"][@"neighborhoods"];
    NSString *nghbrhoods = nghbrList[0];
    address = [address stringByAppendingString:@", " ];
    address = [address stringByAppendingString:nghbrhoods];
    yelpCell.address.text= address;
    NSURL *ratingurl = [NSURL URLWithString:searchRes[@"rating_img_url_small"]];
   [yelpCell.ratingImg setImageWithURL:ratingurl];
   yelpCell.reviewsCount.text = [NSString stringWithFormat:@"%@", searchRes[@"review_count"]];
    yelpCell.reviewsCount.text = [ yelpCell.reviewsCount.text stringByAppendingString:@" Reviews"];
    yelpCell.distance.text = @"0.0";   //searchRes[@"distance"];
    yelpCell.price.text = @"$$";
    NSArray *cateList = searchRes[@"categories"][0];
   yelpCell.cuisine.text =  cateList[0];// [cateList componentsJoinedByString:@" "];
    return yelpCell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) searchWithFilterOption:(FilterOptions *)filterOption {
   // filterOption.isDealAvailable
    NSLog(@"this method is called from Mainview");
    
}

@end
