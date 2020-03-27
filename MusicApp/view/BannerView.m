//
//  BannerView.m
//  MusicApp
//
//  Created by wangky on 2020/3/26.
//  Copyright © 2020年 wangky. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView


+(instancetype)initHeaderView{
    BannerView *bannerView = [[BannerView alloc] init];
    [bannerView setScrollView: [[UIScrollView alloc] init]];
    [bannerView.scrollView setPagingEnabled:YES];
    [bannerView.scrollView setShowsHorizontalScrollIndicator:NO];
    [bannerView.scrollView setDelegate:bannerView];
    [bannerView addSubview:bannerView.scrollView];
    [bannerView setPageCtrl:[[UIPageControl alloc] init] ];
    [bannerView addSubview:bannerView.pageCtrl];
    return bannerView;
}


-(void)initHeaderViewData:(NSArray *)data{
    [self setDataArr:data];
    [self performSelectorOnMainThread:@selector(showBanner) withObject:nil waitUntilDone:NO];
    
//    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//        CGFloat width = CGRectGetWidth(self.bounds);
//        CGFloat height = 150;
//        [self.scrollView setFrame:self.bounds];
//        NSInteger count = self.dataArr.count;
//        [self.scrollView setContentSize:CGSizeMake(count * width, height)];
//
//        [self initBanners];
//        [self initTimer];
//    }];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        CGFloat width = CGRectGetWidth(self.bounds);
//        CGFloat height = 150;
//        [self.scrollView setFrame:self.bounds];
//        NSInteger count = self.dataArr.count;
//        [self.scrollView setContentSize:CGSizeMake(count * width, height)];
//
//        [self initBanners];
//        [self initTimer];
//    });
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    CGFloat width = CGRectGetWidth(newSuperview.bounds);
    CGFloat height = 150;
    [self setFrame:CGRectMake(0, 0, width, height)];
}

-(void)showBanner{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = 150;
    [self.scrollView setFrame:self.bounds];
    NSInteger count = self.dataArr.count;
    [self.scrollView setContentSize:CGSizeMake(count * width, height)];
    [self.pageCtrl setFrame:CGRectMake((width - 100)/2, 120, 100, 20)];
    [self.pageCtrl setNumberOfPages:count];
    [self.pageCtrl setCurrentPage:0];
    [self.pageCtrl addTarget:self action:@selector(pageControlValueChange:) forControlEvents:UIControlEventValueChanged];
    [self initBanners];
    [self initTimer];
    
}

-(void)pageControlValueChange:(UIPageControl *)pageControl {
    CGFloat width = CGRectGetWidth(self.frame);
    NSInteger page =  pageControl.currentPage;
    NSLog(@"pageControlValueChange %d",page);
    [self.scrollView setContentOffset:CGPointMake(page * width, 0) animated:YES];
    
}


-(void) initBanners{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    NSInteger count =  self.dataArr.count;
    for (NSInteger i = 0; i< count; i++) {
        NSString *imgUrl = [self.dataArr objectAtIndex:i];
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
        UIImage *image =[UIImage imageWithData:data];
    
        UIImageView *imgView =[ [UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height) ];
        
        [imgView setImage:image];
        [self.scrollView addSubview:imgView];
    }
}


-(void)initTimer{
    [self setTimer: [NSTimer timerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES]  ];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
}

-(void)changeImage{
    self.currentPage ++;
    if(self.currentPage >= self.dataArr.count){
        self.currentPage = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.currentPage * CGRectGetWidth(self.frame), 0) animated:YES];
}


#pragma scrollView delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self initTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = CGRectGetWidth(self.frame);
    CGPoint offset =  [scrollView contentOffset];
    CGFloat page = offset.x / width;
    
    [self.pageCtrl setCurrentPage:page];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
