//
//  FFNewsDetailViewController.m
//  ExpandingView
//
//  Created by liu on 13-12-29.
//
//

#import "FFNewsDetailViewController.h"
#import "SVProgressHUD.h"
#import "FFHelpers.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "SVProgressHUD.h"

@interface FFNewsDetailViewController () {

    UIWebView *myWebView;
    BOOL    flagForOnce;
}

@end

@implementation FFNewsDetailViewController
@synthesize myNewsInfo;

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
    //ios7适配
    [FFHelpers removerCoverView:self];
    //设置HUD
    [self setTheHUD];
    //设置web
    [self setTheWebView];
    //设置返回
    [self setTheNavigationItem];
    //执行一次
    flagForOnce = YES;
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

//设置HUD
- (void)setTheHUD {
    [SVProgressHUD showProgress:0 status:@"加载..."];
    [SVProgressHUD show];
    
}

//设置web
- (void)setTheWebView{
    
    //CGRect bouds = [[UIScreen mainScreen]applicationFrame];
    CGRect bouds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 90);

    //bouds.size.height = bouds.size.height - 40;
    
    myWebView = [[UIWebView alloc]initWithFrame:bouds];
    
    myWebView.scalesPageToFit = YES;
    NSString *localURL = [NSString stringWithFormat:@"%@?updateID=%@",kNewsDetailUrl,myNewsInfo.updateID];
    NSURL* url = [NSURL URLWithString:localURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //隐藏
    [SVProgressHUD dismiss];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"query" ofType:@"js"];
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSString *jsString = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    
    [myWebView stringByEvaluatingJavaScriptFromString:jsString];
    
    //[self.view addSubview:myWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"ffapp"]) {

    }
    
    if (flagForOnce) {
        flagForOnce = NO;
        return YES;
    }else {
        return NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
