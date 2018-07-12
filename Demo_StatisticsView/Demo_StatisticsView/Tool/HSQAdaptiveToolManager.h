//
//  HSQAdaptiveToolManager.h
//  hschefu-ios-staff
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 CodeTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSQAdaptiveToolManager : NSObject

/**
 快速设置各个屏幕的字体 以6为基准
 @return 适合当前屏幕的字体font大小
 
 */
+ (CGFloat)setUpTextFont:(CGFloat)textFont;

/**
 设置各个屏幕的字体，可以手动微调
 @return 适合当前屏幕的字体font大小
 */
+ (CGFloat)setUpTextFontForIphone4:(CGFloat)iphone4 iphone6:(CGFloat)iphone6 iPhoneP:(CGFloat)iphoneP iphoneX:(CGFloat)iphoneX;

/**
 判断图片格式
 
 @param data imagedata
 @return 格式
 */
+ (NSString *)typeForImageData:(NSData *)data;

/**
 字典转json串
 
 @param dic 字典
 @return json串
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

/**
 获取身份证上的性别
 
 @param numberStr 身份证号码
 @return 性别
 */
+ (NSString *)getIdentityCardSex:(NSString *)numberStr;

/**
 给cell线

 @param superView cell.contentView
 */
+ (void)setUpBottomLineViewOnView:(UIView *)superView;

/**
 一个简单的弹窗

 @param message 弹窗信息
 */
+ (void)alertWithMessage:(NSString *)message;

/**
 进行2位小数的数字校验

 @param number <#number description#>
 @return <#return value description#>
 */
+ (BOOL)checkNumber:(NSString *)number;


/**
 返回当前屏幕下像素比

 @return <#return value description#>
 */
+ (int)imagePixelRatio;

@end
