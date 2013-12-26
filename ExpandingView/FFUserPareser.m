//
//  FFUserPareser.m
//  ExpandingView
//
//  Created by liuchang on 8/20/13.
//
//

#import "FFUserPareser.h"
#import "NSStringAdditions.h"
@implementation FFUserPareser

- (NSObject *)parse:(NSData *)data
{
    NSLog(@"-----DATA:%@",data);
    if (data) {
        NSDictionary *resultDictionary = [data objectFromJSONData];
        if (resultDictionary) {
            NSDictionary *errorJson = [resultDictionary objectForKey:@"error"];
            if (errorJson) {
                return [self parseWithError:errorJson];
            } else {
                NSDictionary *userDictionary = [resultDictionary objectForKey:@"profile"];
                return  [self parserWithUser:userDictionary];
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

- (FFUser *)parserWithUser:(NSDictionary *)dictionary
{
    FFUser *user = [[FFUser alloc] init];
    NSString *currentInfo = [dictionary objectForKey:@"user_id"];
    if (currentInfo && ![currentInfo isEmptyOrWhitespace]) {
        user.userId = currentInfo;
    } else {
        user.userId = nil;
    }
    
    currentInfo = [dictionary objectForKey:@"user_name"];
    if (currentInfo && ![currentInfo isEmptyOrWhitespace]) {
        user.userName = currentInfo;
    } else {
        currentInfo = [dictionary objectForKey:@"name"];
        if (currentInfo && ![currentInfo isEmptyOrWhitespace]) {
            user.userName = currentInfo;
        } else {
            user.userName = nil;
        }
    }
    
    return  user;
}
@end
