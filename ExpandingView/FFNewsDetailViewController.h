//
//  FFNewsDetailViewController.h
//  ExpandingView
//
//  Created by liu on 13-12-29.
//
//

#import <UIKit/UIKit.h>
#import "MXSNewsInfo.h"

@interface FFNewsDetailViewController : UIViewController<UIWebViewDelegate>

@property(strong,nonatomic)MXSNewsInfo *myNewsInfo;
@end
