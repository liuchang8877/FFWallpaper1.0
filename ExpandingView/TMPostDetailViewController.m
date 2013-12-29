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

#import "TMPostDetailViewController.h"
#import "FFHelpers.h"
#import "UIImageView+WebCache.h"
#import "FFModle.h"
#import "FFDataBase.h"
#import "FFMainVC.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "UIFont+FlatUI.h"
#import "FFHelpers.h"
@interface TMPostDetailViewController ()

@end

@implementation TMPostDetailViewController
@synthesize imgeID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = NO;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //ios7适配
    [FFHelpers removerCoverView:self];
    [self setTheBar];
    [self setTheNavigationItem];
    [self setTheImageByID];
}

- (void)setTheNavigationItem {
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    UIBarButtonItem *myBarItemLeft = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(showPlainTableView)];
    myBarItemLeft.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = myBarItemLeft;
    
    UIBarButtonItem *myBarItemRight = [[UIBarButtonItem alloc] initWithTitle:@"红心壁纸"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                      action:@selector(showBookMark:)];
    myBarItemRight.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = myBarItemRight;

}

- (void)showPlainTableView {

    [self.navigationController popViewControllerAnimated:YES];
}

//get the the favorite
- (void)showBookMark: (id)sender{
    FFMainVC *myFavVC = [[FFMainVC alloc] init];
    myFavVC.favOrNot = @"1";
    [self.navigationController pushViewController:myFavVC animated:YES];
    
}

- (void)viewDidUnload
{
    [self setMyToolBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//set the bar
-(void)setTheBar {

    //self.myToolBar.barStyle = UIBarStyleDefault;
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar.png"]
                            forToolbarPosition:UIBarPositionBottom
                                    barMetrics:UIBarMetricsDefault];
    
    FUIButton *myButtonLeft = [[FUIButton alloc]init];
    myButtonLeft.frame = CGRectMake(10, 5, 100, 35);
    //[myButton.titleLabel setText:@"ok"];
    [myButtonLeft.titleLabel setTextColor:[UIColor whiteColor]];
    myButtonLeft.cornerRadius  = 3;
    [myButtonLeft setTitle:@"红心" forState:UIControlStateNormal];
    myButtonLeft.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [myButtonLeft setButtonColor:[UIColor peterRiverColor]];
    [myButtonLeft addTarget:self action:@selector(selectLeftAction:) forControlEvents:UIControlEventTouchDown];
    //[myButton setShadowColor:[UIColor grayColor]];
    //[myButton setShadowHeight:3];
    //[self.view addSubview:myButton];

    [self.myToolBar addSubview:myButtonLeft];
    
    FUIButton *myButtonRight = [[FUIButton alloc]init];
    myButtonRight.frame = CGRectMake(210, 5, 100, 35);
    //[myButton.titleLabel setText:@"ok"];
    [myButtonRight.titleLabel setTextColor:[UIColor whiteColor]];
    myButtonRight.cornerRadius  = 3;
    [myButtonRight setTitle:@"下载壁纸" forState:UIControlStateNormal];
    myButtonRight.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [myButtonRight setButtonColor:[UIColor peterRiverColor]];
    [myButtonRight addTarget:self action:@selector(selectRightAction:) forControlEvents:UIControlEventTouchDown];
    //[myButton setShadowColor:[UIColor grayColor]];
    //[myButton setShadowHeight:3];
    //[self.view addSubview:myButton];
    
    [self.myToolBar addSubview:myButtonRight];
    
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize  target:self action:@selector(selectRightAction:)];
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 130;
    self.myToolBar.items = [NSArray arrayWithObjects:fixedSpace, nil];
}

//the left select
-(void)selectLeftAction:(id)sender {
    
    id object = self.itmes[[self.imgeID intValue]];
    //NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ffwallpaper-wallpaper.stor.sinaapp.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    LOG(@"setTheImageByID---URL:%@",URL);
    //set the img for  favoriate
    imgWallpaper *myFavImg = [[imgWallpaper alloc] init];
    myFavImg.imgName = [object objectForKey:@"hash"];
    myFavImg.imgType = [object objectForKey:@"ext"];
    myFavImg.imgHeight = [object objectForKey:@"height"];
    myFavImg.imgWidth = [object objectForKey:@"width"];
    
    //creat the img table
    [FFDataBase createImgWallpaperTable];
 
    NSMutableArray* myResultArr = [FFDataBase getImgWallpaperFromImgWallpaperTableByName:myFavImg.imgName];
    
    if ([myResultArr count] != 0) {
    
        [FFHelpers waringInfo:@"已经为红心！"];
    } else {
        
        NSMutableArray *myFavImgArr = [[NSMutableArray alloc] initWithCapacity:2];
        [myFavImgArr addObject:myFavImg];
        
        [FFDataBase insertImgWallpaperToImgWallpaperTable:myFavImgArr];
        [FFHelpers waringInfo:@"添加红心"];
    }
}

//the right select
-(void)selectRightAction:(id)sender {

    UIImageWriteToSavedPhotosAlbum([self.imageView image], nil, nil, nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片成功"
                                                    message:@"您已将照片存储于图片库中，可设置壁纸。"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    
}


//Get The Image BY ID
-(void)setTheImageByID {

    id object = self.itmes[[self.imgeID intValue]];
    //NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ffwallpaper-wallpaper.stor.sinaapp.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    
    LOG(@"setTheImageByID---URL:%@",URL);
    
    [self.imageView setImageWithURL:URL];
    
    float height = DEVICE_IS_IPHONE5?568:480;
    if (height == 568) {
        // 4"
        self.imageView.frame = CGRectMake(0, 0, 320, 463);
        
    } else {
        // 3.5"
        self.imageView.frame = CGRectMake(0, 0, 320, 373);

        
    }
    
    [self.view addSubview:self.imageView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
