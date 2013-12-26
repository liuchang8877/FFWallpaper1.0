//
//  FFNewsPlistPareser.m
//  ExpandingView
//
//  Created by liu on 13-10-20.
//
//

#import "FFNewsPlistPareser.h"
#import "NSStringAdditions.h"

@implementation FFNewsPlistPareser


- (NSObject *)parse:(NSData *)data
{
    if (data) {
        NSDictionary *resultDictionary = [data mutableObjectFromJSONData];
    
        if (resultDictionary) {
            NSDictionary *errorJson = [resultDictionary objectForKey:@"error"];
            if (errorJson) {
                return [self parseWithError:errorJson];
            } else {
                //NSDictionary *userDictionary = [resultDictionary objectForKey:@"article"];
                //NSDictionary *userDictionary = [resultDictionary objectForKey:@"article"];
                NSMutableArray *plistArr = [resultDictionary objectForKey:@"article"];
                return  [self parserWithUser:plistArr];
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

- (NSMutableArray *)parserWithUser:(NSMutableArray *)arr
{

    NSMutableArray *myResultArr = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (int i = 0; i < [arr count]; i++) {
        
        NSDictionary *dictionary = [arr objectAtIndex:i];
    
        FFPlistItem *myPlist = [[FFPlistItem alloc]init];
        
        myPlist.itemID = [self getInfoFromDic:@"id" dic:dictionary];
        
        myPlist.itemTitle       = [self getInfoFromDic:@"title" dic:dictionary];
        myPlist.itemIsvideo     = [self getInfoFromDic:@"isvideo" dic:dictionary];
        myPlist.itemDes         = [self getInfoFromDic:@"des" dic:dictionary];
        myPlist.itemDatetime    = [self getInfoFromDic:@"datetime" dic:dictionary];
        myPlist.itemUrl         = [self getInfoFromDic:@"url" dic:dictionary];
        myPlist.itemIco         = [self getInfoFromDic:@"ico" dic:dictionary];

        [myResultArr addObject:myPlist];
    }
    
    return  myResultArr;
}

- (NSString *)getInfoFromDic:(NSString*)myKey dic:(NSDictionary *)myDic{

    NSString *currentInfo = [myDic objectForKey:myKey];
    if (currentInfo && ![currentInfo isEmptyOrWhitespace]) {
        return currentInfo;
    } else {
        return nil;
    }
}

@end
