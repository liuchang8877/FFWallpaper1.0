//
//  FFDataBase.h
//  ExpandingView
//
//  Created by liuchang on 8/26/13.
//
//

#import <Foundation/Foundation.h>

@interface FFDataBase : NSObject

// userInfoTable
+ (void)createUserInfoTable;                                 // creat
+ (void)insertUserToUserInfoTable:(NSMutableArray*)array;    // insert
+ (NSMutableArray*)getUserInfoFromUserInfoTable;             // select
+ (BOOL)deleteUserInfoFromUserInfoTable;                     // delete

// imgWallpaperTable
+ (void)createImgWallpaperTable;                              
+ (void)insertImgWallpaperToImgWallpaperTable:(NSMutableArray*)array;
+ (NSMutableArray*)getImgWallpaperFromImgWallpaperTable;
+ (NSMutableArray*)getImgWallpaperFromImgWallpaperTableByName:(NSString*)nameStr;
+ (BOOL)deleteImgWallpaperFromImgWallpaperTable;
@end
