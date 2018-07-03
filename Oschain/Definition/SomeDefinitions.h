//
//  SomeDefinitions.h
//  SSBaseProject
//
//  Created by 王少帅 on 2018/4/25.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#ifndef SomeDefinitions_h
#define SomeDefinitions_h
/**********************************************************************************************************/


//api服务
#define kAPI                                [ApiService shareApiService]

//屏幕适配因子
#define kPERCENT(f)                         (f * [UIScreen mainScreen].bounds.size.width / 375.00)

//普通字体
#define FONT(f)                             [UIFont systemFontOfSize:(f)]

//屏幕适应字体
#define FONT_RATIO(f)                       [UIFont systemFontOfSize:(f * [UIScreen mainScreen].bounds.size.width / 375.00)]

//屏幕宽度,高度,bounds,size
#define WIDTH                               [UIScreen mainScreen].bounds.size.width
#define HEIGHT                              [UIScreen mainScreen].bounds.size.height
#define kSCREEN_BOUNDS                      [[UIScreen mainScreen] bounds]

//状态栏高度,nav,tab高度
#define kSTATUS_BAR_H                       ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kNAVIGATION_BAR_H                   44.0f
#define kTABBAR_H                           (self.tabBarController.tabBar.frame.size.height)

//view的frame因子
#define View_FRAME_W(v)                     v.frame.size.width
#define View_FRAME_H(v)                     v.frame.size.height
#define View_FRAME_X(v)                     v.frame.origin.x
#define View_FRAME_Y(v)                     v.frame.origin.y

//定义UIImage对象
#define GetImgWithName(imgName)             [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgName]]

//App版本,ios系统版本
#define APP_VERSION                         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define IOS_SYSTEM_VERSION                  [[[UIDevice currentDevice] systemVersion] doubleValue]

//沙盒目录文件下获取temp,Document,Cache
#define kPathTemp                           NSTemporaryDirectory()
#define kPathDocument                       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kPathCache                          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//app代理,UserDefaults,通知中心
#define Application_Delegate                ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kUserDefaults                       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter                 [NSNotificationCenter defaultCenter]
//写入defaults
#define UserDefaults_WriteObj(object, key)  [[NSUserDefaults standardUserDefaults] setObject:(object) forKey:(key)]
//读取defaults
#define UserDefaults_ReadObj(key)           [[NSUserDefaults standardUserDefaults] objectForKey:(key)]
//从defaults移除
#define UserDefaults_RemoveObjForKey(key)   [[NSUserDefaults standardUserDefaults] removeObjectForKey:(key)]
//defaults写入磁盘
#define UserDefaults_Synchronize            [[NSUserDefaults standardUserDefaults] synchronize]

//获取当前语言
#define kCurrentLanguage                    ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define kisIPhone                           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define kisIPad                             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//弱引用,强引用
#define kWeakSelf(type)                     __weak typeof(type) weak##type = type
#define kStrongSelf(type)                   __strong typeof(type) type = weak##type

//由角度转换弧度
#define kDegreesToRadian(x)                 (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian)            (radian * 180.0) / (M_PI)

//获取一段时间间隔
#define kStartTime                          CFAbsoluteTime start = CFAbsoluteTimeGetCurrent()
#define kEndTime_Log                        NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//设置圆角,边框,边框颜色
#define SetViewBorder(View, Radius, BorderWidth, BorderColor)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//获取屏幕宽度与高度(考虑横屏)
#define kScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)
#define kScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)
#define kScreenSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)


//字典取值
//字典祛空(如果空返回@"")
#define Dictionary(dic,key)                  (dic[key] ? dic[key] : @"")
//获取字典的key对应的String
#define DictionaryStringWithKey(dic,key)     [NSString stringWithFormat:@"%@",Dictionary(dic,key)]
//获取字典的key对应的int
#define DictionaryIntWithKey(dic,key)        [DictionaryStringWithKey(dic,key) intValue]
//获取字典的key对应的intger
#define DictionaryIntegerWithKey(dic,key)    [DictionaryStringWithKey(dic,key) integerValue]
//获取字典的key对应的float
#define DictionaryFloatWithKey(dic,key)      [DictionaryStringWithKey(dic,key) floatValue]
//获取字典的key对应的bool
#define DictionaryBoolWithKey(dic,key)       [DictionaryStringWithKey(dic,key) boolValue]
//数字类型转化字符串
#define IntegerToString(num)                 [NSString stringWithFormat:@"%ld",num]
#define FloatIntToString(num)                [NSString stringWithFormat:@"%.0f",num]
#define FloatToString(num)                   [NSString stringWithFormat:@"%.2f",num]
#define IntToString(num)                     [NSString stringWithFormat:@"%d",num]


#define IOS_VERSION_8_OR_ABOVE  (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
#define IOS_VERSION_8_OR_BEFORE (([[[UIDevice currentDevice] systemVersion] floatValue] <  8.0)? (YES):(NO))
#define IOS_VERSION_9_OR_BEFORE (([[[UIDevice currentDevice] systemVersion] floatValue] <  9.0)? (YES):(NO))
#define IOS_VERSION_11_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)? (YES):(NO))


#define kDevice_Is_iPhone4       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone678     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone678plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneX       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


//字符串是否为空
#define kStringIsEmpty(str)       ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array)      (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic)         (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object)   (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif


// 自定义Log日志(1)
#if DEBUG
#define NSLog(FORMAT, ...)  fprintf(stderr, "[%s: %d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...)  nil
#endif


// debug和release模式NSLog(2)
//#ifdef DEBUG
//#define NSLog(...)               NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#else
//#define NSLog(...)
//#endif


/**********************************************************************************************************/
#endif /* SomeDefinitions_h */
