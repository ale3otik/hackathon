//
//  Product.m
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "Product.h"

@interface Product ()

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) NSInteger price;
@property (nonatomic, readwrite) NSString *objectId;

@end

@implementation Product
+ (instancetype) productWithObjectId:(NSString *)objectId
                          andName:(NSString *)name
                         andPrice:(NSInteger)price {

    Product * newProduct = [[Product alloc] init];

    // some validation
    newProduct.objectId = objectId;
    newProduct.name = name;
    newProduct.price = price;
    return newProduct;
}
@end
