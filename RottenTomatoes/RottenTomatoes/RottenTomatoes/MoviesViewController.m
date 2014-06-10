//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Smitha Chepuri on 6/5/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "MBProgressHUD.h"

@interface MoviesViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property  BOOL networkFailure;


@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Movies";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data !=nil) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", object);
          self.movies =object[@"movies"];

        } else {
            self.networkFailure = YES;
        }
        
        
       [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.tableView.reloadData;
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
//    self.tableView.rowHeight=125;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.networkFailure) return 25;
    return 125.0;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.networkFailure) return 1;
    return self.movies.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.networkFailure) {
        UITableViewCell *errorCell = [[UITableViewCell alloc] init];
       [ errorCell setText:@"Network Error"];
        return errorCell;
    }
    NSLog(@"cell For RowAt Index path :%d", indexPath.row);
    
   MovieCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSDictionary *movie = self.movies[indexPath.row] ;
    cell.movieTitleLabel.text =movie[@"title"];
    cell.synopsisLabel.text =movie[@"synopsis"];
   //NSLog(@"IMage thumbnail values %@", movie[@"posters"][@"original"]);
    
    NSURL *url = [NSURL URLWithString:movie[@"posters"][@"thumbnail"]];
    [cell.posterView setImageWithURL:url];

    
    //cell.posterView.image =
    //cell.textLabel.text = movie[@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"testing  ");
    MovieDetailsViewController *mvc = [[MovieDetailsViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];

}





@end
