//
//  OrderManager.m
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "OrderManager.h"

@interface OrderManager()
@property (nonatomic, readwrite) id<OrderManagerDelegate> delegate;

@end

@implementation OrderManager

- (instancetype)initWithDelegate:(id<OrderManagerDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}

- (void)obtainOrdersWithHandler:(void (^)(NSArray *))handler {
    
}

- (void)finishOrder:(Order *)order
        withHandler:(void (^)(void))handler {
    
//    [gameScore removeObjectForKey:@"playerName"];
    
}

@end
