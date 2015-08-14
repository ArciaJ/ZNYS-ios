//
//  ViewController.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "CabinetViewController.h"
#import "Config.h"
#import "ConfigOfImageOverCabinet.h"

@interface CabinetViewController ()

@property (nonatomic) int currentPageNumberOfCabinet;

@property (strong, nonatomic) NSArray *listOfImageOverCabinet;//首页卡通形象属性列表

@property (strong, nonatomic) IBOutlet UIView *cabinetView;     //礼品柜视图

@property (strong, nonatomic) IBOutlet UIImageView *imageOverCabinet;   //首页卡通人头

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOfHomePageCartoon;       //首页卡通人头高度约束

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraintBetweenCartoonAndCabinet;     //首页卡通形象与礼品柜之间的y坐标约束

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;        //盛放礼品柜视图的滑动视图

@property (strong,nonatomic) UIPageControl *cabinetPageControl;
- (IBAction)synchronize:(id)sender;

@end

@implementation CabinetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //设置PageController
    self.cabinetPageControl = [[UIPageControl alloc] initWithFrame:self.cabinetView.bounds];
    self.cabinetPageControl.numberOfPages = 2;
    [self.cabinetPageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self.cabinetView addSubview:self.cabinetPageControl];
    
    //获取当前礼品柜页数
    [self getCurrentPageNumberOfCabinet];
    
    //读取首页卡通形象属性列表
    [self loadConfigListOfImageOverCabinet];
    
    //动态调整卡通形象
    [self adjustImageOverCabinet];
    
    //初始化奖品状态管理器
    self.giftStatusManager = [[GiftStatusManager alloc] init];
    
    //输出Debug的Log信息
    [self debugLog];
    
    NSArray *cabinetSubViews = [self.cabinetPageControl subviews];
    
    int count = 0;
    for(UIView *subView in cabinetSubViews)
    {
#if MYDEBUG == YES
        NSLog(@"Subview's type of pageControl:%@",[subView class]);
        count++;
        
#else
        if([NSStringFromClass([subView class]) isEqualToString:@"ImageView"])
        {
            ;
        }
#endif
    }
    NSLog(@"Total number of subviews is:%d",count);
 

}

- (void)pageChanged:(id)sender
{
    UIPageControl *control = (UIPageControl *)sender;
    NSInteger page = control.currentPage;
    NSArray *giftArray = [self.giftStatusManager giftOfPage:page];
    NSArray *cabinetSubViews = [self.cabinetView subviews];
    for(UIView *subView in cabinetSubViews)
    {
#if MYDEBUG == YES
        NSLog(@"Subview's type of cabinetView:%@",[subView class]);
#else
        if([NSStringFromClass([subView class]) isEqualToString:@"ImageView"])
        {
            ;
        }
#endif
    }
    
}

- (void)adjustImageOverCabinet
{
    ConfigOfImageOverCabinet *currentConfigOfImageOverCabinet;
    currentConfigOfImageOverCabinet = self.listOfImageOverCabinet[self.currentPageNumberOfCabinet];
    /*
    CGRect rect = self.imageOverCabinet.frame;
    rect.origin.y = self.cabinetView.frame.origin.y - self.imageOverCabinet.frame.size.height - currentConfigOfImageOverCabinet.ratio * self.cabinetView.frame.size.height;
    self.imageOverCabinet.frame = rect;
     */
    self.constraintBetweenCartoonAndCabinet.constant = -((double)1.0 -currentConfigOfImageOverCabinet.ratio) * self.heightConstraintOfHomePageCartoon.constant;
}

- (void)debugLog
{
   
    
}

//未完成
- (void)loadConfigListOfImageOverCabinet
{
    ConfigOfImageOverCabinet *cfi = [ConfigOfImageOverCabinet alloc];
    cfi.ratio = 0.7042641;
    self.listOfImageOverCabinet = [[NSArray alloc] initWithObjects:cfi,nil];
}

- (int)getCurrentPageNumberOfCabinet
{
    //返回的页码数从0开始编码
    return 0;
}

- (IBAction)synchronize:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end//  ViewController