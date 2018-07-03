//
//  NSString+SVCCExtend.h
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/19.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SVCCExtend)
+ (NSString *)nullToString:(id)data;
// 修正浮点型精度丢失
+ (NSString *)reviseString:(NSString *)str;
+ (NSString *)removeSpaceAndNewline:(NSString *)str;
+ (BOOL)isBlankString:(NSString *)string;
+ (BOOL)checkInputPhone:(NSString *)phoneNumber;
// dict -> string
+ (NSString *)DicToJsonStr:(NSDictionary *)dic;
// json -> dict
+ (id)JSONValue;
- (NSString*)md532BitLower;
- (NSString*)md532BitUpper;
@end
