//
//  HSQAdaptiveToolManager.m
//  hschefu-ios-staff
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 CodeTeam. All rights reserved.
//

#define kTextFontExcursionValue 1

#import "HSQAdaptiveToolManager.h"

@implementation HSQAdaptiveToolManager

#pragma mark 快速设置各个屏幕的字体，差值为1
+ (CGFloat)setUpTextFont:(CGFloat)textFont {
    if (iPHone4) {
        return textFont - kTextFontExcursionValue;
    } else if (iPhone6) {
        return textFont;
    } else if (iPhone_P) {
        return textFont + kTextFontExcursionValue;
    } else if (iPHoneX) {
        return textFont + kTextFontExcursionValue;
    } else {
        return textFont;
    }
}

#pragma mark 设置各个屏幕的字体，可以手动微调
+ (CGFloat)setUpTextFontForIphone4:(CGFloat)iphone4 iphone6:(CGFloat)iphone6 iPhoneP:(CGFloat)iphoneP iphoneX:(CGFloat)iphoneX {
    if (iPHone4) {
        return iphone4;
    } else if (iPhone6) {
        return iphone6;
    } else if (iPhone_P) {
        return iphoneP;
    } else if (iPHoneX) {
        return iphoneX;
    } else {
        return iphone6;
    }
}

#pragma mark 判断图片格式
+ (NSString *)typeForImageData:(NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    switch (c) {
            
        case 0xFF:
            
            return @".jpeg";
            
        case 0x89:
            
            return @".png";
            
        case 0x47:
            
            return @".gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @".tiff";
            
    }
    
    return nil;
    
}

#pragma mark 字典转json串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

#pragma mark 身份证号码获取性别
+ (NSString *)getIdentityCardSex:(NSString *)numberStr

{
    NSString *sex = @"";
    //获取18位 二代身份证  性别
    if (numberStr.length==18)
    {
        int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
        if(sexInt%2!=0)
            
        {
            sex = @"男";
        }
        else
        {
            sex = @"女";
            
        }
        
    }
    return sex;
}

#pragma mark 返回一根线状view
+ (void)setUpBottomLineViewOnView:(UIView *)superView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = MyColor(227, 227, 227, 1);
    [superView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.and.right.equalTo(superView);
        make.height.mas_equalTo(HSQWidth(0.5));
        make.bottom.equalTo(superView).offset(-HSQWidth(0.5));
    }];
    [superView bringSubviewToFront:lineView];
}

#pragma mark 一个简单的弹窗
+ (void)alertWithMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:sureAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark 进行2位小数数字校验
+ (BOOL)checkNumber:(NSString *)number {
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:number];
}

#pragma mark 返回当前屏幕像素比
+ (int)imagePixelRatio {
    if (iPHone4) {
        return 2;
    } else if (iPhone6) {
        return 2;
    } else if (iPhone_P) {
        return 3;
    } else if (iPHoneX) {
        return 3;
    }
    return 3;
}

@end
