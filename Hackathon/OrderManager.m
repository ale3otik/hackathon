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
    
    sleep(2);
    
    Order *order1 = [Order orderWithProduct:[Product productWithObjectId:nil
                                                                 andName:@"Pizza"
                                                                andPrice:740]
                                    andUser:[User userWithName:@"simon"
                                                      objectId:nil]
                            andCreationDate:[NSDate dateWithTimeIntervalSinceNow:30000]];
    
    Order *order2 = [Order orderWithProduct:[Product productWithObjectId:nil
                                                                 andName:@"Coke"
                                                                andPrice:120]
                                    andUser:[User userWithName:@"michael"
                                                      objectId:nil]
                            andCreationDate:[NSDate dateWithTimeIntervalSinceNow:50000]];
    
    Order *order3 = [Order orderWithProduct:[Product productWithObjectId:nil
                                                                 andName:@"Juice"
                                                                andPrice:70]
                                    andUser:[User userWithName:@"Alex"
                                                      objectId:nil]
                            andCreationDate:[NSDate dateWithTimeIntervalSinceNow:60000]];
    
    NSArray *results = @[order1, order2, order3];
    execiteInMainQueue(^{
        handler(results);
    });
}

- (void)finishOrder:(Order *)order
        withHandler:(void (^)(void))handler {
    
//    [gameScore removeObjectForKey:@"playerName"];
    
}

@end
