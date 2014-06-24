//
//  FilterViewController.m
//  Yelp
//
//  Created by Smitha Chepuri on 6/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterViewCell.h"
#import "DealsOnOffCell.h"
#import "FilterOptions.h"

@interface FilterViewController ()
@property (strong, nonatomic) IBOutlet UITableView *filterTableView;
@property (strong, nonatomic) NSDictionary *filters;
@property (strong, nonatomic) NSArray *sectionTitles;

- (IBAction)cancelAction:(id)sender;
- (IBAction)submitAction:(id)sender;


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


/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.filterTableView delegate];
    [self.filterTableView dataSource ];
    
    //register the YelpViewCell
    [self.filterTableView registerNib:[UINib nibWithNibName:@"FilterViewCell" bundle:nil] forCellReuseIdentifier:@"FilterCell"];
    
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:[self getButton:@"Cancel"]];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:[self getButton:@"Search"]];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    
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

*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;
 
    [self.filterTableView registerNib: [UINib nibWithNibName:@"DealsOnOffCell" bundle:nil] forCellReuseIdentifier:@"OnOffCell"];

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)filterTableView
{
    // Return the number of sections.
   // NSLog(@"titles.count %i",self.sectionTitles.count);
   // return [self.sectionTitles count];
    return 3;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Most Popular";
        case 1:
            return @"Sort by";
        case 2:
            return @"Categories";
    }
    return nil;
}




- (NSInteger)tableView:(UITableView *)filterTableView numberOfRowsInSection:(NSInteger)section {
    int rowNumber = 0;
    switch (section) {
    
        case 0:
            rowNumber =  1;
            break;
        case 1:
            rowNumber =4;
            break;
        case 2:
            rowNumber = 5;
            break;
    }
    return rowNumber;
}


- (UITableViewCell *)tableView:(UITableView *)filterTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSString *label = nil;
    FilterViewCell *cell = [self.filterTableView dequeueReusableCellWithIdentifier:@"FilterCell"];
    DealsOnOffCell *onOffCell = [self.filterTableView dequeueReusableCellWithIdentifier:@"OnOffCell"];
    
    
    switch (section) {
        case 0:
        {
            //DealsOnOffCell *onOffCell = [self.filterTableView dequeueReusableCellWithIdentifier:@"OnOffCell"];
            switch (row) {
                case 0:
                    label  = @"Offering a deal";
                    break;
                case 1:
                    label = @"Hot and New";
                    break;
            }
             onOffCell.textLabel.text = label;
            
        
        }
        /*
        case 1:
        {
            //DealsOnOffCell *onOffCell = [self.filterTableView dequeueReusableCellWithIdentifier:@"OnOffCell"];
            switch (row) {
                case 0:
                    label  = @"BestMatch";
                    break;
                case 1:
                    label = @"Hot and New";
                    break;
            }
            onOffCell.textLabel.text = label;
            
            
        }
         */
            
    }
    
    return onOffCell;
}


- (IBAction)cancelAction:(id)sender {
    
    
}

- (IBAction)submitAction:(id)sender {
    
    NSLog(@"Inside submit Action");
    FilterOptions *options =[[FilterOptions alloc]init ];
    options.isDealAvailable = YES;
    
    [self.delegate searchWithFilterOption:options];
    [self dismissViewControllerAnimated:YES completion:^{
        options.isDealAvailable = YES;
    }];
    
    
}
@end
