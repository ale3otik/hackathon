//
//  User.h
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic) NSString *objectId;

+ (instancetype)userWithName:(NSString *)name;
+ (instancetype)userWithPFUser:(PFObject *)user;
@end
