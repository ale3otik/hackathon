//
//  User.m
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "User.h"

@interface User ()
    @property (nonatomic, readwrite) NSString *name;
    @property (nonatomic, readwrite) NSString *objectId;
@end

@implementation User

+ (instancetype) userWithName: (NSString *) name {
    User * newUser = [[User alloc] init];
    
    // some validation
    newUser.objectId = objectId;
    newUser.name = name;
    return newUser;
}

@end
