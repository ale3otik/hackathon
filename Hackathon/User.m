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
@end

@implementation User
+ (instancetype) initWithName: (NSString *) name {
    User * newUser = [[User alloc] init];
    
    // some validation
    
    newUser.name = name;
    return newUser;
}

@end
