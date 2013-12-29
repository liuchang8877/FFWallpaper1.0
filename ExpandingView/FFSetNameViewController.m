//
//  FFSetNameViewController.m
//  testWeb
//
//  Created by liuchang on 9/22/13.
//  Copyright (c) 2013 liuchang. All rights reserved.
//

#import "FFSetNameViewController.h"
#import "FFHelper.h"
#import "leveyTabBarController.h"
#import "FFViewController.h"
#import "LeveyTabBarController.h"
#import "FUITextField.h"
#import "UIColor+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@interface FFSetNameViewController () {

    FUITextField *myServerNameTF;
    //存储服务器名称
    NSString    *myServerStr;
    FUITextField *myUserNameTF;
    UIPickerView *serverNamePV;
    //用于picker的功能栏
    UIToolbar *toolBar;
    //用于存储服务器名称数组
    NSMutableArray *myServerNameArr;
    //用于存放服务器名称row
    NSString  *serverNameRow;
}

@end

@implementation FFSetNameViewController

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
    self.title = @"战斗力查询";
	// Do any additional setup after loading the view.
    //设置视图背景
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"viewbg.png"]]];
    //设置名称输入
    [self setTheUserName];
    //设置服务器名称输入
    [self setTheServerName];
    //设置服务器名选择PICKER数组
    [self setTheServerNamePVData];
    //设置手势
    [self setTheGesture];
    //设置nav上查询按钮
    //[self setTheRightSelectButton];
    [self setTheNavigationItem];
    //设置logo
    [self setThelogoOfQuery];
    
}

- (void)setTheNavigationItem {
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    UIBarButtonItem *myBarItemRight = [[UIBarButtonItem alloc] initWithTitle:@"查询"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(setToStartSelect:)];
    myBarItemRight.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = myBarItemRight;
    
}

//设置logo
- (void)setThelogoOfQuery {

    UIImageView *myLogoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"querylogo.png"]];
    
    myLogoView.frame = CGRectMake(90, 210, 130, 130);
    
    [self.view addSubview: myLogoView];
}

//设置查询
- (void)setToStartSelect:(id)sender {

    FFViewController *myWebView = [[FFViewController alloc] init];
    
    if ([myUserNameTF.text length] >0 && [myServerStr length] >0) {
    
        myWebView.myLoaclUser = myUserNameTF.text;
        myWebView.myLoaclServer = myServerStr;
    } else {
        
        [FFHelper waringInfo:@"名称或服务器不能为空！"];
    }
    //tabbar 隐藏
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    [self.navigationController pushViewController:myWebView animated:YES];
}
//设置nav右上查询
- (void)setTheRightSelectButton {
    
    //UIButtonTypeCustom
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(0, 7, 58, 30);
    
    //设置背景
    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"sf_nav_do.png"] forState:UIControlStateNormal];
    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"sf_nav_do_down.png"] forState:UIControlStateHighlighted];
    
    [rightBtn setTitleColor:[UIColor colorWithRed:145.0/255.0 green:199.0/255.0 blue:252.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [rightBtn setTitle:@"查询" forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(setToStartSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)handleSingleTap:(id)sender
{
    //响应单击view事件
    [myServerNameTF resignFirstResponder];
    [myUserNameTF resignFirstResponder];
    [self delTheServerName];

}

//避免添加在view上的手势使button的UIControlEventTouchUpInside不响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([[NSString stringWithFormat:@"%@",[touch.view class]] isEqualToString:@"UIToolbarTextButton"]) {
        return NO;
    } else {
    
        return YES;
    }
    //return ([[touch.view class] isSubclassOfClass:UIToolbarTextButton]) ? NO : YES;
}

//添加手势
- (void)setTheGesture {

    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
}

#pragma mark -
#pragma mark set username and servername
- (void)setTheUserName {

//    myUserNameTF = [[UITextField alloc]init];
//    myUserNameTF.frame = CGRectMake(20, 80, 280, 35);
//    myUserNameTF.borderStyle = UITextBorderStyleLine;
//    myUserNameTF.backgroundColor = [UIColor whiteColor];
//    myUserNameTF.delegate = self;
//    myUserNameTF.placeholder = @"英雄名称";
//    
//    [self.view addSubview:myUserNameTF];
//    
//    
    myUserNameTF = [[FUITextField alloc]init];
    myUserNameTF.frame = CGRectMake(20, 80, 280, 35);
    myUserNameTF.BorderColor = [UIColor peterRiverColor];
    myUserNameTF.textFieldColor = [UIColor peterRiverColor];
    //myUserNameTF.tintColor = [UIColor whiteColor];
    myUserNameTF.textColor = [UIColor whiteColor];
    myUserNameTF.delegate = self;
    [myUserNameTF setCornerRadius:3];
    myUserNameTF.placeholder = @"英雄名称";
    myUserNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:myUserNameTF];
}

- (void)setTheServerName {
    
//    myServerNameTF = [[UITextField alloc]init];
//    myServerNameTF.frame = CGRectMake(20, 160, 280, 35);
//    myServerNameTF.borderStyle = UITextBorderStyleLine;
//    myServerNameTF.backgroundColor = [UIColor whiteColor];
//    myServerNameTF.delegate = self;
//    myServerNameTF.placeholder = @"服务器名称";
//    
//    [self.view addSubview:myServerNameTF];
//    
    
    myServerNameTF = [[FUITextField alloc]init];
    myServerNameTF.frame = CGRectMake(20, 160, 280, 35);
    myServerNameTF.BorderColor = [UIColor peterRiverColor];
    myServerNameTF.textFieldColor = [UIColor peterRiverColor];
    //myServerNameTF.tintColor = [UIColor whiteColor];
    myServerNameTF.textColor = [UIColor whiteColor];
    myServerNameTF.delegate = self;
    [myServerNameTF setCornerRadius:3];
    myServerNameTF.placeholder = @"服务器名称";
    [self.view addSubview:myServerNameTF];
}

