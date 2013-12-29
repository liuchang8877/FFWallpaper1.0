//
//  MXSNewsListPareser.h
//  xuexin
//
//  Created by liuchang on 10/24/13.
//  Copyright (c) 2013 mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFStatus.h"
#import "MXSNewsInfo.h"
#import "JSONKit.h"

@interface MXSNewsListPareser : NSObject

- (NSObject *)parse:(NSData *)data;
- (FFStatus *)parseWithError:(NSDictionary *)dictionary;
- (NSMutableArray *)parserWithNewsList:(NSMutableArray *)myArr;
@end
