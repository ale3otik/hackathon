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

- (void)obtainOrdersWithHandler:(ResultHandler)handler {

    executeInBackground(^{
        sleep(1);

        Order *order1 = [Order orderWithProduct:[Product productWithName:@"Pizza"
                                                                andPrice:740]
                                        andUser:[User userWithName:@"simon"]
                                andCreationDate:[NSDate dateWithTimeIntervalSinceNow:-120]];

        Order *order2 = [Order orderWithProduct:[Product productWithName:@"Coke"
                                                                andPrice:120]
                                        andUser:[User userWithName:@"michael"]
                                andCreationDate:[NSDate dateWithTimeIntervalSinceNow:-10]];

        Order *order3 = [Order orderWithProduct:[Product productWithName:@"Juice"
                                                                andPrice:70]
                                        andUser:[User userWithName:@"Alex"]
                                andCreationDate:[NSDate dateWithTimeIntervalSinceNow:-210]];

        NSArray *results = @[order1, order2, order3];
        executeInMainQueue(^{
            handler(results);
        });
    });
}

- (void)finishOrder:(Order *)order
        withHandler:(void (^)(void))handler {

//    [gameScore removeObjectForKey:@"playerName"];

}

@end
