//
//  ViewController.m
//  Demo_StatisticsView
//
//  Created by qiu on 2018/7/12.
//  Copyright © 2018年 qiu. All rights reserved.
//

#import "ViewController.h"
#import "HSQ_StripTypeStatisticsView.h"

@interface ViewController ()

@property (nonatomic,strong) HSQ_StripTypeStatisticsView *statisticsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //布局
    [self setUpViews];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark 布局
- (void)setUpViews {
    self.statisticsView = [[HSQ_StripTypeStatisticsView alloc] initWithFrame:CGRectMake(HSQWidth(0), HSQWidth(10),self.view.frame.size.width -  HSQWidth(30), HSQWidth(280)) withDelegate:self];
    [self.view addSubview:self.statisticsView];
    
    [_statisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(HSQWidth(15));
        make.right.equalTo(self.view).offset(-HSQWidth(15));
        make.top.equalTo(self.view).offset(HSQWidth(100));
        make.height.mas_equalTo(HSQWidth(300));
    }];
    
    
    NSArray *x_titleArray = @[@"2010年",@"2012年",@"2014年"];
    NSArray *x_viewTitleArray = @[@"68.5",@"90",@"37"];
    
    [self.statisticsView setUpTitle:@"复售价格区间(万元)"];
    [self.statisticsView setUp_X_axis_titleValueWithArray:x_titleArray];
    [self.statisticsView setUp_X_axis_ViewTitleValueWithArray:x_viewTitleArray];
    
}

#pragma mark HSQ_StripTypeStatisticsViewDelegate
/**
 Y轴有多少行坐标
 
 @return 行数
 */
- (NSInteger)HSQ_StripTypeStatisticsView_numberOfLinesAt_Y_axis {
    return 7;
}

/**
 X轴有多少个条形图
 
 @return 条形图个数
 */
- (NSInteger)HSQ_StripTypeStatisticsView_numberOfViewsAt_X_axis {
    return 3;
}


/**
 X轴布局起点，距离X轴最左端
 
 @return 布局起点
 */
- (CGFloat)HSQ_StripTypeStatisticsView_StartPointAt_X_axis {
    return HSQWidth(73);
}

/**
 X轴布局结束点，距离X轴最右端
 
 @return 布局结束点
 */
- (CGFloat)HSQ_StripTypeStatisticsView_EndPointAt_X_axis {
    return HSQWidth(47);
}

/**
 X轴上布局的view宽度
 
 @return 宽度
 */
- (CGFloat)HSQ_StripTypeStatisticsView_ViewWidthAt_X_axis {
    return HSQWidth(30);
}

/**
 X轴布局view时最小间隔，若给定间隔大于计算出来的间隔，则以给定间隔为准（此时会影响EndPoint）
 
 @return 间隔
 */
- (CGFloat)HSQ_StripTypeStatisticsView_MinimumIntervalOfViewAt_X_axis {
    return HSQWidth(68);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
