//
//  HSQ_StripTypeStatisticsView.h
//  hschefu-ios-mall
//
//  Created by qiu on 2018/6/15.
//  Copyright © 2018年 hschefu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HSQ_StripTypeStatisticsViewDelegate<NSObject>

/**
 Y轴有多少行坐标

 @return 行数
 */
- (NSInteger)HSQ_StripTypeStatisticsView_numberOfLinesAt_Y_axis;

/**
 X轴有多少个条形图

 @return 条形图个数
 */
- (NSInteger)HSQ_StripTypeStatisticsView_numberOfViewsAt_X_axis;


/**
 X轴布局起点，距离X轴最左端

 @return 布局起点
 */
- (CGFloat)HSQ_StripTypeStatisticsView_StartPointAt_X_axis;

/**
 X轴布局结束点，距离X轴最右端

 @return 布局结束点
 */
- (CGFloat)HSQ_StripTypeStatisticsView_EndPointAt_X_axis;

/**
 X轴布局view时最小间隔，若给定间隔大于计算出来的间隔，则以给定间隔为准（此时会影响EndPoint）

 @return 间隔
 */
- (CGFloat)HSQ_StripTypeStatisticsView_MinimumIntervalOfViewAt_X_axis;

/**
 X轴上布局的view宽度

 @return 宽度
 */
- (CGFloat)HSQ_StripTypeStatisticsView_ViewWidthAt_X_axis;

@end

@interface HSQ_StripTypeStatisticsView : UIView



/**
 如果代理不存在则直接停止布局
 */
@property (nonatomic,weak) id <HSQ_StripTypeStatisticsViewDelegate> delegate;


/**
 初始化

 @param frame frame
 @param delegate delegate
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id)delegate;

/**
 设置x方向上控件色彩（已经进行过渲染）

 @param x_titleLabColor x轴下方标题颜色
 @param x_viewColor x上View颜色
 @param x_viewTitleColor view顶部标题颜色
 @param x_lineColor x轴颜色
 */
- (void)setUpTitleLabColorAt_X_axis:(UIColor *)x_titleLabColor viewColorAt_X_axis:(UIColor *)x_viewColor viewTitleColorAt_X_axis:(UIColor *)x_viewTitleColor lineColor:(UIColor *)x_lineColor;

/**
 X轴方向标题赋值

 @param x_titleArray 值
 */
- (void)setUp_X_axis_titleValueWithArray:(NSArray <NSString *>*)x_titleArray;

/**
 X轴方向上view标题赋值

 @param x_view_titleArray 值
 */
- (void)setUp_X_axis_ViewTitleValueWithArray:(NSArray <NSString *>*)x_view_titleArray;

/**
 y轴方向上标题赋值

 @param y_titleArray 值
 */
- (void)setUp_Y_axis_titleValueWithArray:(NSArray <NSString *>*)y_titleArray;

/**
 设置标题

 @param title 标题
 */
- (void)setUpTitle:(NSString *)title;


@end
