//
//  Tool.m
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "Tool.h"
#import "CommonCrypto/CommonDigest.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

@implementation Tool

+ (Tool *)shareTool {
    static dispatch_once_t onceToken;
    static Tool *instance;
    dispatch_once(&onceToken, ^{
        instance = [[Tool alloc] init];
    });
    return instance;
}

+ (void)saveToUserDefaultsValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (id)readFromUserDefaultsForKey:(NSString *)key {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *val = nil;
    
    if (standardUserDefaults)
        val = [standardUserDefaults objectForKey:key];
    
    return val;
}

+ (void)removeFromUserDefaultsForKey:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults removeObjectForKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (NSString *)replaceNull:(id)mes
{
    if ([mes isKindOfClass:[NSNull class]] || mes==nil) {
        return @"";
    }
    else if ([mes isKindOfClass:[NSNumber class]]) {
        return [mes stringValue];
    }
    else {
        return mes;
    }
}

+ (void)endRefresh:(UITableView *)tabelView
{
    if ([tabelView.mj_header isRefreshing]) {
        [tabelView.mj_header endRefreshing];
    }
    if ([tabelView.mj_footer isRefreshing]) {
        [tabelView.mj_footer endRefreshing];
    }
}

//获取当前日期时间format @"YYYY/MM/dd HH:mm:ss"
+ (NSString *)getCurrentDate:(NSString *)format {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

+ (id)contentWithJsonString:(NSString *)jsonString {
    if (jsonString == nil || [jsonString isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id content = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
    if(err) {
        return nil;
    }
    return content;
}

+ (NSString *)NSStringJson:(id)content {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)judgeSpace:(NSString *)msg {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [msg stringByTrimmingCharactersInSet:set];
    return trimedString;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    // Bypass '#' character
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (NSString *)getCurrentVersion {
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

+ (NSString *)IphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone1,1"])  return @"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return @"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return @"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return @"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return @"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return @"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return @"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return @"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return @"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return @"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return @"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return @"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return @"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return @"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return @"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return @"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return @"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return @"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return @"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return @"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return @"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return @"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return @"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return @"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return @"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return @"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return @"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return @"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return @"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator";
    
    return platform;
}


+ (void)ShowMessage:(NSString *)msg Lasttime:(CGFloat)time
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:kPERCENT(15)];
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.2f;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:kPERCENT(15)]};
    [window addSubview:label];
    
    //尺寸
    CGRect rect = [msg boundingRectWithSize:CGSizeMake(0,0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    label.frame = CGRectMake(0, 0, rect.size.width + kPERCENT(50), kPERCENT(40));
    label.center = window.center;
//    [label makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(window);
//        make.centerY.equalTo(window).offset(kPERCENT(-20));
//        make.height.equalTo(rect.size.height);
//        make.width.equalTo(rect.size.width+kPERCENT(0));
//    }];
    
    [UIView animateWithDuration:time * 0.5 animations:^{
        label.alpha = 0.75f;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //view从window上消失
            [label removeFromSuperview];
        });
    }];
}

+ (CGRect)getHetght:(NSString *)str width:(CGFloat)width font:(CGFloat)font {
    CGSize labelsize=CGSizeMake(width, 0);
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect=[str boundingRectWithSize:labelsize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect;
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame withImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.textAlignment = textAlignment;
    return label;
}

+ (NSString *)md5SercetWithText:(NSString *)inPutText {
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)createMD5SignWithDictionary:(NSDictionary *)dict {
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray)
    {
        if (   ![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@""]
            && ![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@"sign"]
            && ![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@"appSecret"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段
    [contentString appendFormat:@"appSecret=%@",@"123456"];
    NSLog(@"contentString = %@",contentString);
    
    //MD5 获取Sign签名
    NSString *md5Sign =[self md5SercetWithText:contentString];
    NSLog(@"%@",md5Sign);
    //
    return md5Sign;
}

+ (BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

+ (BOOL)validatePhone:(NSString *)phone {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|4[57])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phone] == YES)
        || ([regextestcm evaluateWithObject:phone] == YES)
        || ([regextestct evaluateWithObject:phone] == YES)
        || ([regextestcu evaluateWithObject:phone] == YES))
    {
        if([regextestcm evaluateWithObject:phone] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:phone] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:phone] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 身份证识别
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo {
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

+ (BOOL)checkBankCardNo:(NSString*) cardNum {
    NSInteger len = [cardNum length];
    NSInteger sumNumOdd = 0;
    NSInteger sumNumEven = 0;
    BOOL isOdd = YES;
    
    for (NSInteger i = len - 1; i >= 0; i--) {
        
        NSInteger num = [cardNum substringWithRange:NSMakeRange(i, 1)].integerValue;
        if (isOdd) {//奇数位
            sumNumOdd += num;
        }else{//偶数位
            num = num * 2;
            if (num > 9) {
                num = num - 9;
            }
            sumNumEven += num;
        }
        isOdd = !isOdd;
    }
    return ((sumNumOdd + sumNumEven) % 10 == 0);
}

@end



@implementation UIView (Global)

- (UIViewController *)parentController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)kSetCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    self.layer.masksToBounds = YES;
    if (radius != 0) {
        self.layer.cornerRadius = radius;
    }
    if (width != 0) {
        self.layer.borderWidth = width;
    }
    if (color != nil) {
        self.layer.borderColor = color.CGColor;
    }
}

@end



@implementation UIViewController (Global)

- (void)showErrorMessage:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
}

@end

