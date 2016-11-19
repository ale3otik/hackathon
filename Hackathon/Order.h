//
//  Order.h
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"
#import "Order.h"

@interface Order : NSObject

@property (nonatomic, readonly) User *user;
@property (nonatomic, readonly) Order *order;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSDate *createdAt;

@end
