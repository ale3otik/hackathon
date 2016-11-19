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

- (NSArray *)matchUsers:(NSArray *)users toOrders:orders {
    return nil;
}

- (NSArray *)matchProducts:(NSArray *)products toOrders:orders {
    return nil;
}

- (void)obtainOrdersWithHandler:(ResultHandler)handler {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Order"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *orders, NSError *error) {
        if (!error) {
            
            NSMutableArray *userIds = [[NSMutableArray alloc] init];
            NSMutableArray *productIds = [[NSMutableArray alloc] init];
            for (PFObject *order in orders) {
                [userIds addObject:order[@"userId"]];
                [productIds addObject:order[@"productId"]];
            }
            
            PFQuery *queryUser = [PFQuery queryWithClassName:@"User"];
            PFQuery *queryProduct = [PFQuery queryWithClassName:@"Product"];
            [queryUser whereKey:@"objectId" containedIn:userIds];
            [queryProduct whereKey:@"objectId" containedIn:productIds];
            
            [queryUser findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
                if (!error) {
                    [queryProduct findObjectsInBackgroundWithBlock:^(NSArray *products, NSError *error) {
                        if (!error) {
                            NSArray *matchedUsersObjects = [self matchUsers:users toOrders:orders];
                            NSArray *matchedProductsObjects = [self matchProducts:products toOrders:orders];
                            NSMutableArray *results = [[NSMutableArray alloc] init];
                            for(int i = 0; i < orders.count; ++i) {
                                [results addObject:[Order orderWithPFOrder:orders[i]
                                                                 andPFUser:matchedUsersObjects[i]
                                                              andPFProduct:matchedProductsObjects[i]]];
                            }
                            
                            for(Order *object in results) {
                                NSLog(@"%@", object.product.name);
                            }
//                            execiteInMainQueue(^{
//                                handler(results);
//                            });
                        }
                        else {
                            NSLog(@"Error: %@ %@", error, [error userInfo]);
                        }
                    }];
                } else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)finishOrder:(Order *)order
        withHandler:(void (^)(void))handler {
    
}

@end
