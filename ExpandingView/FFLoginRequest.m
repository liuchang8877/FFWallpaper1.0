//
//  FFLoginRequest.m
//  ExpandingView
//
//  Created by liuchang on 8/20/13.
//
//

#import "FFLoginRequest.h"
#import "FFUserPareser.h"

@implementation FFLoginRequest

- (id)initWithUserName:(NSString *)userName password:(NSString *)password
{
    //NSString *currentTime = kCurrentTime;
    if(self = [super initWithURL:[NSURL URLWithString:kLoginUrl]]) {

        [_request setPostValue:userName forKey:@"name"];
        [_request setPostValue:password forKey:@"password"];
        //[_request setPostValue:currentTime forKey:@"time"];
        //[_request setPostValue:[MXSHelper signMethodWithTime:currentTime Key:kSignKey] forKey:@"sign"];
    }
    return self;
}

#pragma mark -
#pragma mark implements ASIHTTPRequest protocol

- (void)requestFinished:(ASIHTTPRequest *)request
{
    DEBUG_RECEIVE_DATA(request.responseData);
    DEBUG_REQUEST_INFO(request.url,nil);
    
    FFUserPareser *parser = [[FFUserPareser alloc] init];
    NSObject *result = [parser parse:[request responseData]];

    if([result isKindOfClass:[NSError class]]) {
        self.error = (NSError *)result;
        [self.delegate performSelector:self.didFailedSelector withObject:self];
    } else {
        self.response = result;
        [self.delegate performSelector:self.didFinishSelector withObject:self];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DEBUG_REQUEST_INFO(request.url,[[request error] userInfo]);
    self.error = [request error];
    [self.delegate performSelector:self.didFailedSelector withObject:self];
}


@end
