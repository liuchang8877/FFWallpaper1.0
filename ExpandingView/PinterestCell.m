//
//  PinterestCell.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 13-1-26.
//  Copyright (c) 2013年 ZhangYiCheng. All rights reserved.
//

#import "PinterestCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation PinterestCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
//        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_imageView];
    }
    return self;
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    CGFloat objectWidth = [[object objectForKey:@"width1"] floatValue];
    CGFloat objectHeight = [[object objectForKey:@"height1"] floatValue];
    if (objectWidth == 0) {
        objectWidth = columnWidth;
    }
    if (objectHeight == 0) {
        objectHeight = columnWidth;
    }
    
    
    CGFloat imageHeight = 130;
//    float height = DEVICE_IS_IPHONE5?568:480;
//    if (height == 568) {
//        imageHeight = 130;
//    } else {
//        //imageHeight = objectHeight / objectWidth * columnWidth;
//        imageHeight = 130;
//    } 
    
    return imageHeight;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];
    //NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ffwallpaper-wallpaper.stor.sinaapp.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];

    [self.imageView setImageWithURL:URL];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    NSLog(@"%f %f", self.imageView.frame.size.width, self.imageView.frame.size.height);
}

@end
