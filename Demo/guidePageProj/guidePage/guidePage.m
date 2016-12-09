//
//  guidePage.m
//  guidePageProj
//
//  Created by 张绪川 on 16/10/25.
//  Copyright © 2016年 Cedrik. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define zxc_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define zxc_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Font(s)     [[UIDevice currentDevice]systemVersion].floatValue >= 9.0 ? [UIFont fontWithName:@"PingFangTC-Light" size:s] : [UIFont fontWithName:@"HelveticaNeue-Light" size:s]


#import "guidePage.h"

@interface guidePage ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) UIPageControl * pageController;

@property (nonatomic,strong) UIButton * skipButton;

@property (nonatomic,copy) void (^dismissBlock) ();

@end

@implementation guidePage

- (instancetype)initWithDismissBlock:(void(^)())endBlock
{
  self = [super init];
  if (self) {
    self.dismissBlock = endBlock;
  }
  return self;
}

-(void)viewDidLoad{
  
  [self makeView];
  
}


-(void)makeView{
  
  self.view.backgroundColor = UIColorFromRGB(0xffffff);
  
  //make ScrollView
  self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
  self.scrollView.backgroundColor = UIColorFromRGB(0xffffff);
  self.scrollView.contentSize = CGSizeMake(zxc_SCREEN_WIDTH * 3, zxc_SCREEN_HEIGHT);
  self.scrollView.pagingEnabled = YES;
  self.scrollView.contentOffset = CGPointZero;
  self.scrollView.contentMode = UIViewContentModeTop ; 
  self.scrollView.delegate =self;
  self.scrollView.bounces = NO;
  self.scrollView.showsHorizontalScrollIndicator = NO;
  self.scrollView.showsVerticalScrollIndicator = NO;
  
  
  
  for (UIImage * img  in self.imgArr) {
    
    NSInteger  indexNum = [self.imgArr indexOfObject:img];
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(indexNum * zxc_SCREEN_WIDTH, 0, zxc_SCREEN_WIDTH, zxc_SCREEN_HEIGHT)];
    
    imgView.image = img;
    
    [self.scrollView addSubview:imgView];
    
    if([[self.imgArr lastObject] isEqual:img]){
      UIButton * buttomBtn = [[UIButton alloc]initWithFrame:CGRectMake(indexNum * zxc_SCREEN_WIDTH + zxc_SCREEN_WIDTH/2-75,zxc_SCREEN_HEIGHT-70,  150, 45)];
      [buttomBtn setImage:[[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"skipBtn" ofType:@"png"]] forState:UIControlStateNormal];
      [buttomBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
      
      [self.scrollView addSubview:buttomBtn];
      
    }
    
  }
  
  
  [self.view addSubview:self.scrollView];
  
  //make Skip Button 
  
  self.skipButton = [[UIButton alloc]initWithFrame:CGRectMake(zxc_SCREEN_WIDTH - 60, 20, 40, 40)];
  [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
  [self.skipButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
  self.skipButton.titleLabel.font = Font(14);
  self.skipButton.layer.cornerRadius = 20 ;
  self.skipButton.layer.masksToBounds = YES;
  self.skipButton.backgroundColor = UIColorFromRGB(0xdddddd);
  [self.skipButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.skipButton];
  
  self.pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(zxc_SCREEN_WIDTH/2-35, zxc_SCREEN_HEIGHT-20, 70, 15)];
  self.pageController.numberOfPages = self.imgArr.count;
  self.pageController.pageIndicatorTintColor = UIColorFromRGB(0xdfdfdf);
  self.pageController.currentPageIndicatorTintColor = UIColorFromRGB(0x9a9a9a);
  
  [self.view addSubview:self.pageController];
  
  
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
  CGPoint point =  scrollView.contentOffset;

  NSInteger  currentPage = point.x / zxc_SCREEN_WIDTH;
  
  self.pageController.currentPage = currentPage;
  
}


-(void)dismiss{

  if (self.dismissBlock) {
    self.dismissBlock();
  }
}






-(NSMutableArray *)imgArr{
    if (_imgArr == nil) {
        _imgArr  = [NSMutableArray arrayWithArray:[self getImageArray]];
    }
    return _imgArr;
}

#warning  获取图片数组-需自己设定
-(NSArray *)getImageArray{
    
    NSMutableArray * tmpArr = [NSMutableArray array];
    
    for (int i = 0; i < 3; i ++) {
        NSString * fileName = [NSString stringWithFormat:@"gp%.2d",i+1];
        NSLog(@"%@",fileName);
        
        UIImage  * image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:@"png"]];
        
        if (image) {
            [tmpArr addObject:image];
        }
        
    }
    
    return tmpArr;
    
}
@end
