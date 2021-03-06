//
//  Order.h
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"
#import "Product.h"

@interface Order : NSObject

@property (nonatomic) NSString *objectId;
@property (nonatomic, readonly) User *user;
@property (nonatomic, readonly) Product *product;
@property (nonatomic, readonly) NSDate *createdAt;

+ (instancetype)orderWithProduct:(Product *)product
                         andUser:(User *)user
                 andCreationDate:(NSDate *)createdAt;

+ (instancetype)orderWithPFOrder:(PFObject *)order
                       andPFUser:(PFObject *)user
                    andPFProduct:(PFObject *)produc;


@end
