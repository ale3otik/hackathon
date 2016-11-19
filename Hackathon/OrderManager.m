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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Order"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSArray *results = [[NSArray alloc] init];
        if (!error) {
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
//            NSArray
            for (PFObject *object in objects) {
                
                
//                Order *order = [Order orderWithPFObject:object];
            }
            [query findObjects];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        
        execiteInMainQueue(^{
            handler(results);
        });
        
    }];
}

- (void)finishOrder:(Order *)order
        withHandler:(void (^)(void))handler {
    
//    [gameScore removeObjectForKey:@"playerName"];
    
}

@end
