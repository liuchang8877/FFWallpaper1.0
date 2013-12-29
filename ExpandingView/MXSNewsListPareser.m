//
//  MXSNewsListPareser.m
//  xuexin
//
//  Created by liuchang on 10/24/13.
//  Copyright (c) 2013 mx. All rights reserved.
//

#import "MXSNewsListPareser.h"
#import "NSStringAdditions.h"

@implementation MXSNewsListPareser

- (NSObject *)parse:(NSData *)data
{
    DLog(@"DATA:%@",data);
    if (data) {
        NSDictionary *resultDictionary = [data objectFromJSONData];
        if (resultDictionary) {
            NSDictionary *errorJson = [resultDictionary objectForKey:@"error"];
            if (errorJson) {
                return [self parseWithError:errorJson];
            } else {
                NSMutableArray *newsListArr = [resultDictionary objectForKey:@"article"];
                
                if ([newsListArr count] > 0) {
                    DLog(@"%@",[newsListArr  objectAtIndex:0]);
                    return  [self parserWithNewsList:newsListArr];
                } else {
                    return @"";
                }
            }
        }
    }
    return nil;
}

- (FFStatus *)parseWithError:(NSDictionary *)dictionary
{
    FFStatus *status = [[FFStatus alloc] init];
    status.code = [dictionary objectForKey:@"error"];
    status.message = [dictionary objectForKey:@"message"];
    return status;
}


- (NSMutableArray *)parserWithNewsList:(NSMutableArray *)myArr
{
    NSMutableArray *myNewsListArr = [[NSMutableArray alloc]initWithCapacity:5];
    for (int i = 0; i < [myArr count]; i++) {
        MXSNewsInfo *newsInfo = [[MXSNewsInfo alloc] init];
        NSDictionary *currentDic = [myArr objectAtIndex:i];
        newsInfo.newsID     = [self getTheNewsListItemFromDic:currentDic Key:@"newsID"];
        newsInfo.title      = [self getTheNewsListItemFromDic:currentDic Key:@"title"];
        newsInfo.url        = [self getTheNewsListItemFromDic:currentDic Key:@"url"];
        newsInfo.localurl   = [self getTheNewsListItemFromDic:currentDic Key:@"localurl"];
        NSString *myPubTime = [self getTheNewsListItemFromDic:currentDic Key:@"pubtime"];
        //处理日期
        NSRange range = NSMakeRange (17, 5);
        if ([myPubTime length] > 26) {
            newsInfo.pubtime  = [myPubTime substringWithRange:range];
        } else {
            newsInfo.pubtime  = @"";
        }
        newsInfo.detail     = [self getTheNewsListItemFromDic:currentDic Key:@"detail"];
        newsInfo.note       = [self getTheNewsListItemFromDic:currentDic Key:@"note"];
        newsInfo.img        = [self getTheNewsListItemFromDic:currentDic Key:@"img"];
        newsInfo.updateID   = [self getTheNewsListItemFromDic:currentDic Key:@"updateID"];
        [myNewsListArr addObject:newsInfo];
    }
    
    return  myNewsListArr;
}

- (NSString *)getTheNewsListItemFromDic:(NSDictionary *)myDic Key:(NSString *)myKey {
    
    NSString *theValue;
    NSString *currentInfo = [myDic objectForKey:myKey];
    
    if (currentInfo && ![currentInfo isEmptyOrWhitespace]) {
        theValue  = currentInfo;
    } else {
        theValue  = nil;
    }
    
    return theValue;
}
@end
