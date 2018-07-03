//
//  User.m
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)shareUser {
    static dispatch_once_t onceToken;
    static User *instance;
    dispatch_once(&onceToken, ^{
        instance = [[User alloc] init];
    });
    return instance;
}

@end
