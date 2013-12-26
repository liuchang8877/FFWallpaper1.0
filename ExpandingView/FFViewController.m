//
//  FFViewController.m
//  testWeb
//
//  Created by liuchang on 9/17/13.
//  Copyright (c) 2013 liuchang. All rights reserved.
//

#import "FFViewController.h"
#import "FFDetailViewController.h"
#import "LeveyTabBarController.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "SVProgressHUD.h"



@interface FFViewController () {

    UIWebView *myWebView;
}

@end

@implementation FFViewController
@synthesize localURL;
@synthesize myLoaclServer;
@synthesize myLoaclUser;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //设置HUD
    [self setTheHUD];
    [self setTheWebView];
    //设置返回
    [self setTheNavigationItem];
    
}

//设置HUD
- (void)setTheHUD {
    [SVProgressHUD showProgress:0 status:@"加载..."];
    [SVProgressHUD show];
    
}

- (void)setTheNavigationItem {
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    UIBarButtonItem *myBarItemLeft = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(goBack)];
    myBarItemLeft.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = myBarItemLeft;
    
}

- (void)goBack {
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}   

//- (void)viewWillAppear:(BOOL)animated {
//
//    [self.leveyTabBarController setTabBarTransparent:YES];
//    [self.leveyTabBarController hidesTabBar:NO animated:YES];
//}

- (void)setTheWebView{
    
    CGRect bouds = [[UIScreen mainScreen]applicationFrame];
    //CGRect bouds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 140);
    bouds.origin.y = 0.0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)  {
        bouds.size.height = bouds.size.height;
    } else {
        bouds.size.height = bouds.size.height - 40;
    }
    myWebView = [[UIWebView alloc]initWithFrame:bouds];
    
    myWebView.scalesPageToFit = YES;
    
    NSURL* url;
    if ([localURL length] > 0) {
    
            url = [NSURL URLWithString:localURL];
    } else {
    
            /*http://lolbox.duowan.com/phone/playerDetail.php?playerName=BlueAgony&serverName=%E7%BD%91%E9%80%9A%E5%9B%9B&sn=%E7%BD%91%E9%80%9A%E5%9B%9B&target=BlueAgony&timestamp=1379089461.824482&from=search&sk=523987@11T
             */
            /*http://lolbox.duowan.com/phone/playerDetail_ios.php?playerName=BlueAgony&serverName=网通四&sn=网通四&target=BlueAgony&timestamp=1383914271.400519&from=search&sk=523987@11T
             */
            NSString *myUrl =[NSString stringWithFormat:@"http://lolbox.duowan.com/phone/playerDetail_ios.php?playerName=%@&serverName=%@&sn=%@&target=%@",myLoaclUser,myLoaclServer,myLoaclServer,myLoaclUser];
            myUrl= [myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            url = [NSURL URLWithString:myUrl];
            NSLog(@"URL:%@",url);
    }

    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
    myWebView.delegate = self;
    
    [self.view addSubview:myWebView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [SVProgressHUD dismiss];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"query" ofType:@"js"];
    
    NSLog(@"filePath: %@", filePath);
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSString *jsString = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    
    [myWebView stringByEvaluatingJavaScriptFromString:jsString];
    
    
    //[self.view addSubview:myWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"ffapp"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"alert"])
        {
            
            NSLog(@"0:%@\n",[components objectAtIndex:0]);
            NSLog(@"1:%@\n",[components objectAtIndex:1]);
            NSLog(@"2:%@\n",[components objectAtIndex:2]);
            NSLog(@"3:%@\n",[components objectAtIndex:3]);
            
            NSString* localDetailURL = [NSString stringWithFormat:@"%@:%@",[components objectAtIndex:2],[components objectAtIndex:3]];
            
            FFDetailViewController *myDetailVC = [[FFDetailViewController alloc] init];
            //设置跳转页面URL
            myDetailVC.localURL = localDetailURL;
            [self.navigationController pushViewController:myDetailVC animated:NO];
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
        }
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
