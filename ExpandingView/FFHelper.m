//
//  FFHelper.m
//  testWeb
//
//  Created by liuchang on 9/22/13.
//  Copyright (c) 2013 liuchang. All rights reserved.
//

#import "FFHelper.h"

@implementation FFHelper

//提示框
#pragma  mark init the waring info
+ (void)waringInfo:(NSString *) msgInfo
{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                  message:msgInfo
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"确定",nil];
    [alert show];
}
@end
