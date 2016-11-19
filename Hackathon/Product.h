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

+ (instancetype) productWithObjectId:(NSString *)objectId
                          andName:(NSString *)name
                         andPrice:(NSInteger)price;
@end
