//
//  FFViewController.h
//  testWeb
//
//  Created by liuchang on 9/17/13.
//  Copyright (c) 2013 liuchang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFViewController : UIViewController<UIWebViewDelegate>

@property(strong,nonatomic)NSString*localURL;
@property(strong,nonatomic)NSString*myLoaclUser;
@property(strong,nonatomic)NSString*myLoaclServer;
@end
