//
//  FFModle.h
//  ExpandingView
//
//  Created by liuchang on 8/27/13.
//
//

#import <Foundation/Foundation.h>

@interface FFModle : NSObject 

@end

@interface userInfo : NSObject

@property (nonatomic, strong)NSString     *userID;
@property (nonatomic, strong)NSString     *userName;
@property (nonatomic, strong)NSString     *userInfo;
@end

@interface imgWallpaper : NSObject

@property (nonatomic, strong)NSString     *imgID;
@property (nonatomic, strong)NSString     *imgName;
@property (nonatomic, strong)NSString     *imgType;
@property (nonatomic, strong)NSString     *imgHeight;
@property (nonatomic, strong)NSString     *imgWidth;
@property (nonatomic, strong)NSString     *imgInfo;
@property (nonatomic, strong)NSData       *imgData;     //save the img
@end