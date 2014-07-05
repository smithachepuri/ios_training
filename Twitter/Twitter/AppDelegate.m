//
//  AppDelegate.m
//  Twitter
//
//  Created by Smitha Chepuri on 6/30/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "User.h"



@interface AppDelegate ()

- (void)updateRootVC;

@property (nonatomic, strong) LoginViewController *loginVC;
@property (nonatomic, strong) TweetsViewController *tweetsVC;
@property (nonatomic, strong) UIViewController *currentVC;

@end





@implementation NSURL (dictionaryFromQueryString)


- (NSDictionary *)dictionaryFromQueryString
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    NSArray *pairs = [[self query] componentsSeparatedByString:@"&"];
    
    for(NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dictionary setObject:val forKey:key];
    }
    
    return dictionary;
}
@end



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.rootViewController = [[LoginViewController alloc] init];
    
   [User setCurrentUser: nil];
     self.window.rootViewController = [self currentVC ];
    NSLog(@"the rootViewController %@", [self currentVC]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRootVC) name:UserDidLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRootVC) name:UserDidLogoutNotification object:nil];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"cptwitter"])
    {
        if ([url.host isEqualToString:@"oauth"])
        {
            NSDictionary *parameters = [url dictionaryFromQueryString];
            if (parameters[@"oauth_token"] && parameters[@"oauth_verifier"])
            {
                
                TwitterClient *client = [TwitterClient instance];
                [client fetchAccessTokenWithPath: @"/oauth/access_token" method:@"POST"  requestToken:[BDBOAuthToken tokenWithQueryString:url.query]
                success:^(BDBOAuthToken *accessToken) {
                    NSLog(@"Got the access token");
                    [client.requestSerializer saveAccessToken:accessToken];
                    [client homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                       // NSLog(@"Successfully retrieved the tweets array: response object %@  ", responseObject);
                         NSLog(@"Successfully retrieved the tweets array: response object");
                      // self.tweets = [Tweet tweetsWithArray:responseObject];
                        //NSLog(@"tweets array = %@",self.tweets[0][@"created_at"]);
                        NSLog(@"count of tweets in the response %i",[responseObject count]);
                       [User setCurrentUser:[[User alloc] initWithDictionary:responseObject]];
                        //TweetsViewController *tvc = [[TweetsViewController alloc] init];
                       // [[UINavigationController alloc] initWithRootViewController:tvc];
                        // [self.navigationController pushViewController:tvc animated:YES];
                        //self.window rootViewController = [[TweetsViewController alloc] init];
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"Error getting the tweets array");
                    }];
                }
                failure:^(NSError *error) {
                    NSLog(@"COuld not get the access token");
                }];
            }
        }
   
        return YES;
    }
    return NO;
    }

- (UIViewController *)currentVC {
    NSLog(@"inside User and curentUser ");
    if([User currentUser] != nil) {
       return self.setTweetsVC;
        
    }else {
        return self.setLoginVC;
    }
}

- (TweetsViewController *)setTweetsVC {
    NSLog(@"Inside the twwetsVC instance %@",self.tweetsVC);
    if (!self.tweetsVC) {
         self.tweetsVC = [[TweetsViewController alloc] init];
    }
    NSLog(@"after initializing tweets COntrooler %@",self.tweetsVC);
    
    return self.tweetsVC;
}

- (LoginViewController *)setLoginVC {
    NSLog(@"Inside the twwetsVC instance %@",self.loginVC);
    if (!self.loginVC) {
        self.loginVC = [[LoginViewController alloc] init];
    }
    
    return self.loginVC;
}

- (void)updateRootVC {
    NSLog(@"currentVC %@", self.currentVC);
    NSLog(@"self.window.rootViewController %@", self.window.rootViewController);
    self.window.rootViewController = self.currentVC;
   // self.window.rootViewController = [[TweetsViewController alloc] init];
}




@end;

