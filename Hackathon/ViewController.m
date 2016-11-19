//
//  ViewController.m
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "ViewController.h"
#import "OrderPageController.h"

#import "OrderManager.h"

@interface ViewController () <OrderManagerDelegate, UIPageViewControllerDataSource,
                              UIPageViewControllerDelegate>

@property (nonatomic) OrderManager *manager;
@property (nonatomic) UIActivityIndicatorView *indicatorView;

@property (nonatomic) NSArray *orders;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addIndicatorView];
    ResultHandler handler = ^void(NSArray *orders) {
        [self removeIndicatorView];
        self.orders = orders;
    };
    [self.manager obtainOrdersWithHandler:handler];
}

- (void)updateViewConstraints {
    
    if (_indicatorView) {
        [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    
    [super updateViewConstraints];
}

#pragma mark - UIPageViewControllerDataSource

#pragma mark - OrderManager

- (OrderManager *)manager {
    if (_manager)
        return _manager;
    _manager = [[OrderManager alloc] initWithDelegate:self];
    return _manager;
}

#pragma mark - ActivityIndicatorView

- (void)addIndicatorView {
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
}

- (void)removeIndicatorView {
    [self.indicatorView removeFromSuperview];
    _indicatorView = nil;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView)
        return _indicatorView;
    _indicatorView = [[UIActivityIndicatorView alloc]
                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    return _indicatorView;
}

@end
