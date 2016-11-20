//
//  ViewController.m
//  Hackathon
//
//  Created by Alex on 19.11.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "OrderPageController.h"

@interface OrderPageController ()

@end

@implementation OrderPageController

- (instancetype)init {
    UIPageViewControllerTransitionStyle transitionStyle = UIPageViewControllerTransitionStyleScroll;
    UIPageViewControllerNavigationOrientation orientation =
                                                UIPageViewControllerNavigationOrientationHorizontal;
    if (self = [super initWithTransitionStyle:transitionStyle
                      navigationOrientation:orientation
                                    options:nil]) {
      
    }
    return self;
}

- (void)viewDidLoad {
  	[super viewDidLoad];
  	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setViewController:(UIViewController *)controller {
    [self setViewControllers:@[controller]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}

@end
