//
//  FFUserPareser.h
//  ExpandingView
//
//  Created by liuchang on 8/20/13.
//
//

#import <Foundation/Foundation.h>
#import "FFUser.h"
#import "FFStatus.h"
#import "JSONKit.h"

@interface FFUserPareser : NSObject

- (NSObject *)parse:(NSData *)data;
- (FFStatus *)parseWithError:(NSDictionary *)dictionary;
- (FFUser *)parserWithUser:(NSDictionary *)dictionary;

@end
