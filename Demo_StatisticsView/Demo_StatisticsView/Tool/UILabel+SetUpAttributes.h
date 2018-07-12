//
//  UILabel+SetUpAttributes.h
//  hschefu-ios-staff
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 CodeTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SetUpAttributes)

/**
 设置Label常用属性

 @param text 文本
 @param font 字体大小
 @param textColor 文本颜色
 */
- (void)setUpCommonAttributesWithText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

@end
