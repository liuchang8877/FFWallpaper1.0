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


#import "TMTestTableViewController.h"
#import "UITabBarController+hidable.h"

#import "TMPostDetailViewController.h"
#import "FFLoginRequest.h"
#import "FFStatus.h"
#import "FFUser.h"
#import "FFHelpers.h"
#import "FFDataBase.h"
#import "FFModle.h"
#import "PinterestCell.h"




@interface TMTestTableViewController () {
    
    FFLoginRequest *_loginRequest;

    UIImageView *myADD;
}

@end

@implementation TMTestTableViewController
{
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hidden;
}
@synthesize collectionView;
@synthesize items;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"SOCIAL APP!", @"");
        hidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self setTheDataBase];
    //[self setTheLoginInfo];
    //[self setTheImgDB];
    [self setThePSCollectionView];

}



//set the img to db
- (void)setTheImgDB {

    LOG(@"creat wallpapertable");
    [FFDataBase createImgWallpaperTable];
    
    
    LOG(@"insert the wallpaperinfo");
    UIImage * localPhoto = [UIImage imageNamed:@"img1.jpg"];
    
    imgWallpaper *myImgWP = [[imgWallpaper alloc]init];
    myImgWP.imgName = @"test1";
    myImgWP.imgInfo = @"test";
    myImgWP.imgType = @"person";
    myImgWP.imgData = UIImageJPEGRepresentation(localPhoto,10);
    
    NSMutableArray *myArrForImgWP = [[NSMutableArray alloc] initWithCapacity:2];
    [myArrForImgWP addObject:myImgWP];
    
    //[FFDataBase insertImgWallpaperToImgWallpaperTable:myArrForImgWP];
    
     NSMutableArray*myArr = [FFDataBase getImgWallpaperFromImgWallpaperTable];
    
    if ([myArr count] == 0) {
        
        LOG(@"select img count == 0");
    }
    
//    for (imgWallpaper *myImgWP in myArr) {
//    
//        LOG(@"name:%@,data:%@",myImgWP.imgName, myImgWP.imgData);
//    }
    
    imgWallpaper *myImgWPResult = [myArr objectAtIndex:0];
    
    UIImage *myImg = [UIImage imageWithData:myImgWPResult.imgData];
    myADD = [[UIImageView alloc]initWithImage:myImg];
    myADD.frame = CGRectMake(0, 0, 50, 50);
}

//set Creat the table
- (void)setTheDataBase {
    
    LOG(@"creat the table");
    [FFDataBase createUserInfoTable];
    
    LOG(@"insert the table");
    userInfo *myUser = [[userInfo alloc]init];
    myUser.userName = @"liuchang";
    myUser.userInfo = @"男";
    NSMutableArray *myUsers = [[NSMutableArray alloc]initWithCapacity:2];
    [myUsers addObject:myUser];
    [FFDataBase insertUserToUserInfoTable:myUsers];
    
    LOG(@"delete the tale");
    [FFDataBase deleteUserInfoFromUserInfoTable];
    
    LOG(@"select the tale");
    NSMutableArray* myUsersResult = [FFDataBase getUserInfoFromUserInfoTable];
    
    if ([myUsers count] == 0) {
    
        LOG(@"select result is empty");
    
    }
    
    for (userInfo *user in myUsersResult) {
    
        LOG(@"ID:%@, NAME:%@, INFO:%@",user.userID, user.userName, user.userInfo);
    }
    
}

#pragma mark-
#pragma mark Login
//set the login
- (void)setTheLoginInfo {
    
    _loginRequest = [[FFLoginRequest alloc] initWithUserName:@"liuchang" password:@"123"];
    _loginRequest.delegate = self;
    [_loginRequest setDidFailedSelector:@selector(requestDidFailed:)];
    [_loginRequest setDidFinishSelector:@selector(requestDidFinish:)];
    [_loginRequest start];

}

#pragma mark - LSLoginRequest delegate

- (void)requestDidFinish:(FFLoginRequest *)request
{

    
    if ([request.response isKindOfClass:[FFStatus class]]) {
        FFStatus *status = (FFStatus *)request.response;
        NSLog(@"requestDidFinish---status:%@",status);
        
    } else if ([request.response isKindOfClass:[FFUser class]]) {
        FFUser *user = (FFUser *)request.response;
        
        [FFHelpers setValue:user.userId forKey:kCurrentUserId];
        [FFHelpers setValue:user.userName forKey:kCurrentUserName];

    } 
}

- (void)requestDidFailed:(FFLoginRequest *)request
{

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:hidden 
                                             animated:YES];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController setTabBarHidden:hidden 
                                  animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    UIImage *myImage1 = [UIImage imageNamed:@"img1.jpg"];
    UIImage *myImage2 = [UIImage imageNamed:@"img2.jpg"];
    
    UIImageView *myImageView;
    
    if (indexPath.row % 2 == 0) {
    
        myImageView = [[UIImageView alloc] initWithImage:myImage1];
    } else {
        myImageView = [[UIImageView alloc] initWithImage:myImage2];
    }
    
    myImageView.frame = CGRectMake(10, 10, 300, 280);
    
    [cell addSubview:myImageView];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"Awesome Post Number: %d", indexPath.row];
    
    [cell addSubview:myADD];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    TMPostDetailViewController * pdvc = [[TMPostDetailViewController alloc] init];
    pdvc.imgeID = [NSString stringWithFormat:@"%d",indexPath.row];
    [self.navigationController pushViewController:pdvc 
                                         animated:YES];
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
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat differenceFromStart = startContentOffset - currentOffset;
    CGFloat differenceFromLast = lastContentOffset - currentOffset;
    lastContentOffset = currentOffset;
    
    
    
    if((differenceFromStart) < 0)
    {
        // scroll up
        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self expand];
    }
    else {
        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self contract];
    }
    
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
    NSLog(@"didSelectView: %d", index);
}


- (void)loadDataSource {
    // Request
    NSString *URLPath = [NSString stringWithFormat:@"http://imgur.com/gallery.json"];
    NSURL *URL = [NSURL URLWithString:URLPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!error && responseCode == 200) {
            id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (res && [res isKindOfClass:[NSDictionary class]]) {
                self.items = [res objectForKey:@"data"];
                LOG(@"------COUNT:%d",[items count]);
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
    
    self.collectionView.numColsPortrait = 2;
    self.collectionView.numColsLandscape = 3;
    
    //    NSString *deviceType = [UIDevice currentDevice].model;
    //
    //    if ([deviceType isEqualToString:@"iPhone"]) {
    //        self.collectionView.numColsPortrait = 1;
    //        self.collectionView.numColsLandscape = 2;
    //    } else {
    //        self.collectionView.numColsPortrait = 3;
    //        self.collectionView.numColsLandscape = 4;
    //    }
    //
    [self loadDataSource];
    [self.view addSubview: collectionView];
    
}


@end
