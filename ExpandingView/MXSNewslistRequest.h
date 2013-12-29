//
//  MXSNewslistRequest.h
//  xuexin
//
//  Created by liuchang on 10/24/13.
//  Copyright (c) 2013 mx. All rights reserved.
//

#import "FFRequest.h"
#import "MXSNewsListPareser.h"

@interface MXSNewslistRequest : FFRequest

- (id)initWithNewsList:(NSString *)newsType setLocation:(NSString *)location;
@end
