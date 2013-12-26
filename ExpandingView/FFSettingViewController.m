//
//  FFSettingViewController.m
//  ExpandingView
//
//  Created by liuchang on 9/25/13.
//
//

#import "FFSettingViewController.h"
#import "FFFeedbackViewController.h"
#import "LeveyTabBarController.h"
#import "FFVersionLogViewController.h"
#import "FFAboutViewController.h"
#import "FFMainVC.h"
#import "FFFAQViewController.h"
#import "UIColor+FlatUI.h"


@interface FFSettingViewController () {

    UITableView *myTableView;
    
}

@end

@implementation FFSettingViewController

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
    self.title = @"设置";
    self.view.backgroundColor = [UIColor midnightBlueColor];
    //设置tableview
    [self setTheTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self.view addSubview:myTableView];
    
}

#pragma mark -
#pragma mark table delegate

//set the number of section in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//set the heigh of  between the section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0;
}

//set the height of every row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 50;
    else if (indexPath.section == 1)
        return 50;
    else
        return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //set the rows number of every section
    if (section == 0)
        return  3;
    else if (section == 1)
        return 2;
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
        
            myCell.textLabel.text = @"版本介绍";
        } else if (myIndexPath.row == 1) {
            
            myCell.textLabel.text = @"意见反馈";
        } else if (myIndexPath.row == 2) {
            
            myCell.textLabel.text = @"关于我们";
        }
        
    } else if (myIndexPath.section == 1) {
        
        if (myIndexPath.row == 0) {
            
            myCell.textLabel.text = @"壁纸书签";
            
        } else if (myIndexPath.row == 1) {
            
            myCell.textLabel.text = @"常见问题";
        }
    }
}

#pragma mark-
#pragma mark DID SELECTED
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    if (indexPath.section == 0) {
    
        if (indexPath.row == 0) {
        
            FFVersionLogViewController *myVersionLogVC = [[FFVersionLogViewController alloc]init];
            
            [self.navigationController pushViewController:myVersionLogVC animated:YES];
            
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            
        } else if(indexPath.row == 1) {
        
            FFFeedbackViewController *myFeedbackVC = [[FFFeedbackViewController alloc]init];
            
            [self.navigationController pushViewController:myFeedbackVC animated:YES];
            
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
        } else if (indexPath.row == 2) {
            
            FFAboutViewController *myAboutVC = [[FFAboutViewController alloc]init];
            
            [self.navigationController pushViewController:myAboutVC animated:YES];
            
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
        
        }
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            FFMainVC *myMainVC = [[FFMainVC alloc]init];
            myMainVC.favOrNot = @"1";
            [self.navigationController pushViewController:myMainVC animated:YES];
            
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
        } else if (indexPath.row == 1) {
            
            FFFAQViewController *myFAQVC = [[FFFAQViewController alloc]init];

            [self.navigationController pushViewController:myFAQVC animated:YES];
            
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
        
        }
        
    }
}
@end
