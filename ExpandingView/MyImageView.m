//
//  MyImageView.m
//  ExpandingView
//
//  Created by liu on 13-10-20.
//
//

#import "MyImageView.h"

@implementation MyImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    if (image != nil) {
        [image drawInRect:self.bounds];
    }
    
}

- (void)dealloc
{
    [httpRequest clearDelegatesAndCancel];
//    [httpRequest release];
//    [image release];
//    
//    [super dealloc];
}


-(void)startRequest:(NSString *)_url
{
    if (httpRequest != nil) {
        [httpRequest clearDelegatesAndCancel];
        //[httpRequest release];
    }
    
    httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    [httpRequest setTimeOutSeconds:30];
    
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([request responseStatusCode] == 200) {
        image = [[UIImage alloc] initWithData:[request responseData]];
        [self setNeedsDisplay];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"request failed");
}

@end

