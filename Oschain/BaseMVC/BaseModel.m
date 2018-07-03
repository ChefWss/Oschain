//
//  BaseModel.m
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSMutableArray *)baseModelByArr:(NSArray *)arr
{
    if (![arr isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    // 初始化返回的数组容器
    NSMutableArray *modelMarr = [NSMutableArray array];
    // 遍历数组
    for (NSMutableDictionary *mdic in arr)
    {
        @autoreleasepool {
            // 通过便利构造器来创建对象
            id model = [[self class] baseModelByDic:mdic];
            [modelMarr addObject:model];// 由于将model添加到了数组中，会使model的引用计数+1，所以人为的加了一个自动释放池
        }
    }
    return modelMarr;
}


+ (instancetype)baseModelByDic:(NSDictionary *)dic
{
    // 通过多态创建对象
    id model = [[[self class] alloc] initWithDic:dic];
    return model;
}


- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        //去空
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        NSArray *keysArray = [dic allKeys];
        for (id obj in keysArray)
        {
            if ([dic[obj] isKindOfClass:[NSNull class]]
                || dic[obj] == nil
                || [dic[obj] isEqual:@"<null>"]
                || [dic[obj] isEqual:@"(null)"]
                || [dic[obj] isEqual:@"null"])
            {
                [tempDic setObject:@"" forKey:obj];
            }
        }
        // 进行KVC的赋值
        [self setValuesForKeysWithDictionary:tempDic];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}


@end
