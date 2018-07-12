//
//  UILabel+SetUpAttributes.m
//  hschefu-ios-staff
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 CodeTeam. All rights reserved.
//

#import "UILabel+SetUpAttributes.h"

@implementation UILabel (SetUpAttributes)

#pragma mark 设置label常用属性
- (void)setUpCommonAttributesWithText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    self.text = (text ? text : @"--");
    [self setFont:[UIFont systemFontOfSize:font]];
    self.textColor = textColor;
    self.textAlignment = textAlignment;
}

@end
