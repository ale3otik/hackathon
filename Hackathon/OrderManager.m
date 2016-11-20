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

- (NSArray *)matchUsers:(NSArray *)users toOrders:(NSArray *)orders {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PFObject *order in orders){
        for(PFObject *user in users){
            if([order[@"userId"] isEqual: user[@"objectId"]]) {
                [result addObject:user];
                break;
            }
        }
    }
    
    return result;
}

- (NSArray *)matchProducts:(NSArray *)products toOrders:(NSArray *)orders {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PFObject *order in orders){
        for(PFObject * product in products) {
            if([order[@"userId"] isEqual: product[@"objectId"]]) {
                [result addObject:product];
                break;
            }
        }
    }
    return result;
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
                            NSLog(@"%lu", (unsigned long)orders.count);
                            NSLog(@"%lu", (unsigned long)users.count);
                            NSLog(@"%lu", (unsigned long)products.count);
                            NSArray *matchedUsersObjects = [self matchUsers:users toOrders:orders];
                            NSArray *matchedProductsObjects = [self matchProducts:products toOrders:orders];
                            NSMutableArray *results = [[NSMutableArray alloc] init];
                            for(int i = 0; i < orders.count; ++i) {
                                [results addObject:[Order orderWithPFOrder:orders[i]
                                                                 andPFUser:matchedUsersObjects[i]
                                                              andPFProduct:matchedProductsObjects[i]]];
                            }
//
//                            for(Order *object in results) {
//                                NSLog(@"%@ -  %@", object.product.name, object.user.name);
//                            }
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
