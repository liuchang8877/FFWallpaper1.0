//
//  FFHelpers.m
//  ExpandingView
//
//  Created by liuchang on 8/21/13.
//
//

#import "FFHelpers.h"

@implementation FFHelpers


+ (void)setValue:(id)value forKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)valueForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

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
