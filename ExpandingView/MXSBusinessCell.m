//
//  MXSBusinessCell.m
//  xuexin
//
//  Created by liuchang on 10/24/13.
//  Copyright (c) 2013 mx. All rights reserved.
//

#import "MXSBusinessCell.h"
#import "UIImageView+WebCache.h"
@implementation MXSBusinessCell {
    
    MXSNewsInfo *myNewsInfo;
    //新闻图标
    MyImageView *imageView;
    //新闻图
    UIImageView *imageViewCache;
    //新闻标题
    UILabel     *myNewsTitelLabel;
    
    //新闻描述
    UILabel     *myNewsDesLabel;
    
    //新闻日期
    UILabel     *myNewsDateLabel;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //没有选择样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//设置数据
- (void)setTheDataOfNewsList:(MXSNewsInfo *)vNewsInfo {
    //设置数据
    myNewsInfo = vNewsInfo;
}

//设置新闻表
- (void)setTheNewsList {

    //设置新闻图标
    [self setTheNewsImg];
    
    //设置新闻标题
    [self setTheNewsTitle];
    
    //设置新闻描述
    [self setTheNewsDes];
    
    //设置新闻日期
    [self setTheNewsDate];
}

//设置新闻图标
- (void)setTheNewsImg {

//    if (imageView == nil) {
//        
//        imageView = [[MyImageView alloc]init];
//        imageView.frame = CGRectMake(20, 5, 80, 80);
//    }
//    //[imageView startRequest:myNewsInfo.ico];
//    
//    [self addSubview:imageView];
    
    if (imageViewCache == nil) {
        imageViewCache = [[UIImageView alloc]init];
        imageViewCache.frame = CGRectMake(20, 5, 80, 80);
        //圆角
        imageViewCache.layer.masksToBounds = YES;
        imageViewCache.layer.cornerRadius = 6;
        //边框颜色
        imageViewCache.layer.borderWidth = 1;
        imageViewCache.layer.borderColor = [[UIColor lightGrayColor] CGColor];

        
        [imageViewCache setImageWithURL:[NSURL URLWithString:myNewsInfo.img] placeholderImage:[UIImage imageNamed:myNewsInfo.img]];
        [self addSubview:imageViewCache];
    } else {
        [imageViewCache setImageWithURL:[NSURL URLWithString:myNewsInfo.img] placeholderImage:[UIImage imageNamed:myNewsInfo.img]];
    }
}

//设置新闻标题
- (void)setTheNewsTitle {

    if (myNewsTitelLabel == nil) {
        myNewsTitelLabel = [self setTheInfoOfCell:myNewsInfo.title setX:110 setY:10];
    } else {
    
        myNewsTitelLabel.text = myNewsInfo.title;
    }
}

//设置新闻描述
- (void)setTheNewsDes {
    
    if (myNewsDesLabel == nil) {
        myNewsDesLabel = [self setTheDesInfoOfCell:@"" setX:110 setY:30];
        myNewsDesLabel.lineBreakMode = UILineBreakModeWordWrap;
        myNewsDesLabel.numberOfLines = 0;
    } else {
        //myNewsDesLabel.text = myNewsInfo.des;
    }
}

//设置新闻日期
- (void)setTheNewsDate {
    
    if (myNewsDateLabel == nil) {
       myNewsDateLabel  = [self setTheInfoOfCell:myNewsInfo.pubtime setX:260 setY:46];
    } else {
        myNewsDateLabel.text = myNewsInfo.pubtime;
    }

}

//设置详情信息
- (UILabel *)setTheDesInfoOfCell:(NSString*)myInfoStr setX:(int)x setY:(int)y {
    
    UILabel *myInfoLable        = [[UILabel alloc]init];
    myInfoLable.frame           = CGRectMake(x, y, 200, 50);
    myInfoLable.font            = [UIFont systemFontOfSize:10];
    myInfoLable.backgroundColor = [UIColor clearColor];
    myInfoLable.textColor       = [UIColor grayColor];
    myInfoLable.text            = myInfoStr;
    
    [self addSubview:myInfoLable];
    
    return myInfoLable;
}


//设置详情信息
- (UILabel *)setTheInfoOfCell:(NSString*)myInfoStr setX:(int)x setY:(int)y {
    
    UILabel *myInfoLable        = [[UILabel alloc]init];
    myInfoLable.frame           = CGRectMake(x, y, 200, 40);
    myInfoLable.font            = [UIFont boldSystemFontOfSize:12];
    myInfoLable.backgroundColor = [UIColor clearColor];
    myInfoLable.textColor       = [UIColor grayColor];
    myInfoLable.text            = myInfoStr;
    //自动换行
    [myInfoLable setNumberOfLines:0];
    
    [self addSubview:myInfoLable];
    
    return myInfoLable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
