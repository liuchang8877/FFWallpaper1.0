/*
 Copyright (c) 2012, Tony Million.
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE. 
 */

#import "TMAppDelegate.h"
#import "FFMainVC.h"
#import <QuartzCore/QuartzCore.h>
#import "LeveyTabBarController.h"
#import "FFSetNameViewController.h"
#import "FFViewController.h"
#import "FFSettingViewController.h"
#import "FFNewsViewController.h"
#import "FFBusinessViewController.h"
#import "FFMainVC.h"
#import "MobClick.h"
#import "FFHelpers.h"
#import "MXSNewsViewController.h"

@implementation TMAppDelegate {

    UIImageView *zView;//Z图片ImageView
    UIImageView *fView;//F图片ImageView
    
    
    UIView *rView;//图片的UIView
    LeveyTabBarController *leveyTabBarController;

}

@synthesize window = _window;
@synthesize tabbar;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //设置Nav样式
    [self setTheNavBar];
    //友盟分析
    [MobClick startWithAppkey:@"527ce65a56240b8df4039129"];
    //开启分析
    //[MobClick setLogEnabled:YES];
//    //隐藏statusbar
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [application setStatusBarStyle:UIStatusBarStyleLightContent];
//        self.window.clipsToBounds =YES;
//        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
//        
//        //Added on 19th Sep 2013
//        self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
//    }
    
    //self.tabbar = [[UITabBarController alloc] init];
    
    //self.window.rootViewController = self.tabbar;
    
    //TMTestTableViewController   *mainController = [[TMTestTableViewController alloc] init];
    
//    //首页
//    FFMainVC *mainController = [[FFMainVC alloc]init];
//    UINavigationController      *mainNav = [[UINavigationController alloc] initWithRootViewController:mainController];
//    //mainNav.navigationBarHidden = YES;
//    mainNav.delegate = (id)self;
    
    //新闻
    MXSNewsViewController *myNewsVC = [[MXSNewsViewController alloc]init];
    UINavigationController      *myNewsNav = [[UINavigationController alloc] initWithRootViewController:myNewsVC];
    myNewsNav.delegate = (id)self;
    
    //战斗力查询
    FFSetNameViewController *setNameVC = [[FFSetNameViewController alloc]init];
    UINavigationController *setNameNav = [[UINavigationController alloc] initWithRootViewController:setNameVC];
    //setNameNav.navigationBarHidden = YES;
    setNameNav.delegate = (id)self;
    
//    //新闻
//    FFNewsViewController *myNewsVC = [[FFNewsViewController alloc]init];
//    UINavigationController *myNewsNav = [[UINavigationController alloc] initWithRootViewController:myNewsVC];
//    myNewsNav.delegate = (id)self;
    //业务
    FFBusinessViewController *myBusVC = [[FFBusinessViewController alloc]init];
    UINavigationController *myBusNav  = [[UINavigationController alloc]initWithRootViewController:myBusVC];
    //myBusNav.navigationBarHidden = YES;
    myBusNav.delegate = (id)self;
    
    //设置
    FFSettingViewController *mySetVC = [[FFSettingViewController alloc]init];
    UINavigationController *mySetNav = [[UINavigationController alloc] initWithRootViewController:mySetVC];
    //mySetNav.navigationBarHidden = YES;
    mySetNav.delegate = (id)self;
    
    //[self.tabbar setViewControllers:[NSArray arrayWithObject:mainNav]];
    //mainNav.navigationBar.tintColor = [UIColor blackColor];
    //self.window.rootViewController = mainNav;

    //UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:mainNav];
    //nc2.delegate = (id)self;

	NSArray *ctrlArr = [NSArray arrayWithObjects:myNewsNav,setNameNav,myBusNav,mySetNav,nil];
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"11.png"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"11.png"] forKey:@"Highlighted"];
	[imgDic setObject:[UIImage imageNamed:@"101.png"] forKey:@"Selected"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"12.png"] forKey:@"Default"];
	[imgDic2 setObject:[UIImage imageNamed:@"12.png"] forKey:@"Highlighted"];
	[imgDic2 setObject:[UIImage imageNamed:@"102.png"] forKey:@"Selected"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"13.png"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"13.png"] forKey:@"Highlighted"];
	[imgDic3 setObject:[UIImage imageNamed:@"103.png"] forKey:@"Selected"];
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"14.png"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"14.png"] forKey:@"Highlighted"];
	[imgDic4 setObject:[UIImage imageNamed:@"104.png"] forKey:@"Selected"];

	
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,nil];
	
	leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr];
	[leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"xx_tabbar_bg.png"]];
	//[leveyTabBarController setTabBarTransparent:YES];
