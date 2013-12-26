//
//  FFAboutViewController.m
//  ExpandingView
//
//  Created by liuchang on 10/8/13.
//
//

#import "FFAboutViewController.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "SVProgressHUD.h"

@interface FFAboutViewController () {

    UIWebView *myWebView;
}

@end

@implementation FFAboutViewController

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
    
    NSString *mylocalURL = @"http://1.orangebear.sinaapp.com/?page_id=7";
    //NSString *mylocalURL = @"http://www.baidu.com";
    NSURL* url = [NSURL URLWithString:mylocalURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"query" ofType:@"js"];
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSString *jsString = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    
    [myWebView stringByEvaluatingJavaScriptFromString:jsString];
    
    //[self.view addSubview:myWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //    NSString *requestString = [[request URL] absoluteString];
    //    NSArray *components = [requestString componentsSeparatedByString:@":"];
    //    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"ffapp"]) {
    //        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"alert"])
    //        {
    //
    //            NSLog(@"0:%@\n",[components objectAtIndex:0]);
    //            NSLog(@"1:%@\n",[components objectAtIndex:1]);
    //            NSLog(@"2:%@\n",[components objectAtIndex:2]);
    //            NSLog(@"3:%@\n",[components objectAtIndex:3]);
    //
    //            NSString* localDetailURL = [NSString stringWithFormat:@"%@:%@",[components objectAtIndex:2],[components objectAtIndex:3]];
    //
    //            FFViewController *myDetailVC = [[FFViewController alloc] init];
    //            //设置跳转页面URL
    //            myDetailVC.localURL = localDetailURL;
    //
    //            [self.navigationController pushViewController:myDetailVC animated:YES];
    //        }
    //        return NO;
    //
    //    } else if ([(NSString *)[components objectAtIndex:0] isEqualToString:@"http://playerDetail"]) {
    //
    //        FFViewController *myDetailVC = [[FFViewController alloc] init];
    //        //设置跳转页面URL
    //        myDetailVC.localURL = requestString;
    //
    //        [self.navigationController pushViewController:myDetailVC animated:NO];
    //    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
