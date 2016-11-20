//
//  ViewController.m
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>

#import "ViewController.h"

#import "OrderController.h"
#import "OrderPageController.h"

#import "OrderManager.h"

@interface ViewController () <OrderManagerDelegate, UIPageViewControllerDataSource,
                              UIPageViewControllerDelegate, OrderControllerDelegate>

@property (nonatomic) OrderManager *manager;
@property (nonatomic) UIActivityIndicatorView *indicatorView;

@property (nonatomic) NSMutableArray *orders;

@property (nonatomic) NSInteger index;

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
        Order *firstOrder = [self.orders firstObject];
        [self pushOrderPageControllerWithOrder:firstOrder];
    };
    [self.manager obtainOrdersWithHandler:handler];
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (_indicatorView) {
        [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    [super updateViewConstraints];
}

- (void)pushOrderPageControllerWithOrder:(Order *)order {
    OrderController *controller = [OrderController orderControllerWithOrder:order
                                                                   andIndex:0];
    controller.delegate = self;
    OrderPageController *pageController = [[OrderPageController alloc] init];
    pageController.dataSource = self;
    pageController.delegate = self;
    [pageController setViewController:controller];
    [self presentViewController:pageController
                       animated:YES
                     completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(OrderController *)viewController {
    NSInteger index = viewController.index;
    if (index == 0)
        return 0;
    NSInteger newIndex = index - 1;
    OrderController *controller = [OrderController orderControllerWithOrder:self.orders[newIndex]
                                                                   andIndex:newIndex];
    controller.delegate = self;
    return controller;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(OrderController *)viewController {
    NSInteger index = viewController.index;
    if (index == self.orders.count - 1)
        return 0;
    NSInteger newIndex = index + 1;
    OrderController *controller = [OrderController orderControllerWithOrder:self.orders[newIndex]
                                                                   andIndex:newIndex];
    controller.delegate = self;
    return controller;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.orders.count;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return self.index;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<OrderController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    OrderController *controller = [previousViewControllers firstObject];
    self.index = controller.index;
}

#pragma mark - OrderControllerDelegate

- (void)orderControllerDidTapDoneButton:(OrderController *)controller {
    [self.orders removeObjectAtIndex:controller.index];
    NSInteger index = controller.index;
    NSInteger newIndex = index + (index != self.orders.count ? 0 : -1);
    OrderPageController *pageController = (OrderPageController *)controller.parentViewController;
    if (self.orders.count != 0) {
        Order *order = self.orders[newIndex];
        OrderController *newController = [OrderController orderControllerWithOrder:order
                                                                          andIndex:newIndex];
        newController.delegate = self;
        self.index = newIndex;
        [pageController setViewController:newController];
    } else {
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
}

#pragma mark - OrderManager

- (OrderManager *)manager {
    if (_manager)
        return _manager;
    _manager = [[OrderManager alloc] initWithDelegate:self];
    return _manager;
}

#pragma mark - Orders

- (void)setOrders:(NSMutableArray *)orders {
    NSComparisonResult (^cmrt)(Order *, Order *) = ^NSComparisonResult(Order *obj1, Order *obj2) {
        return [obj1.createdAt compare:obj2.createdAt];
    };
    _orders = [NSMutableArray arrayWithArray:[orders sortedArrayUsingComparator:cmrt]];
}

#pragma mark - <OrderManagerDelegate>

- (void)newOrderDidAppear:(Order *)order {
    AudioServicesPlaySystemSound(1000);

    [self.orders addObject:order];
    if (self.orders.count == 1) {
        [self pushOrderPageControllerWithOrder:order];
    }
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
                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    return _indicatorView;
}

@end
