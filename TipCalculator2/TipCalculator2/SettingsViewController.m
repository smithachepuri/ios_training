//
//  SettingsViewController.m
//  TipCalculator2
//
//  Created by Smitha Chepuri on 6/3/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tip1Amount;
- (IBAction)apply:(id)sender;

@end

@implementation SettingsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)apply:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Int value for tip1 %@i ",self.tip1Amount.text);
    [defaults setInteger:[self.tip1Amount.text intValue] forKey:@"tipControl1"];
    [defaults synchronize];
}
@end
