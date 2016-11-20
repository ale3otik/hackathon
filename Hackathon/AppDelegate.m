//
//  AppDelegate.m
//  Hackathon
//
//  Created by Alex on 19.11.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "User.h"
#import "Product.h"
#import "Order.h"
#import "QueryTests.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"fJS9qIlbGMHqYa6M0RGyhDrmHEcDSoR3w774QmD1";
        configuration.clientKey =@"J03QSSj7jE5h75AbAxCmaOcE3vBMlLNWI0cqLuLz";
    }]];
    
//    testQuery();
//    testDelete();
    // Override point for customization after application launch.

    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];

    CGRect bounds = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    ViewController *controller = [[ViewController alloc] init];

    self.window.rootViewController = controller;
    NSLog(@"ViewController is assigned");
    [self.window makeKeyAndVisible];

    return YES;
}

@end
