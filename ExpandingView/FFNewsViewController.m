//
//  FFNewsViewController.m
//  ExpandingView
//
//  Created by liu on 13-9-27.
//
//

#import "FFNewsViewController.h"
#import "FFNewsPlistRequest.h"
#import "FFStatus.h"
#import "FFPlistItem.h"
#import "FFHelper.h"
#import "MyImageView.h"
#import "SVPullToRefresh.h"
#import "UIColor+FlatUI.h"


@interface FFNewsViewController () {


    UITableView *myTableView;
    FFNewsPlistRequest *_request;
    NSMutableArray *myPlistArr;
}

@end

@implementation FFNewsViewController

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
    self.title = @"公告";
    self.view.backgroundColor = [UIColor midnightBlueColor];
    [self loadDataFromSer];
    [self setTheTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataFromSer {

    _request = [[FFNewsPlistRequest alloc] initWithPage:@"1"];
    _request.delegate = self;
    [_request setDidFailedSelector:@selector(requestDidFailed:)];
    [_request setDidFinishSelector:@selector(requestDidFinish:)];
    [_request start];

}

#pragma mark - LSLoginRequest delegate

- (void)requestDidFinish:(FFNewsPlistRequest *)request
{

    if ([request.response isKindOfClass:[FFStatus class]]) {
        FFStatus *status = (FFStatus *)request.response;
        NSLog(@"requestDidFinish---status:%@",status);
        
    } else if ([request.response isKindOfClass:[NSMutableArray class]]) {
        myPlistArr = (NSMutableArray *)request.response;
        [myTableView reloadData];
      
    }
}

- (void)requestDidFailed:(FFNewsPlistRequest *)request
{
    
    NSLog(@"requestDidFailed---ERR");
}

#pragma mark UITableView

//init the table view
- (void)setTheTableView{
    
    int heights = DEVICE_IS_IPHONE5?568:480;
    if (heights == 568) {
        //set the table view
        myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height+44) style:UITableViewStyleGrouped];
    }
    else
    {
        //set the table view
        myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - 40) style:UITableViewStyleGrouped];
    }
    
    //myTableView.backgroundColor = [UIColor grayColor];
    myTableView.backgroundColor = [UIColor midnightBlueColor];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundView = nil;
    //myTableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    //myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //添加背景图
    //UIImage *backgroudImage = [UIImage imageNamed:@"sf_bg_pattern"];
    
    //myTableView.backgroundColor = [UIColor colorWithPatternImage:backgroudImage];
    
    __weak FFNewsViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [myTableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    
    // setup infinite scrolling
    [myTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
    [self.view addSubview:myTableView];
    
}

#pragma mark -
#pragma mark action

- (void)insertRowAtTop {
    //__weak FFNewsViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [myTableView beginUpdates];
        [myPlistArr  insertObject:myPlistArr.lastObject atIndex:0];
        [myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [myTableView endUpdates];
        
        [myTableView.pullToRefreshView stopAnimating];
    });
}


- (void)insertRowAtBottom {
    //__weak FFNewsViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [myTableView beginUpdates];
        [myPlistArr addObject:myPlistArr.lastObject];
        [myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:myPlistArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [myTableView endUpdates];
        
        [myTableView.infiniteScrollingView stopAnimating];
    });
}

#pragma mark -
#pragma mark table delegate

//set the number of section in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//set the height of every row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 100;
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //set the rows number of every section
    if (section == 0)
        return  [myPlistArr count];
    return 0;
}

//init the cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"identifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    cell.textLabel.font = [UIFont boldSystemFontOfSize: 15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize: 13];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    //set the backgroundColor
    //cell.backgroundColor = [UIColor colorWithRed:244.0/255 green:226.0/255 blue:185.0/255 alpha:1];
    [self setTheCell:cell indexPath:indexPath];
    
    //[self loadTheView:cell];
    }
    return cell;
}

- (void)setTheCell:(UITableViewCell*)myCell indexPath:(NSIndexPath *)myIndexPath {
    
    if (myIndexPath.section == 0) {
        
        for (int i = 0; [myPlistArr count]; i++) {
            
            
            if (i == myIndexPath.row) {
            
                FFPlistItem *myPlistItem = [myPlistArr objectAtIndex:i];
                //myCell.textLabel.text = myPlistItem.itemTitle;
                
                //文章标题
                UILabel *myTextTitle = [[UILabel alloc]init];
                
                myTextTitle.frame = CGRectMake(110, 15, 200, 20);
                
                myTextTitle.font = [UIFont boldSystemFontOfSize:10];
                
                myTextTitle.backgroundColor = [UIColor clearColor];
                
                myTextTitle.text =  myPlistItem.itemTitle;
                [myCell addSubview:myTextTitle];
                
                //文章简介
            
                UILabel *myTextDes = [[UILabel alloc]init];
                
                myTextDes.lineBreakMode = UILineBreakModeWordWrap;
                myTextDes.numberOfLines = 0;

                myTextDes.frame = CGRectMake(110, 35, 150, 60);
                
                myTextDes.font = [UIFont systemFontOfSize:8];
                
                myTextDes.backgroundColor = [UIColor clearColor];
                
                myTextDes.text =  [NSString stringWithFormat:@"%@ \n\n %@",myPlistItem.itemDes,myPlistItem.itemDatetime ];
                [myCell addSubview:myTextDes];
                
                
                MyImageView *imageView = [[MyImageView alloc] initWithFrame:CGRectMake(20, 15, 70, 70)];
                [imageView startRequest:myPlistItem.itemIco];
                NSLog(@"ico:%@",myPlistItem.itemIco);
                [myCell addSubview:imageView];
                
                break;
            }
        }
    }
}

#pragma mark-
#pragma mark DID SELECTED
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
