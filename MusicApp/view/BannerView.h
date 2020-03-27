//
//  BannerView.h
//  MusicApp
//
//  Created by wangky on 2020/3/26.
//  Copyright © 2020年 wangky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView <UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageCtrl;
@property(nonatomic,strong) NSArray * dataArr;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign)NSInteger currentPage;
+(instancetype)initHeaderView;
-(void) initHeaderViewData: (NSArray *) data;
-(void) initBanners;

@end
