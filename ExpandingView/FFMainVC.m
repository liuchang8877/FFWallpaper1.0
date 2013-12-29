//
//  FFMainVC.m
//  ExpandingView
//
//  Created by liuchang on 8/27/13.
//
//

#import "FFMainVC.h"
#import "PinterestCell.h"
#import "TMPostDetailViewController.h"
#import "FFDataBase.h"
#import "FFModle.h"
#import "LeveyTabBarController.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FFHelpers.h"

@interface FFMainVC () {
    
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hidden;
}

@end

@implementation FFMainVC
@synthesize collectionView;
@synthesize items;
@synthesize favOrNot;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        items = [@[] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //IOS7适配
    [FFHelpers removerCoverView:self];
	// Do any additional setup after loading the view.
    self.title = @"壁纸";
    //self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    
    [self setThePSCollectionView];
    [self setTheNavigationItem];
    if (favOrNot) {
        self.title = @"红心壁纸";
    }

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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark -- PSCollectionView

- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return [self.items count];
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    NSDictionary *item = [self.items objectAtIndex:index];
    
    return [PinterestCell heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    
    PinterestCell *cell = (PinterestCell *)[self.collectionView dequeueReusableView];
    if (!cell) {
        cell = [[PinterestCell alloc] initWithFrame:CGRectZero];
    }
    
    [cell fillViewWithObject:self.items[index]];
    
    return cell;
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    //NSLog(@"didSelectView: %d", index);
    
    
    TMPostDetailViewController * pdvc = [[TMPostDetailViewController alloc] init];
    pdvc.imgeID = [NSString stringWithFormat:@"%d",index];
    pdvc.itmes = [[NSMutableArray alloc] initWithArray:items];
    [self.navigationController pushViewController:pdvc
                                         animated:YES];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}
- (void)loadDataSourceFormDB {

    NSMutableArray*myFavArr = [FFDataBase getImgWallpaperFromImgWallpaperTable];
    
    for (imgWallpaper *myFavImg in myFavArr){
        
        NSMutableDictionary *myFavDic = [[NSMutableDictionary alloc] init];
        [myFavDic setObject:myFavImg.imgName forKey:@"hash"];
        [myFavDic setObject:myFavImg.imgType forKey:@"ext"];
        //[myFavDic setObject:myFavImg.imgHeight forKey:@"height"];
        //[myFavDic setObject:myFavImg.imgWidth forKey:@"width"];
        [self.items addObject:myFavDic];
    }
    
    [self.collectionView reloadData];
}

- (void)loadDataSource {
    // Request
    //NSString *URLPath = [NSString stringWithFormat:@"http://imgur.com/gallery.json"];
    NSString *URLPath = [NSString stringWithFormat:@"http://ffwallpaper.sinaapp.com/login"];
    NSURL *URL = [NSURL URLWithString:URLPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!error && responseCode == 200) {
            id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (res && [res isKindOfClass:[NSDictionary class]]) {
                self.items = [res objectForKey:@"data"];
                [self dataSourceDidLoad];
            } else {
                [self dataSourceDidError];
            }
        } else {
            [self dataSourceDidError];
        }
    }];
}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}

- (void)dataSourceDidError {
    [self.collectionView reloadData];
}

- (void)setThePSCollectionView {
    
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.collectionView];
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.delegate = self;
    
    self.collectionView.numColsPortrait = 3;
    self.collectionView.numColsLandscape = 4;

//    NSString *deviceType = [UIDevice currentDevice].model;
//    
//    if ([deviceType isEqualToString:@"iPhone"]) {
//        self.collectionView.numColsPortrait = 1;
//        self.collectionView.numColsLandscape = 2;
//    } else {
//        self.collectionView.numColsPortrait = 3;
//        self.collectionView.numColsLandscape = 4;
//    }

    
    if ([favOrNot intValue] == 1) {
        // it is in the favoriate, base on th DB
        [self loadDataSourceFormDB];
    } else {
        //get data from sever
        [self loadDataSource];
    }
    [self.view addSubview: collectionView];

}

#pragma mark - The Magic!

-(void)expand
{
    if(hidden)
        return;
    
    hidden = YES;
    
    [self.tabBarController setTabBarHidden:YES
                                  animated:YES];
    
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
}

-(void)contract
{
    if(!hidden)
        return;
    
    hidden = NO;
    
    [self.tabBarController setTabBarHidden:NO
                                  animated:YES];

    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
    //NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat currentOffset = scrollView.contentOffset.y;
//    CGFloat differenceFromStart = startContentOffset - currentOffset;
//    CGFloat differenceFromLast = lastContentOffset - currentOffset;
//    lastContentOffset = currentOffset;
//    
//    
//    if ([favOrNot intValue] != 1) {
//    
//        if((differenceFromStart) < 0)
//        {
//            // scroll up
//            if(scrollView.isTracking && (abs(differenceFromLast)>1))
//                [self expand];
//        }
//        else {
//            if(scrollView.isTracking && (abs(differenceFromLast)>1))
//                [self contract];
//        }
//    
//    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [self contract];
    return YES;
}

@end
