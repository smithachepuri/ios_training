//
//  FilterViewController.m
//  Yelp
//
//  Created by Smitha Chepuri on 6/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterViewCell.h"

@interface FilterViewController ()
@property (strong, nonatomic) IBOutlet UITableView *filterTableView;
@property (strong, nonatomic) NSDictionary *filters;
@property (strong, nonatomic) NSArray *sectionTitles;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title= @"Filters";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.filterTableView delegate];
    [self.filterTableView dataSource ];
    
    //register the YelpViewCell
    [self.filterTableView registerNib:[UINib nibWithNibName:@"FilterViewCell" bundle:nil] forCellReuseIdentifier:@"FilterCell"];
    
    
    self.filters = @{@"Most Popular" : @[@"Offering a Deal", @"Hot and New"],
                @"distance" : @[@"radius"],
                @"Sort By" : @[@"sorting"]};
    
    
    NSLog(@"self filters count %i",self.filters.count);
                     
    
   // self.sectionTitles = [[self.filters allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.sectionTitles = [self.filters allKeys];
    NSLog(@"section titles %@" , self.sectionTitles);
    NSLog(@"count of filters %i",self.sectionTitles.count);
   [self.filterTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"titles.count %i",self.sectionTitles.count);
   // return [self.sectionTitles count];
    return 20;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"testing ");
    return [self.sectionTitles objectAtIndex:section];
}




-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:section];
    NSArray *sectionfilters = [self.filters objectForKey:sectionTitle];
    NSLog(@"sectionfilters count %i",sectionfilters.count);
    return [sectionfilters count];
     //return 20;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FilterViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FilterCell"];
    
    // Configure the cell...
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionfilters = [self.filters objectForKey:sectionTitle];
    NSString *filter = [sectionfilters objectAtIndex:indexPath.row];
    cell.textLabel.text = filter;
    //cell.imageView.image = [UIImage imageNamed:[self getImageFilename:animal]];
    
    
    
    return cell;
}




@end
