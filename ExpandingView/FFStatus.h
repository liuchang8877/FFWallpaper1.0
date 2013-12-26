//
//  FFStatus.h
//  ExpandingView
//
//  Created by liuchang on 8/20/13.
//
//

#import <Foundation/Foundation.h>

@interface FFStatus : NSObject

@property (nonatomic, assign) NSInteger type; //正确或者错误0：错误 1：正确
@property (nonatomic, copy) NSString *code; //状态码
@property (nonatomic, copy) NSString *message; //状态提示信息
@end
