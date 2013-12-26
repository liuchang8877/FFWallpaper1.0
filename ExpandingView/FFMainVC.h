//
//  FFMainVC.h
//  ExpandingView
//
//  Created by liuchang on 8/27/13.
//
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"

@interface FFMainVC : UIViewController<PSCollectionViewDataSource,PSCollectionViewDelegate,UIScrollViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSString *favOrNot;  //it is favoriate file,1 IS ,0 NOT
@end
