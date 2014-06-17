//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Smitha Chepuri on 6/9/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@property (weak, nonatomic) IBOutlet UILabel *movieDetails;

@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation MovieDetailsViewController

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
    
    
    NSLog(self.movieDetailtitle);
    [self.movieTitle setText:self.movieDetailtitle];
      [self.movieDetails setText:self.details];
    
    NSURL *url = [NSURL URLWithString:self.moviePosterURL];
    
    [self.moviePoster setImageWithURL: url];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.scrollview layoutIfNeeded];
    self.scrollview.contentSize = self.contentView.bounds.size;
}


@end
