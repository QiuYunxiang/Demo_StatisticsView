//
//  HSQ_StripTypeStatisticsView.m
//  hschefu-ios-mall
//
//  Created by qiu on 2018/6/15.
//  Copyright © 2018年 hschefu. All rights reserved.
//

#import "HSQ_StripTypeStatisticsView.h"
#import "UILabel+SetUpAttributes.h"

@interface HSQ_StripTypeStatisticsView()

@property (nonatomic,strong) UIView *X_axis; //X轴

@property (nonatomic,strong) UIView *Y_axis; //Y轴

@property (nonatomic,strong) NSMutableArray <UIView *>*X_ViewArray; //X轴方向上装view的数组

@property (nonatomic,strong) NSMutableArray <UILabel *>*X_TitleLabArray; //X轴方向上装titleLab的数组

@property (nonatomic,strong) NSMutableArray <UILabel *>*X_ViewTitleLabArray; //X轴方向上装viewTitleLab的数组

@property (nonatomic,strong) NSMutableArray <UIView *>*Y_LineViewArray; //Y轴方向上装线状view的数组

@property (nonatomic,strong) NSMutableArray <UILabel *>*Y_TitleLabArray; //Y轴方向上装lab的数组

@property (nonatomic,strong) UILabel *Y_axis_titleLab; //Y轴上标题

@end

@implementation HSQ_StripTypeStatisticsView

- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self setUpViews];
    }
    return self;
}

#pragma mark 布局
- (void)setUpViews {
    if (!_delegate) {
        return;
    }
    
    //开始布局
    //先画x轴
    self.X_axis = [UIView new];
    _X_axis.backgroundColor = MyColor(227, 227, 227, 1);
    [self addSubview:_X_axis];
    [_X_axis mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self).offset(-HSQWidth(55));
        make.height.mas_equalTo(HSQWidth(0.5));
    }];
    
    //再画Y轴
    self.Y_axis = [UIView new];
    _Y_axis.backgroundColor = MyColor(227, 227, 227, 1);
    [self addSubview:_Y_axis];
    [_Y_axis mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.X_axis);
        make.width.mas_equalTo(HSQWidth(0.5));
        make.height.mas_equalTo(self.bounds.size.height - HSQWidth(40) - HSQWidth(75));  //留出40布置其他控件
    }];
    
    //布局x轴方向上视图，首先是view,view初始状态不设置高度
    CGFloat x_start = [self.delegate HSQ_StripTypeStatisticsView_StartPointAt_X_axis];
    CGFloat x_end = [self.delegate HSQ_StripTypeStatisticsView_EndPointAt_X_axis];
    CGFloat viewWidth = [self.delegate HSQ_StripTypeStatisticsView_ViewWidthAt_X_axis];
    CGFloat viewInterval_user = [self.delegate HSQ_StripTypeStatisticsView_MinimumIntervalOfViewAt_X_axis];
    NSInteger viewCount = [self.delegate HSQ_StripTypeStatisticsView_numberOfViewsAt_X_axis];
    
    //计算每个view之间的间隔
    CGFloat X_long = self.bounds.size.width - x_start - x_end;
    CGFloat viewInterval = floor((X_long - viewCount * viewWidth) / (CGFloat)(viewCount - 1));
    
    viewInterval = viewInterval_user > viewInterval ? viewInterval_user : viewInterval;
    
    //画view并做保存
    self.X_ViewArray = [NSMutableArray array];
    for (int i = 0; i < viewCount; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = MyColor(107, 196, 107, 1);
        [self addSubview:view];
        [self.X_ViewArray addObject:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(self.X_axis).offset(x_start);
            } else {
                make.left.equalTo(self.X_ViewArray[i - 1].mas_right).offset(viewInterval);
            }
            make.bottom.equalTo(self.X_axis);
            make.width.mas_equalTo(viewWidth);
//            make.height.equalTo(self.Y_axis);
        }];
    }
    
    //画view下的lab并保存
    self.X_TitleLabArray = [NSMutableArray array];
    for (int i = 0; i < viewCount; i++) {
        UILabel *titleLab = [UILabel new];
        [self.X_TitleLabArray addObject:titleLab];
        [titleLab setUpCommonAttributesWithText:@"- -" font:[HSQAdaptiveToolManager setUpTextFont:12] textColor:MyColor(153, 153, 153, 1) textAlignment:(NSTextAlignmentCenter)];
        [self addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.X_axis).offset(HSQWidth(10));
            make.centerX.equalTo(self.X_ViewArray[i]);
        }];
    }
    
    //画view上的lab并保存
    self.X_ViewTitleLabArray = [NSMutableArray array];
    for (int i = 0; i < viewCount; i++) {
        UILabel *viewTitleLab = [UILabel new];
        [viewTitleLab setUpCommonAttributesWithText:@"- -" font:[HSQAdaptiveToolManager setUpTextFont:14] textColor:MyColor(51, 51, 51, 1) textAlignment:(NSTextAlignmentCenter)];
        viewTitleLab.font = [UIFont boldSystemFontOfSize:[HSQAdaptiveToolManager setUpTextFont:14]];
        [self addSubview:viewTitleLab];
        [self.X_ViewTitleLabArray addObject:viewTitleLab];
        [viewTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.X_ViewArray[i].mas_top).offset(-HSQWidth(7));
            make.centerX.equalTo(self.X_ViewArray[i]);
        }];
    }
    
    //画Y轴方向上平行于x轴的view
    CGFloat Y_long = self.bounds.size.height - HSQWidth(75) - HSQWidth(40);
    NSInteger numberOf_Y_Line = [self.delegate HSQ_StripTypeStatisticsView_numberOfLinesAt_Y_axis] - 1;
    CGFloat Y_LineInterval = Y_long / (CGFloat)numberOf_Y_Line;
    
    self.Y_LineViewArray = [NSMutableArray array];
    for (int i = 0; i < numberOf_Y_Line; i++) {
        UIView *lineView = [UIView new];
        lineView.backgroundColor = MyColor(227, 227, 227, 1);
        lineView.alpha = 0.4f;
        [self addSubview:lineView];
        [self.Y_LineViewArray addObject:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.height.equalTo(self.X_axis);
            if (i == 0) {
                make.bottom.equalTo(self.X_axis).offset(-Y_LineInterval);
            } else {
                make.bottom.equalTo(self.Y_LineViewArray[i-1]).offset(-Y_LineInterval);
            }
        }];
        [self sendSubviewToBack:lineView];
    }
    //画Y轴方向上的lab并保存
    self.Y_TitleLabArray = [NSMutableArray array];
    NSMutableArray <UIView *>*tmp_Y_lineArray = [NSMutableArray array];
    [tmp_Y_lineArray addObject:self.X_axis];
    [tmp_Y_lineArray addObjectsFromArray:self.Y_LineViewArray];
    
    for (int i = 0; i < tmp_Y_lineArray.count; i++) {
        UILabel *y_titleLab = [UILabel new];
        [y_titleLab setUpCommonAttributesWithText:@"- -" font:[HSQAdaptiveToolManager setUpTextFont:12] textColor:MyColor(153, 153, 153, 1) textAlignment:(NSTextAlignmentLeft)];
        [self addSubview:y_titleLab];
        [self.Y_TitleLabArray addObject:y_titleLab];
        [y_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tmp_Y_lineArray[i]);
            make.bottom.equalTo(tmp_Y_lineArray[i].mas_top).offset(-HSQWidth(7));
        }];
    }
    
    //画Y轴上的标题
    self.Y_axis_titleLab = [UILabel new];
    [_Y_axis_titleLab setUpCommonAttributesWithText:@"- -" font:[HSQAdaptiveToolManager setUpTextFont:12] textColor:MyColor(153, 153, 153, 1) textAlignment:(NSTextAlignmentLeft)];
    [self addSubview:_Y_axis_titleLab];
    [_Y_axis_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Y_TitleLabArray[0]);
        make.bottom.equalTo(self.Y_TitleLabArray[_Y_TitleLabArray.count - 1].mas_top).offset(-HSQWidth(8));
    }];
    
    self.Y_axis.hidden = YES;
}


