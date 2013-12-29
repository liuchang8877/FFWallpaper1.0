//
//  MXSNewslistRequest.m
//  xuexin
//
//  Created by liuchang on 10/24/13.
//  Copyright (c) 2013 mx. All rights reserved.
//

#import "MXSNewslistRequest.h"

@implementation MXSNewslistRequest

- (id)initWithNewsList:(NSString *)newsType setLocation:(NSString *)location
{
    //NSString *currentTime = kCurrentTime;
    NSString *url = [NSString stringWithFormat:@"%@?location=%@",kNewsListUrl,location];
    if(self = [super initWithURL:[NSURL URLWithString:url]]) {
        
//        [_request setPostValue:userName forKey:@"name"];
//        [_request setPostValue:password forKey:@"password"];
        //[_request setPostValue:currentTime forKey:@"time"];
        //[_request setPostValue:[MXSHelper signMethodWithTime:currentTime Key:kSignKey] forKey:@"sign"];
    }
    return self;
}

#pragma mark -
#pragma mark implements ASIHTTPRequest protocol

- (void)requestFinished:(ASIHTTPRequest *)request
{

    DLog(@"%@,%@",request.responseData,request.url);
    MXSNewsListPareser *parser = [[MXSNewsListPareser alloc] init];
    NSObject *result = [parser parse:[request responseData]];
    
    if([result isKindOfClass:[NSError class]]) {
        self.error = (NSError *)result;
        SuppressPerformSelectorLeakWarning(
        [self.delegate performSelector:self.didFailedSelector withObject:self];
                                           );
    } else {
        self.response = result;
        SuppressPerformSelectorLeakWarning(
        [self.delegate performSelector:self.didFinishSelector withObject:self];
                                           );
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DLog(@"%@,%@",request.url,[request error]);
    self.error = [request error];
    SuppressPerformSelectorLeakWarning(
    [self.delegate performSelector:self.didFailedSelector withObject:self];
                                       );
}

@end
