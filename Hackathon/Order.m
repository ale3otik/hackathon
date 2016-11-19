//
//  Order.m
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "Order.h"


@interface Order ()

@property (nonatomic, readwrite) User *user;
@property (nonatomic, readwrite) Product *product;
@property (nonatomic, readwrite) NSDate *createdAt;

@end

@implementation Order

+ (instancetype)orderWithProduct:(Product *)product
                         andUser:(User *)user
                 andCreationDate:(NSDate *)createdAt {
    
    Order *newOrder = [[Order alloc] init];
    
    // some validation
    
    newOrder.user = user;
    newOrder.product = product;
    newOrder.createdAt = createdAt;
    return newOrder;
}

@end
