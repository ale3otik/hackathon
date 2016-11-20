//
//  ViewController.h
//  Hackathon
//
//  Created by Alex on 19.11.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPageController : UIPageViewController

// Setting current View Controller
// Just calling setViewControllers: w/o animation
- (void)setViewController:(UIViewController *)controller;

@end

