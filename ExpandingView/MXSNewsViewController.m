//
//  MXSNewsViewController.m
//  xuexin
//
//  Created by liuchang on 10/30/13.
//  Copyright (c) 2013 mx. All rights reserved.
//

#import "MXSNewsViewController.h"
#import "MXSBusinessCell.h"
#import "SVPullToRefresh.h"
#import "FFHelpers.h"
#import "UIImageView+WebCache.h"
#import "MXSNewsInfo.h"
#import "FFNewsDetailViewController.h"

//#import "MXSNewsDetailViewController.h"

@interface MXSNewsViewController () {
    
    MXSNewslistRequest *_newsListRequest;
    NSMutableArray *myNewsListArr;
    UITableView *myTableView;
    //------ScrollView
    UIScrollView *myADScrollView;
    UIPageControl *page;
    int TimeNum;
    BOOL Tend;
}

@end

@implementation MXSNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"新闻";
    [FFHelpers removerCoverView:self];//去掉ios7下被导航栏遮挡UIView得问题
    //更新数据
    [self loadTheData];
    //设置table
    [self setTheTableView];
    [myTableView triggerPullToRefresh];
    //设置scrollerview
    [self setTheScrollView];
    //设置pangecontrol
    [self setThePageControl];
}

#pragma mark-
#pragma mark setTheScrollView
- (void)setTheScrollView {
    myADScrollView = [[UIScrollView alloc]init];
    myADScrollView.frame = CGRectMake(0, 5, 320, 130);
    myADScrollView.backgroundColor = [UIColor clearColor];
    //不现实滚动条
    myADScrollView.showsVerticalScrollIndicator=NO;
    myADScrollView.showsHorizontalScrollIndicator=NO;
    //锁定滚动
    myADScrollView.directionalLockEnabled=YES;
    myADScrollView.pagingEnabled=NO;
    //设置timer
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    [self.view addSubview:myADScrollView];

}

- (void)setThePageControl {
    //定义PageControll
    
    page = [[UIPageControl alloc] init];
    
    page.frame = CGRectMake(150, 125, 20, 20);//指定位置大小
    
    page.numberOfPages = 4;//指定页面个数
    
    page.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    
    //[page addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:page];
}

#pragma mark - 5秒换图片
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 5 == 0 ) {
        
        if (!Tend) {
            page.currentPage++;
            if (page.currentPage==page.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            page.currentPage--;
            if (page.currentPage==0) {
                Tend=NO;
            }
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             myADScrollView.contentOffset = CGPointMake(page.currentPage*320,0);
                         }];
        
        
    }
    TimeNum ++;
}

#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    page.currentPage=scrollView.contentOffset.x/320;
    [self setCurrentPage:page.currentPage];
    
    
}
- (void) setCurrentPage:(NSInteger)secondPage {
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [page.subviews count]; subviewIndex++) {
        UIImageView* subview = [page.subviews objectAtIndex:subviewIndex];
        CGSize size;
        //size.height = 24/2;
        //size.width = 24/2;
        //[subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
        //                             size.width,size.height)];
        
//        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"a.png"]];
//        else [subview setImage:[UIImage imageNamed:@"d.png"]];
    }
}

