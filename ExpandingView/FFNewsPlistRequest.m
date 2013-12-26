//
//  FFNewsPlistRequest.m
//  ExpandingView
//
//  Created by liu on 13-10-20.
//
//

#import "FFNewsPlistRequest.h"
#import "FFNewsPlistPareser.h"

@implementation FFNewsPlistRequest

- (id)initWithPage:(NSString *)page
{
    //NSString *currentTime = kCurrentTime;
    if(self = [super initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/index.json",kNewsUrl,page]]]) {

//        [_request setPostValue:userName forKey:@"name"];
//        [_request setPostValue:password forKey:@"password"];
        
        NSLog(@"----url:%@",_request.url);
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
    
    FFNewsPlistPareser *parser = [[FFNewsPlistPareser alloc] init];
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
