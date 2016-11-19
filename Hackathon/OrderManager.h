//
//  OrderManager.h
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Order.h"

typedef void (^ResultHandler)(NSArray *);

@protocol OrderManagerDelegate;
@interface OrderManager : NSObject

- (instancetype)initWithDelegate:(id <OrderManagerDelegate>)delegate;

- (void)obtainOrdersWithHandler:(ResultHandler)handler;

- (void)finishOrder:(Order *)order
        withHandler:(void (^)(void))handler;

@end

@protocol OrderManagerDelegate

- (void)newOrderDidAppear:(Order *)order;

@end