//添加头部广告图
-(void)AdImg:(NSArray*)arr{
    [myADScrollView setContentSize:CGSizeMake(320*[arr count], 189)];
    page.numberOfPages=[arr count];
    
    for ( int i=0; i<[arr count]; i++) {
        //新闻项
        MXSNewsInfo *myNewsInfo = [arr objectAtIndex:i];
        UIImageView *myImageView = [[UIImageView alloc]init];
        myImageView.frame = CGRectMake(320*i, 0, 320, 130);
        [myImageView setImageWithURL:[NSURL URLWithString:myNewsInfo.img] placeholderImage:[UIImage imageNamed:myNewsInfo.img]];
        [myADScrollView addSubview:myImageView];
        //标题项目
        UILabel *myLabelTitle = [[UILabel alloc]init];
        myLabelTitle.frame = CGRectMake(20, 10, 260, 60);
        myLabelTitle.backgroundColor = [UIColor clearColor];
        myLabelTitle.font = [UIFont boldSystemFontOfSize:18];
        myLabelTitle.textColor = [UIColor whiteColor];
        //自动换行
        [myLabelTitle setNumberOfLines:0];
        myLabelTitle.text = myNewsInfo.title;
        [myImageView addSubview:myLabelTitle];
        
        //这只响应button
        UIButton *img=[[UIButton alloc]initWithFrame:CGRectMake(320*i, 0, 320, 130)];
        [img addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
        img.backgroundColor = [UIColor clearColor];
        //[img addSubview:myNewsInfo];
        [myADScrollView addSubview:img];

    }
}

//myADScrollView点击响应
-(void)Action{
    
}

//更新数据
- (void)loadTheData {
    
    _newsListRequest = [[MXSNewslistRequest alloc] initWithNewsList:@"newslist" setLocation:@"0"];
    _newsListRequest.delegate = self;
    [_newsListRequest setDidFailedSelector:@selector(requestDidFailed:)];
    [_newsListRequest setDidFinishSelector:@selector(requestDidFinish:)];
    [_newsListRequest start];
    
}

#pragma mark - MXSNewslistRequest delegate
- (void)requestDidFinish:(MXSNewslistRequest *)request
{
    if ([request.response isKindOfClass:[FFStatus class]]) {
        FFStatus *status = (FFStatus *)request.response;
        NSLog(@"requestDidFinish---status:%@",status);
        
    } else if ([request.response isKindOfClass:[NSMutableArray class]]) {
        
        myNewsListArr = (NSMutableArray *)request.response;
        //这只标题图
        if ([myNewsListArr count] > 4) {
            NSRange range = NSMakeRange ([myNewsListArr count] - 4, 4);
            NSArray *myTitleImgArr =[myNewsListArr subarrayWithRange:range];
            [self AdImg:myTitleImgArr];
        }
        [myTableView reloadData];
        DLog(@"request load data myNewsListArr ok!");
        
    }
}

- (void)requestDidFailed:(MXSNewslistRequest *)request
{
    DLog(@"error%@",request.error);
}


- (void)setTheTableView
{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, 320, self.view.frame.size.height - 232) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundView = nil;
    myTableView.backgroundColor = RGBA(236, 236, 236, 1);
    //myTableView.backgroundColor = [UIColor yellowColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:myTableView];
    
    //设置pull 更新
    __weak MXSNewsViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [myTableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    
    // setup infinite scrolling
    //    [myTableView addInfiniteScrollingWithActionHandler:^{
    //        [weakSelf insertRowAtBottom];
    //    }];
}

#pragma mark - Actions

//- (void)setupDataSource {
//    self.dataSource = [NSMutableArray array];
//    for(int i=0; i<15; i++)
//        [self.dataSource addObject:[NSDate dateWithTimeIntervalSinceNow:-(i*90)]];
//}

- (void)insertRowAtTop {
    //更新数据
    //[self loadTheData];
    //__weak MXSBusinessViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [myTableView beginUpdates];
        [self loadTheData];
        //        [myNewsListArr insertObject:myNewsListArr.firstObject atIndex:0];
        //        [myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [myTableView endUpdates];
        
        [myTableView.pullToRefreshView stopAnimating];
    });
}

- (void)insertRowAtBottom {
    //__weak MXSBusinessViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [myTableView beginUpdates];
        [myNewsListArr addObject:myNewsListArr.lastObject];
        [myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:myNewsListArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [myTableView endUpdates];
        
        [myTableView.infiniteScrollingView stopAnimating];
    });
}

#pragma mark tableview delegate
#pragma mark tableview datasource
- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myNewsListArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDefine = @"cellstyleDefine";
    MXSBusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDefine];
    if (cell == nil) {
        cell = [[MXSBusinessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDefine];
    }
    
    //设置数据
    if (indexPath.row < [myNewsListArr count]) {
        //反转
        NSArray * myArr = [[myNewsListArr reverseObjectEnumerator] allObjects];
        [cell setTheDataOfNewsList:[myArr objectAtIndex:indexPath.row]];
    }
    [cell setTheNewsList];
    
    return cell;
}

#pragma mark table didseleted
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFNewsDetailViewController *myNewsDetailVC = [[FFNewsDetailViewController alloc]init];
    myNewsDetailVC.myNewsInfo = [myNewsListArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:myNewsDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
