//
//  guidePage.m
//  guidePageProj
//
//  Created by 张绪川 on 16/10/25.
//  Copyright © 2016年 Cedrik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface guidePage : UIViewController

@property (nonatomic,strong) NSMutableArray<UIImage*> * imgArr;


- (instancetype)initWithDismissBlock:(void(^)())endBlock;

@end
