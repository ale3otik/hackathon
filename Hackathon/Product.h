//
//  Product.h
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger price;
@property (nonatomic) NSString *objectId;

+ (instancetype)productWithName:(NSString *)name
                         andPrice:(NSInteger)price;
@end
