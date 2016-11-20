//
//  OrderController.h
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@protocol OrderControllerDelegate;
@interface OrderController : UIViewController

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, weak) id <OrderControllerDelegate> delegate;

+ (instancetype)orderControllerWithOrder:(Order *)order
                                andIndex:(NSInteger)index;

@end

@protocol OrderControllerDelegate

- (void)orderControllerDidTapDoneButton:(OrderController *)controller;

@end
