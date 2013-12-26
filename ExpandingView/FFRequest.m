//
//  FFRequest.m
//  ExpandingView
//
//  Created by liuchang on 8/20/13.
//
//

#import "FFRequest.h"

@implementation FFRequest

- (id)initWithURL:(NSURL *)url {
    if(self = [super init]) {
        _request = [[ASIFormDataRequest alloc] initWithURL:url];
        _request.numberOfTimesToRetryOnTimeout = 2;
        _request.timeOutSeconds = 60;
        _request.allowCompressedResponse = YES; //获取数据压缩
        //        _request.shouldCompressRequestBody = YES;  //发送数据压缩
        _request.delegate = self;
    }
    
    return self;
}

- (void)start {
    [_request start];
}

- (void)cancel {
    [_request cancel];
}

@end
