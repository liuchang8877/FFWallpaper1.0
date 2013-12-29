//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 SlyFairy. All rights reserved.
//

#import "LeveyTabBar.h"

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;
@synthesize animatedView = _animatedView;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		CGFloat width = 320.0f / [imageArray count];
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
			btn.frame = CGRectMake(width * i + 3, 4, width, frame.size.height);
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Selected"] forState:UIControlStateSelected];
            if ([[imageArray objectAtIndex:i] objectForKey:@"Selected|Highlighted"]) {
                [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Selected|Highlighted"] forState:UIControlStateSelected | UIControlStateHighlighted];
            }
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
        
//        //添加名称
//        NSMutableArray *myNameArr = [[NSMutableArray alloc]initWithCapacity:5];
//        [myNameArr addObject:@"壁纸"];
//        [myNameArr addObject:@"查询"];
//        [myNameArr addObject:@"公告"];
//        [myNameArr addObject:@"设置"];
//        CGFloat nameWidth = 320.0f / [myNameArr count];
//        for (int i = 0; i < [myNameArr count]; i++) {
//            UILabel *myLabel = [[UILabel alloc]init];
//            myLabel.frame = CGRectMake(nameWidth*i + 27, 15, width - 10, frame.size.height);
//            myLabel.font = [UIFont systemFontOfSize:12];
//            myLabel.text = [myNameArr objectAtIndex:i];
//            myLabel.backgroundColor = [UIColor clearColor];
//            myLabel.textColor = [UIColor whiteColor];
//            [self addSubview:myLabel];
//        }
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)setAnimatedView:(UIImageView *)animatedView
{
    [animatedView retain];
    [_animatedView release];
    _animatedView = animatedView;
    [self addSubview:animatedView];
}

- (void)tabBarButtonClicked:(id)sender
{
    UIButton *btn = sender;
    int index = btn.tag;
    if ([_delegate respondsToSelector:@selector(tabBar:shouldSelectIndex:)])
    {
        if (![_delegate tabBar:self shouldSelectIndex:index])
        {
            return;
        }
    }
    [self selectTabAtIndex:index];
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
	}
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        _animatedView.frame = CGRectMake(btn.frame.origin.x, _animatedView.frame.origin.y, _animatedView.frame.size.width, _animatedView.frame.size.height);
    }];
    
    NSLog(@"Select index: %d",btn.tag);
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
   
    // Re-index the buttons
     CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons) 
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons) 
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Selected"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

- (void)dealloc
{
    [_backgroundView release];
    [_buttons release];
    [_animatedView release];
    [super dealloc];
}

@end
