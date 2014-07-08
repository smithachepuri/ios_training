//
//  ComposeViewController.m
//  Twitter
//
//  Created by Smitha Chepuri on 7/6/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "ComposeViewController.h"
#import "ComposeViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ComposeViewController ()

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)onclickOfTweet:(id)sender;

- (IBAction)onClickOfCancel:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title =@"Compose a new tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSLog(@"Inside viewDidLoad COmponseViewController");
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ComposeViewCell" bundle:nil] forCellReuseIdentifier:@"ComposeViewCell"];
    

    /*
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, 1026, 50)];
    [self.navBar setTintColor:[UIColor clearColor]];
    [self.navBar setBackgroundColor:[UIColor redColor]];
    [self.navBar setDelegate:self];
    [self.view addSubview:self.navBar];
    UIBarButtonItem *bi1 = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStyleBordered target:self action:@selector(onclickOfTweet)];
    
    bi1.style = UIBarButtonItemStyleBordered;
    
    bi1.tintColor =[UIColor colorWithWhite:0.305f alpha:0.0f];
    
    //self.navigationItem.rightBarButtonItem = bi1;
    */
 
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"cell For RowAt Index path :%d", indexPath.row);
    ComposeViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ComposeViewCell"];
    NSURL *url = [NSURL URLWithString:self.posterImage];
    [cell.imageView setImageWithURL:url];
    [cell.textInput setText: [NSString stringWithFormat:@"@%@",self.replyTo]];
   
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onclickOfTweet:(id)sender {
    NSLog(@"Need to persist the data, %@", sender);
   NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
   //NSIndexPath *indexPath = [[NSIndexPath alloc]initWithIndex:0];
    
   // NSIndexPath *path = [[NSIndexPath alloc]init];
 
    //[self.tableView cellForRowAtIndexPath:indexPath] ;
    
    NSLog(@"self.tableView cellForRow %@", [[(ComposeViewCell*)[self.tableView cellForRowAtIndexPath:indexPath] textInput] text]);
    NSString *textInput =[[(ComposeViewCell*)[self.tableView cellForRowAtIndexPath:indexPath] textInput] text];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:textInput forKey:@"status"];
    [[TwitterClient instance] updateTweetsWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"response object after update Tweets %@", responseObject);
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error when getting the response %@",[error description]);
    } parameters:dict];
}





- (IBAction)onClickOfCancel:(id)sender {
}
@end
