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
@property (nonatomic, readwrite) NSMutableArray *activeOrderIds;
@property (nonatomic, readwrite) bool needNewRequest;

@end

@implementation OrderManager

- (instancetype)initWithDelegate:(id<OrderManagerDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    self.needNewRequest = false;
    self.activeOrderIds = [[NSMutableArray alloc] init];
    [self orderListener];
    
    return self;
}

- (NSArray *)matchUsers:(NSArray *)users toOrders:(NSArray *)orders {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PFObject *order in orders){
        for(PFObject *user in users){
            if([order[@"userId"] isEqual: user.objectId]) {
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
        bool found = false;
        for(PFObject * product in products) {
            if([order[@"productId"] isEqual: product.objectId]) {
                [result addObject:product];
                found = true;
                break;
            }
        }
        if(!found) {
            NSLog(@"not found %@",order[@"productId"]);
        }
    }
    return result;
}

- (void)processingResultsOfObtainingOrdersWithOrders:(NSArray *)orders
                                      andProducts:(NSArray *)products
                                         andUsers:(NSArray *)users
                                      withHandler:(ResultHandler)handler{
    
    NSArray *matchedUsersObjects = [self matchUsers:users toOrders:orders];
    NSArray *matchedProductsObjects = [self matchProducts:products toOrders:orders];
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for(int i = 0; i < orders.count; ++i) {
        [results addObject:[Order orderWithPFOrder:orders[i]
                                         andPFUser:matchedUsersObjects[i]
                                      andPFProduct:matchedProductsObjects[i]]];
    }
    
//    for(Order *order in results) {
//        NSLog(@"%@ - %@ - %@",order.product.name, order.user.name,order.createdAt);
//    }
    
    executeInMainQueue(^{
        self.needNewRequest = true;
        handler(results);
    });
    
}

- (void) getOtherDataFromDBWithOrders:(NSArray *)orders andHandler:(ResultHandler)handler {
    NSMutableArray *userIds = [[NSMutableArray alloc] init];
    NSMutableArray *productIds = [[NSMutableArray alloc] init];
    NSMutableArray *validOrders = [[NSMutableArray alloc] init];
    for (PFObject *order in orders) {
        NSString *userId = order[@"userId"];
        NSString *productId = order[@"productId"];
        if(userId == nil || productId == nil) {
            continue;
        }
        
        [userIds addObject:userId];
        [productIds addObject:productId];
        [validOrders addObject:order];
        [self.activeOrderIds addObject:order.objectId];
    }
    
    PFQuery *queryUser = [PFQuery queryWithClassName:@"User"];
    PFQuery *queryProduct = [PFQuery queryWithClassName:@"Product"];
    [queryUser whereKey:@"objectId" containedIn:userIds];
    [queryProduct whereKey:@"objectId" containedIn:productIds];
    
    [queryUser findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (!error) {
            [queryProduct findObjectsInBackgroundWithBlock:^(NSArray *products, NSError *error) {
                if (!error) {
                    [self processingResultsOfObtainingOrdersWithOrders:validOrders
                                                           andProducts:products
                                                              andUsers:users
                                                           withHandler:handler];
                }
                else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)obtainOrdersWithHandler:(ResultHandler)handler {
    executeInBackground(^{
        PFQuery *query = [PFQuery queryWithClassName:@"Order"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *orders, NSError *error) {
            if (!error) {
                [self getOtherDataFromDBWithOrders:orders andHandler:handler];
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    });
}

- (void)finishOrder:(Order *)order {
        executeInBackground(^{
            PFQuery *query = [PFQuery queryWithClassName:@"Order"];
            [query whereKey:@"objectId" equalTo:order.objectId];
            NSArray *response = [query findObjects];
            if(response.count > 0) {
                PFObject *orderToDelete = response[0];
                [self.activeOrderIds removeObject:order.objectId];
                [orderToDelete deleteEventually];
            } else {
                NSLog(@"empty deletetion");
            }
        });
}

- (void)orderListener {
    executeInBackground(^{
        while(true){
            while(!self.needNewRequest) {
                sleep(2);
            }
            self.needNewRequest = false;
            PFQuery *query = [PFQuery queryWithClassName:@"Order"];
            [query whereKey:@"objectId" notContainedIn:self.activeOrderIds];
            [query findObjectsInBackgroundWithBlock:^(NSArray *orders, NSError *error) {
                if (!error) {
                    ResultHandler handler = ^void(NSMutableArray *orders){
                        NSMutableArray *newOrderIds = [[NSMutableArray alloc] init];
                        for(Order *order in orders) {
                            [newOrderIds addObject:order.objectId];
                        }
                        [self.activeOrderIds addObjectsFromArray:newOrderIds];
                        
                        for(Order *order in orders) {
                            [self.delegate newOrderDidAppear:order];
                        }
                        self.needNewRequest = true;
                    };
                    
                    [self getOtherDataFromDBWithOrders:orders
                                            andHandler:handler];
                } else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    });
}

@end
