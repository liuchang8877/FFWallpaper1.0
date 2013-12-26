//
//  FFRequest.h
//  ExpandingView
//
//  Created by liuchang on 8/20/13.
//
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface FFRequest : NSObject <ASIHTTPRequestDelegate>{
    ASIFormDataRequest *_request;
}
@property (nonatomic, assign) id delegate; //代理
@property (nonatomic, assign) SEL didFinishSelector; //请求成功之后调用的函数
@property (nonatomic, assign) SEL didFailedSelector; //请求失败之后调用的函数
@property (nonatomic, retain) NSObject *response; //请求成功返回的数据，已经经过解析
@property (nonatomic, retain) NSError *error; //请求失败返回的错误信息
@property (nonatomic, retain) NSObject *attachment;

- (id)initWithURL:(NSURL *)url;
- (void)start;
- (void)cancel;

@end