//	[self.window addSubview:leveyTabBarController.view];
//    
//    // Override point for customization after application launch.
//    //self.window.backgroundColor = [UIColor redColor];
    
//    self.window.backgroundColor = RGBA(36, 169, 225, 1);
//    //[self.window addSubview:leveyTabBarController.view];
//    self.window.rootViewController = leveyTabBarController;
//    [self.window makeKeyAndVisible];
    
    fView =[[UIImageView alloc]initWithFrame:self.window.frame];//初始化fView
    fView.image=[UIImage imageNamed:@"f.png"];//图片f.png 到fView
    
    zView=[[UIImageView alloc]initWithFrame:self.window.frame];//初始化zView
    zView.image=[UIImage imageNamed:@"z.png"];//图片z.png 到zView
    
    rView=[[UIView alloc]initWithFrame:self.window.frame];//初始化rView
    
    [rView addSubview:fView];//add 到rView
    //[rView addSubview:zView];//add 到rView
    
    [self.window addSubview:rView];//add 到window
    
    [self performSelector:@selector(TheAnimation) withObject:nil afterDelay:0];//3秒后执行TheAnimation

    return YES;
}

//设置Nav样式
- (void)setTheNavBar {
    
    if (IOS7) {
        //设置NavBar样式
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:10.0 green:10.0 blue:10.0 alpha:0.6];
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               RGBA(234, 234, 234, 1), NSForegroundColorAttributeName,
                                                               shadow, NSShadowAttributeName,
                                                               [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0], NSFontAttributeName, nil]];
        //xx_tabbar_bg xx_nav_bar_bg1.png
        //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"xx_nav_bar_bg1.png"] forBarMetrics:UIBarMetricsDefault];//导航条设置
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"xx_nav_bar_bg1.png"] forBarMetrics:UIBarMetricsDefault];
        //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        //[[UINavigationBar appearance] setBarTintColor:RGBA(36, 169, 225, 1)];

    } else {
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"xx_nav_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];//导航条设置
    }


}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    else if ([viewController isKindOfClass:[FFMainVC class]]) {
//        
//        FFMainVC *myMainVC = (FFMainVC *)viewController;
//        if ([myMainVC.favOrNot intValue] != 1) {
//            
//            [leveyTabBarController hidesTabBar:NO animated:YES];
//        }
//    }
    
	if ([viewController isKindOfClass:[FFSetNameViewController class]] ){
        
       [leveyTabBarController hidesTabBar:NO animated:YES];
	} else if ([viewController isKindOfClass:[FFSettingViewController class]]) {
    
        [leveyTabBarController hidesTabBar:NO animated:YES];
    } else if ([viewController isKindOfClass:[FFBusinessViewController class]]) {
            [leveyTabBarController hidesTabBar:NO animated:YES];
    }else if ([viewController isKindOfClass:[MXSNewsViewController class]]) {
        
        [leveyTabBarController hidesTabBar:NO animated:YES];
    }
}

- (void)TheAnimation{
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7 ;  // 动画持续时间(秒)
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;//淡入淡出效果
    
    NSUInteger f = [[rView subviews] indexOfObject:fView];
    NSUInteger z = [[rView subviews] indexOfObject:zView];
    [rView exchangeSubviewAtIndex:z withSubviewAtIndex:f];
    
    [[rView layer] addAnimation:animation forKey:@"animation"];
    
    [self performSelector:@selector(ToUpSide) withObject:nil afterDelay:2];//2秒后执行TheAnimation
}

#pragma mark - 上升效果
- (void)ToUpSide {
    
    [self moveToUpSide];//向上拉界面
    
}

- (void)moveToUpSide {
    
    [UIView animateWithDuration:0.7 //速度0.7秒
                     animations:^{//修改rView坐标
                         rView.frame = CGRectMake(self.window.frame.origin.x,
                                                  -self.window.frame.size.height,
                                                  self.window.frame.size.width,
                                                  self.window.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                         self.window.backgroundColor = RGBA(0, 0, 0, 1);
                         //[self.window addSubview:leveyTabBarController.view];
                         self.window.rootViewController = leveyTabBarController;
                         [self.window makeKeyAndVisible];

                     }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
