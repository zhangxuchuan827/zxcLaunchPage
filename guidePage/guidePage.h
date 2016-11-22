//
//  guidePage.h
//  WokeEnterpriseProject
//
//  Created by zhang on 16/10/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface guidePage : UIViewController



- (instancetype)initWithDismissBlock:(void(^)())endBlock;

@end
