//
//  FFFAQViewController.m
//  ExpandingView
//
//  Created by liuchang on 10/8/13.
//
//

#import "FFFAQViewController.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@interface FFFAQViewController (){

    UITableView *myTableView;
    
}

@end

@implementation FFFAQViewController

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
    
    [self setTheTableView];
    //设置返回
    [self setTheNavigationItem];
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
        myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStyleGrouped];
    }
    
    myTableView.backgroundColor = [UIColor grayColor];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundView = nil;
    //myTableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    //myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //添加背景图
    //UIImage *backgroudImage = [UIImage imageNamed:@"sf_bg_pattern"];
    
    //myTableView.backgroundColor = [UIColor colorWithPatternImage:backgroudImage];
    
    [self.view addSubview:myTableView];
    
}

#pragma mark -
#pragma mark table delegate

//set the number of section in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//set the heigh of  between the section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0;
}

//set the height of every row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        } else if (indexPath.row == 1) {
            return 100;
        }
    }
    return 50;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //set the rows number of every section
    if (section == 0)
        return  2;
    else if (section == 1)
        return 4;
    return 0;
}

//init the cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"identifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //if (cell == nil) {
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
    //}
    return cell;
}

- (void)setTheCell:(UITableViewCell*)myCell indexPath:(NSIndexPath *)myIndexPath {
    
    if (myIndexPath.section == 0) {
        
        if (myIndexPath.row == 0) {
            
            myCell.textLabel.text = @"保存壁纸为空";
        } else if (myIndexPath.row == 1) {
            
            UITextView *myTextView = [[UITextView alloc]init];
            
            myTextView.frame = CGRectMake(20, 10, 300, 80);
            myTextView.backgroundColor = [UIColor clearColor];
            myTextView.text = @"1.因为要手动添加书签才会保存\n 2.书签在详情的左下角\n";
            [myCell addSubview:myTextView];
            
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
