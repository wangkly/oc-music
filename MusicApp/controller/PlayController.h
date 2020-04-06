//
//  PlayController.h
//  MusicApp
//
//  Created by wangkly on 2020/4/4.
//  Copyright © 2020 wangky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface PlayController : UIViewController
@property(strong ,nonatomic) NSString *songUrl;
@property(strong,nonatomic) UIButton *play;
@property(nonatomic,strong) AVPlayer *player;
@property(nonatomic,strong) UILabel *currentTime;
@property(nonatomic,strong) UILabel *durationTime;
@property(nonatomic,strong) UISlider *progress;
@end

NS_ASSUME_NONNULL_END
