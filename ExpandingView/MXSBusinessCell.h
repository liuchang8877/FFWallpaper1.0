//
//  MXSBusinessCell.h
//  xuexin
//
//  Created by liuchang on 10/24/13.
//  Copyright (c) 2013 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXSNewsInfo.h"
#import "MyImageView.h"

@interface MXSBusinessCell : UITableViewCell


//设置数据
- (void)setTheDataOfNewsList:(MXSNewsInfo *)vNewsInfo;
//设置新闻表
- (void)setTheNewsList;
@end
