//
//  FFBusinessViewController.m
//  ExpandingView
//
//  Created by liuchang on 12/26/13.
//
//

#import "FFBusinessViewController.h"
#import "QBFlatButton.h"
#import "FFHelpers.h"
#import "FFNewsViewController.h"
#import "LeveyTabBarController.h"
#import "UIColor+FlatUI.h"
#import "FFMainVC.h"

@interface FFBusinessViewController () {
    //背景
    UIView *myBackGroundView;
}

@end

@implementation FFBusinessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多";
    //ios7适配
    [FFHelpers removerCoverView:self];
    //设置视图背景
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"viewbg.png"]]];
    //设置背景
    [self setTheBGView];
    //设置业务项
    [self setTheBussinessItem];

}

//设置背景
- (void)setTheBGView {

    myBackGroundView = [[UIView alloc]init];
    myBackGroundView.frame = CGRectMake(10, 10, 300, self.view.bounds.size.height - 140);
    myBackGroundView.backgroundColor = RGBA(243, 243, 243, 1);
    
    [self.view  addSubview:myBackGroundView];

}

//设置业务
- (void)setTheBussinessItem {
    //公告
    QBFlatButton *myOneBut = [self setTheQBFlatButton:@"公告" setSelector:@selector(slectNotice) setFaceColor:RGBA(36, 169, 225, 1) setX:5 setY:30];
    [myBackGroundView addSubview:myOneBut];
    
    //壁纸
    QBFlatButton *myTwoBut = [self setTheQBFlatButton:@"壁纸" setSelector:@selector(slectWallpaper) setFaceColor:RGBA(217, 116, 43, 1) setX:104 setY:30];
    [myBackGroundView addSubview:myTwoBut];
    
    //待添加
    QBFlatButton *myThreeBut = [self setTheQBFlatButton:@"期待..." setSelector:nil setFaceColor:RGBA(196, 226, 216, 1) setX:203 setY:30];
    [myBackGroundView addSubview:myThreeBut];
}

#pragma mark-
#pragma mark aciton
//公告
- (void)slectNotice {
    FFNewsViewController *myNoticeVC = [[FFNewsViewController alloc]init];
    [self.navigationController pushViewController:myNoticeVC animated:YES];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}

//壁纸
- (void)slectWallpaper {
    FFMainVC  *myPaperVC = [[FFMainVC alloc]init];
    [self.navigationController pushViewController:myPaperVC animated:YES];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}

//初始化QBFlatButton
- (QBFlatButton *)setTheQBFlatButton:(NSString *)myStr setSelector:(SEL)mySelector setFaceColor:(UIColor *)myFaceColor setX:(int)x setY:(int)y {
    
    QBFlatButton *btn = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(x, y, 80, 80);
    btn.faceColor = myFaceColor;
    btn.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    btn.radius = 8.0;
    btn.margin = 4.0;
    btn.depth = 3.0;
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:myStr forState:UIControlStateNormal];
    [btn addTarget:self action:mySelector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
