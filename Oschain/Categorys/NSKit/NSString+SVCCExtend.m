//
//  NSString+SVCCExtend.m
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/19.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import "NSString+SVCCExtend.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SVCCExtend)
#pragma mark - 判断是否为空对象
+ (NSString *)nullToString:(id)data
{
    NSString *str;
    if (data == [NSNull null] || data == nil || data == Nil || [data isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"<NULL>"]) {
        str = @"";
    }else{
        str = [NSString stringWithFormat:@"%@",data];
    }
    return str;
}

#pragma mark - 修正浮点型精度丢失
+(NSString *)reviseString:(NSString *)str{
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

#pragma mark - 去掉字符串中的空格和换行
+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    //    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    //    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    return temp;
    NSString *content = str;
    NSMutableString *mutContentStr;
    if (content&&![content isEqualToString:@""]) {
        mutContentStr=[NSMutableString stringWithString:content];
    }else{
        return nil;
    }
    if (IOS_VERSION_8_OR_ABOVE) {
        while ([mutContentStr containsString:@"\n"]) {
            NSRange range=[mutContentStr rangeOfString:@"\n"];
            [mutContentStr deleteCharactersInRange:range];
        }
        while ([mutContentStr containsString:@"\t"]) {
            NSRange range=[mutContentStr rangeOfString:@"\t"];
            [mutContentStr deleteCharactersInRange:range];
        }
        while ([mutContentStr containsString:@"&nbsp;"]) {
            NSRange range=[mutContentStr rangeOfString:@"&nbsp;"];
            [mutContentStr deleteCharactersInRange:range];
        }
        while ([mutContentStr containsString:@"  "]) {
            NSRange range=[mutContentStr rangeOfString:@"  "];
            [mutContentStr deleteCharactersInRange:range];
        }
        while ([mutContentStr containsString:@"\r"]) {
            NSRange range=[mutContentStr rangeOfString:@"\r"];
            [mutContentStr deleteCharactersInRange:range];
        }
        
        return [NSString stringWithString:mutContentStr];
    }else{
        while ([mutContentStr rangeOfString:@"\n"].length>0) {
            NSRange range=[mutContentStr rangeOfString:@"\n"];
            [mutContentStr deleteCharactersInRange:range];
        }
        while ([mutContentStr rangeOfString:@"\t"].length>0) {
            NSRange range=[mutContentStr rangeOfString:@"\t"];
            [mutContentStr deleteCharactersInRange:range];
        }
        while ([mutContentStr rangeOfString:@"&nbsp;"].length>0) {
            NSRange range=[mutContentStr rangeOfString:@"&nbsp;"];
            [mutContentStr deleteCharactersInRange:range];
        }
        while ([mutContentStr rangeOfString:@"  "].length>0) {
            NSRange range=[mutContentStr rangeOfString:@"  "];
            [mutContentStr deleteCharactersInRange:range];
        }
        while ([mutContentStr rangeOfString:@"\r"].length>0) {
            NSRange range=[mutContentStr rangeOfString:@"\r"];
            [mutContentStr deleteCharactersInRange:range];
        }
        return [NSString stringWithString:mutContentStr];
    }
}

#pragma mark - 判断字符串为空格解决办法
+ (BOOL)isBlankString:(NSString *)string{
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 判断电话号码
+ (BOOL)checkInputPhone:(NSString *)phoneNumber
{
    if (!phoneNumber) return NO;
    NSString *phoneRegex = @"1[34578]([0-9]){9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

#pragma mark - Dic -> String
+ (NSString *) DicToJsonStr:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if ([str length] > 0 && error == nil){
        return str;
    }else{
        return nil;
    }
}

+ (id)JSONValue;
{
    NSData* data = [self.class dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

#pragma mark - md5
- (NSString*)md532BitLower
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
- (NSString*)md532BitUpper
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}
@end
