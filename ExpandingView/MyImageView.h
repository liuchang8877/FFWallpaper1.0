//
//  MyImageView.h
//  ExpandingView
//
//  Created by liu on 13-10-20.
//
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"

@interface MyImageView : UIView <ASIHTTPRequestDelegate>
{
    ASIHTTPRequest *httpRequest;
    UIImage *image;
}

- (void)startRequest:(NSString *)_url;
@end

