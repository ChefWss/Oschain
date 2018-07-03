//
//  BaseModel.h
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/**
 * 通过一个字典创建一个model实例
 */
- (instancetype)initWithDic:(NSDictionary *)dic;

/**
 * 通过一个字典创建一个model实例，类方法
 */
+ (instancetype)baseModelByDic:(NSDictionary *)dic;

/**
 * 通过arr创建model数组
 */
+ (NSMutableArray *)baseModelByArr:(NSArray *)arr;

@end
