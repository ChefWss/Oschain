//
//  User.h
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *realName;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *phoneNum;
@property(nonatomic,copy)NSString *userID;
+ (User *)shareUser;

@end
