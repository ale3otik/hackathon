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

@end

@implementation Product
+ (instancetype)productWithName:(NSString *)name
                         andPrice:(NSInteger)price {

    Product * newProduct = [[Product alloc] init];

    // some validation
    newProduct.name = name;
    newProduct.price = price;
    newProduct.objectId = nil;
    return newProduct;
}

+ (instancetype)productWithPFProduct:(PFObject *)product {
    Product * newProduct = [Product productWithName:product[@"name"] andPrice:(int)product[@"price"]];
    newProduct.objectId = product[@"objectId"];
    return newProduct;
}
@end
