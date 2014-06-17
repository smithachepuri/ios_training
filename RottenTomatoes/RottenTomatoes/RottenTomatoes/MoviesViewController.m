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
#import "ErrorViewCell.h"

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
// Do any additional setup after loading the view from its nib.
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ErrorViewCell" bundle:nil] forCellReuseIdentifier:@"ErrorCell"];

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self loadMoviesList];
    
//    self.tableView.rowHeight=125;
    
    
}

-(void)loadMoviesList{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.networkFailure) return 60;
    return 125.0;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.networkFailure) return 1;
    return self.movies.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.networkFailure) {
        ErrorViewCell *errorCell =[tableView dequeueReusableCellWithIdentifier:@"ErrorCell"];

        //ErrorViewCell *errorCell = [[ErrorViewCell alloc] init];
        //[errorCell setText:@"Network Error.Please try later"];
        //errorCell set
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
    
   // [cell.posterView setImageWithURL:url];
    [cell.posterView setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.posterView.image =image;
        cell.posterView.alpha = 0;
        [UIView beginAnimations:@"fadeIn" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:5];
        
        cell.posterView.alpha = 1;
        [UIView commitAnimations];

                
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Unable to get the image and the animation associated");
    }
    
     ];


    //cell.posterView.image =
    //cell.textLabel.text = movie[@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailsViewController *mvc = [[MovieDetailsViewController alloc] init];
    mvc.movieDetailtitle = self.movies[indexPath.row][@"title"];
    mvc.details = self.movies[indexPath.row][@"synopsis"];
    mvc.moviePosterURL  = self.movies[indexPath.row][@"posters"][@"original"];
    [self.navigationController pushViewController:mvc animated:YES];
    

}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
      [self loadMoviesList];
}





@end