/**
 X轴方向标题赋值
 
 @param x_titleArray 值
 */
- (void)setUp_X_axis_titleValueWithArray:(NSArray <NSString *>*)x_titleArray {
    NSInteger count = x_titleArray.count > 3 ? 3 :x_titleArray.count;
    for (int i = 0; i < count; i++) {
        self.X_TitleLabArray[i].text = x_titleArray[i];
    }
}

/**
 X轴方向上view标题赋值
 
 @param x_view_titleArray 值
 */
- (void)setUp_X_axis_ViewTitleValueWithArray:(NSArray <NSString *>*)x_view_titleArray {
    NSInteger count = x_view_titleArray.count > 3 ? 3 :x_view_titleArray.count;
    for (int i = 0; i < count; i++) {
        self.X_ViewTitleLabArray[i].text = x_view_titleArray[i];
    }
    [self setUp_Y_axis_titleLabAutomatic];
}

/**
 y轴方向上标题赋值
 
 @param y_titleArray 值
 */
- (void)setUp_Y_axis_titleValueWithArray:(NSArray <NSString *>*)y_titleArray {
    
}

/**
 设置标题
 
 @param title 标题
 */
- (void)setUpTitle:(NSString *)title {
    self.Y_axis_titleLab.text = title;
}

/**
 自动布局y轴坐标（利用X轴view的value），默认从0开始，1.25倍最高值
 */
- (void)setUp_Y_axis_titleLabAutomatic {
    float maxValue = CGFLOAT_MIN;
    for (int i = 0; i < self.X_ViewTitleLabArray.count; i++) {
        float tmpValue = [self.X_ViewTitleLabArray[i].text floatValue];
        maxValue = maxValue > tmpValue ? maxValue : tmpValue;
    }
    
    //1.25倍最低数并向上取整一次
    maxValue = ceilf(maxValue * 1.25 / 10) * 10;
    
    //每一份
    float everyValue = maxValue / ([self.delegate HSQ_StripTypeStatisticsView_numberOfLinesAt_Y_axis] - 1);
    //再对每一份进行向上取整
    everyValue = ceilf(everyValue);
    
    for (int i = 0; i < self.Y_TitleLabArray.count; i++) {
        self.Y_TitleLabArray[i].text = [NSString stringWithFormat:@"%.2f",everyValue * i];
    }
    
    //自动布局X轴上的view
    [self setUp_X_axis_ViewValueAutomatic];
}


/**
 自动布局x轴上view的长度
 */
- (void)setUp_X_axis_ViewValueAutomatic {
    //拿出Y轴最大值
    float maxValue = [self.Y_TitleLabArray[_Y_TitleLabArray.count - 1].text floatValue];
    for (int i = 0; i < self.X_ViewArray.count; i++) {
        float proportion = [self.X_ViewTitleLabArray[i].text floatValue] / maxValue;
        [self.X_ViewArray[i] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.Y_axis).multipliedBy(proportion);
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