- (void)setTheServerNamePVData {

    myServerNameArr = [[NSMutableArray alloc]initWithCapacity:6];
    [myServerNameArr addObject:@"[网通一]比尔吉沃特"];
    [myServerNameArr addObject:@"[网通二]德玛西亚"];
    [myServerNameArr addObject:@"[网通三]费雷尔卓德"];
    [myServerNameArr addObject:@"[网通四]无畏先锋"];
    [myServerNameArr addObject:@"[网通五]恕瑞玛"];
    [myServerNameArr addObject:@"[网通六]扭曲丛林"];
    [myServerNameArr addObject:@"[电信一]艾欧尼亚"];
    [myServerNameArr addObject:@"[电信二]祖安"];
    [myServerNameArr addObject:@"[电信三]诺克萨斯"];
    [myServerNameArr addObject:@"[电信四]班德尔城"];
    [myServerNameArr addObject:@"[电信五]皮尔特沃夫"];
    [myServerNameArr addObject:@"[电信六]战争学院"];
    [myServerNameArr addObject:@"[电信七]巨神峰"];
    [myServerNameArr addObject:@"[电信八]雷瑟守备"];
    [myServerNameArr addObject:@"[电信九]裁决之地"];
    [myServerNameArr addObject:@"[电信十]黑色玫瑰"];
    [myServerNameArr addObject:@"[电信十一]暗影岛"];
    [myServerNameArr addObject:@"[电信十二]钢铁烈阳"];
    [myServerNameArr addObject:@"[电信十三]均衡教派"];
    [myServerNameArr addObject:@"[电信十四]水晶之痕"];
    [myServerNameArr addObject:@"[电信十五]影流"];
    [myServerNameArr addObject:@"[电信十六]守望之海"];
    [myServerNameArr addObject:@"[电信十七]征服之海"];
    [myServerNameArr addObject:@"[电信十八]卡拉曼达"];
    [myServerNameArr addObject:@"[电信十九]皮城警备"];
    [myServerNameArr addObject:@"[教育一]教育网专区"];
}

- (void)selectServerName {
    
    
    NSString *myServerNameStr = [myServerNameArr objectAtIndex:[serverNameRow intValue]];
    NSArray *component = [myServerNameStr componentsSeparatedByString:@"]"];
    
    //存储服务器名称
    myServerStr = [[component objectAtIndex:0] substringFromIndex:1];
    //[FFHelper waringInfo:[component objectAtIndex:1]];
    myServerNameTF.text = myServerNameStr;
    
    //动态隐藏
    float y = DEVICE_IS_IPHONE5?288:200;
    [UIView animateWithDuration:0.5 animations:^{
        serverNamePV.frame = CGRectMake(0, y + 316, 320, 216);
        toolBar.frame = CGRectMake(0, y+316, 320, 44);
    }];

}
- (void)delTheServerName {

    //动态隐藏
    float y = DEVICE_IS_IPHONE5?288:200;
    [UIView animateWithDuration:0.5 animations:^{
        serverNamePV.frame = CGRectMake(0, y + 316, 320, 216);
        toolBar.frame = CGRectMake(0, y+316, 320, 44);
    }];
}
//设置服务器名称选择picker
- (void)setTheServerNameAction{
    
    //隐藏PICKER 和确认面板
    serverNamePV.hidden = YES;
    toolBar.hidden = YES;
    
    float y = DEVICE_IS_IPHONE5?288:200;
    serverNamePV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, y+316, 320, 216)];
    serverNamePV.showsSelectionIndicator = YES;
    serverNamePV.dataSource = self;
    serverNamePV.delegate = self;
    serverNamePV.backgroundColor = RGBA(203, 203, 203, 0.6);
    
    [self.view addSubview:serverNamePV];
    
    //创建工具栏
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
	UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectServerName)];
	UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(delTheServerName)];
    [items addObject:cancelBtn];
    [items addObject:flexibleSpaceItem];
    [items addObject:confirmBtn];
    
    
    self->toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, y-44+316, 320, 44)];
    self->toolBar.hidden = NO;
    self->toolBar.barStyle = UIBarStyleBlackTranslucent;
    self->toolBar.items = items;
    
    [self.view addSubview:self->toolBar];
    //点击动态效果
    [UIView animateWithDuration:0.5 animations:^{
        serverNamePV.frame = CGRectMake(0, y, 320, 216);
        self->toolBar.frame = CGRectMake(0, y-44, 320, 44);
    }];
}

#pragma mark
#pragma mark- UITEXTFIELD DELEGATE
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if(textField == myServerNameTF) {
        [myUserNameTF resignFirstResponder];
        [textField resignFirstResponder];
        //[FFHelper waringInfo:@"find you"];
        [self setTheServerNameAction];
        return NO;
    } else {
        
        [self delTheServerName];
    }
    return YES;
    
}

#pragma mark -
#pragma mark Picker Data Source Methods
//return the list of picker to display
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//return the row of picker to display
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    if (pickerView == serverNamePV) {
        
        return [myServerNameArr count];
    }
    return 0;
}

//add the data to the picker
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == serverNamePV) {
        
        return [myServerNameArr objectAtIndex:row];
    }
    return nil;
}

//获取PICKER选择项
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == serverNamePV) {
        
        serverNameRow = [NSString stringWithFormat:@"%d",row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
