//
//  FFNewsPlistPareser.h
//  ExpandingView
//
//  Created by liu on 13-10-20.
//
//

#import <Foundation/Foundation.h>
#import "FFStatus.h"
#import "FFPlistItem.h"
#import "JSONKit.h"

@interface FFNewsPlistPareser : NSObject

- (NSObject *)parse:(NSData *)data;
- (FFStatus *)parseWithError:(NSDictionary *)dictionary;
- (NSMutableArray *)parserWithUser:(NSMutableArray *)arr;
@end
