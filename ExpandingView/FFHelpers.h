//
//  FFHelpers.h
//  ExpandingView
//
//  Created by liuchang on 8/21/13.
//
//

#import <Foundation/Foundation.h>

@interface FFHelpers : NSObject

//存取键值对
+ (void)setValue:(id)value forKey:(NSString *)key; //将键值对存储到NSUserDefault中
+ (id)valueForKey:(NSString *)key; //从NSUserDefault中得到key对应的value
+ (void)waringInfo:(NSString *) msgInfo;
@end
