//
//  FFDataBase.m
//  ExpandingView
//
//  Created by liuchang on 8/26/13.
//
//

#import "FFDataBase.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FFModle.h"

@implementation FFDataBase

+(NSString *)dataFilePath {
    NSString *filePaths = nil;
    if(filePaths==nil){
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePathes = dataBaseFileName;
		filePaths=[documentsDirectory stringByAppendingPathComponent:filePathes];
	}
    NSLog(@"filePaths:%@",filePaths);
    return filePaths;
}

//create the database obj
+(FMDatabase *)getDb{
    FMDatabase *db = nil;
    if(db==nil)
        db = [FMDatabase databaseWithPath:[FFDataBase dataFilePath]];
	return db;
}

//create the table for use
+ (void)createUserInfoTable
{
    FMDatabase *db = [FFDataBase getDb];
	[db open];
	[db executeUpdate:@"create table userInfoTable(id integer primary key AUTOINCREMENT, username text, userinfo text)"] ;
    [db close];
}

//insert info to the userInfoTable
+ (void)insertUserToUserInfoTable:(NSMutableArray*)array
{
    FMDatabase *db = [FFDataBase getDb];
	[db open];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[FFDataBase dataFilePath]];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         for (userInfo *user in array)
         {
             [db executeUpdate:@"insert into userInfoTable (username, userinfo) values (?,?)",user.userName, user.userInfo];
         }
     }];
    [queue close];
	[db close];
}

//get the all the userInfo from table
+ (NSMutableArray*)getUserInfoFromUserInfoTable
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:2];
    FMDatabase *db = [FFDataBase getDb];
	[db open];
	FMResultSet *contactRs = [db executeQuery:@"select * from userInfoTable"];
	while ([contactRs next] ) {
        userInfo *user = [[userInfo alloc] init];
        user.userID = [contactRs stringForColumn:@"id"];
		user.userName = [contactRs stringForColumn:@"username"];
        user.userInfo = [contactRs stringForColumn:@"userinfo"];

        [mutableArray addObject:user];
	}
	[contactRs close];
	[db close];
    return mutableArray;
}

//delete the userInfo
+ (BOOL)deleteUserInfoFromUserInfoTable
{
    FMDatabase *db = [FFDataBase getDb];
    
	if (![db open])
    {
		NSLog(@"Could not open DB.");
		return NO;
	}

	BOOL success = [db executeUpdate:@"delete from userInfoTable"];
	[db close];
	return success;
}

//create the table for imgWallpaper
+ (void)createImgWallpaperTable
{
    FMDatabase *db = [FFDataBase getDb];
	[db open];
	[db executeUpdate:@"create table imgWallpaperTable(id integer primary key AUTOINCREMENT, name text, type text, height text, width text, info text, imgdata blob)"] ;
    [db close];
}

//insert info to the imgWallpaperTable
+ (void)insertImgWallpaperToImgWallpaperTable:(NSMutableArray*)array
{
    FMDatabase *db = [FFDataBase getDb];
	[db open];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[FFDataBase dataFilePath]];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback)
     {
         for (imgWallpaper *myImgWallpaper in array)
         {
             [db executeUpdate:@"insert into imgWallpaperTable (name, type, height, width,  info, imgdata ) values (?,?,?,?,?,?)",myImgWallpaper.imgName, myImgWallpaper.imgType, myImgWallpaper.imgHeight, myImgWallpaper.imgWidth,  myImgWallpaper.imgInfo, myImgWallpaper.imgData];
         }
     }];
    [queue close];
	[db close];
}

//get the all the imgWallpaper from table by name
+ (NSMutableArray*)getImgWallpaperFromImgWallpaperTableByName:(NSString*)nameStr
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:2];
    FMDatabase *db = [FFDataBase getDb];
	[db open];
	FMResultSet *contactRs = [db executeQuery:@"select * from imgWallpaperTable where name = ?",nameStr];
	while ([contactRs next] ) {
        imgWallpaper *imgWP = [[imgWallpaper alloc] init];
        imgWP.imgID = [contactRs stringForColumn:@"id"];
		imgWP.imgName = [contactRs stringForColumn:@"name"];
        imgWP.imgType = [contactRs stringForColumn:@"type"];
        imgWP.imgHeight = [contactRs stringForColumn:@"height"];
        imgWP.imgWidth = [contactRs stringForColumn:@"width"];
        imgWP.imgInfo = [contactRs stringForColumn:@"info"];
        imgWP.imgData = [contactRs dataForColumn:@"imgdata"];
        
        [mutableArray addObject:imgWP];
	}
	[contactRs close];
	[db close];
    return mutableArray;
}

//get the all the imgWallpaper from table
+ (NSMutableArray*)getImgWallpaperFromImgWallpaperTable
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:2];
    FMDatabase *db = [FFDataBase getDb];
	[db open];
	FMResultSet *contactRs = [db executeQuery:@"select * from imgWallpaperTable"];
	while ([contactRs next] ) {
        imgWallpaper *imgWP = [[imgWallpaper alloc] init];
        imgWP.imgID = [contactRs stringForColumn:@"id"];
		imgWP.imgName = [contactRs stringForColumn:@"name"];
        imgWP.imgType = [contactRs stringForColumn:@"type"];
        imgWP.imgHeight = [contactRs stringForColumn:@"height"];
        imgWP.imgWidth = [contactRs stringForColumn:@"width"];
        imgWP.imgInfo = [contactRs stringForColumn:@"info"];
        imgWP.imgData = [contactRs dataForColumn:@"imgdata"];
        
        [mutableArray addObject:imgWP];
	}
	[contactRs close];
	[db close];
    return mutableArray;
}

//delete the ImgWallpaper
+ (BOOL)deleteImgWallpaperFromImgWallpaperTable
{
    FMDatabase *db = [FFDataBase getDb];
    
	if (![db open])
    {
		NSLog(@"Could not open DB.");
		return NO;
	}
    
	BOOL success = [db executeUpdate:@"delete from imgWallpaperTable"];
	[db close];
	return success;
}
@end
