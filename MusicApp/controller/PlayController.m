//
//  PlayController.m
//  MusicApp
//
//  Created by wangkly on 2020/4/4.
//  Copyright © 2020 wangky. All rights reserved.
//

#import "PlayController.h"

@interface PlayController ()
@property(strong,nonatomic) id timeObserver;
@property(nonatomic) NSInteger playState;
@end

@implementation PlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"播放"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    UIButton *play = [UIButton buttonWithType:UIButtonTypeSystem];
    [play setFrame:CGRectMake((width - 100) / 2, 100, 100, 50)];
    [play setTitle:@"播放" forState:UIControlStateNormal];
    
    [play addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self setPlay:play];
    [self.view addSubview:self.play];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)] animated:YES];
    
    UISlider *progr = [[UISlider alloc] init];
    
    [progr setFrame:CGRectMake((width - 200) / 2, 200, 200, 20)];

    [self setProgress:progr];
    
    [self.view addSubview:self.progress];
    
    [self.progress addTarget:self action:@selector(playSliderValueChange:) forControlEvents:(UIControlEventValueChanged)];
    
    UILabel * current =[[UILabel alloc] init];
    [current setFrame:CGRectMake(0, 200, 50, 20)];
    [self setCurrentTime:current];
    [self.currentTime setText:@"00:00"];
    [self.view addSubview:self.currentTime];
    
    UILabel * duration =[[UILabel alloc] init];
    [duration setFrame:CGRectMake(((width -200) / 2 + 200) , 200, 50, 20)];
    [self setDurationTime:duration];
    [self.durationTime setText:@"00:00"];
    [self.view addSubview:self.durationTime];
    [self initPlayer];
    // Do any additional setup after loading the view.
}

-(void)back:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)initPlayer{
    NSURL *url = [NSURL URLWithString:_songUrl ];
    AVPlayerItem *songItem = [[AVPlayerItem alloc] initWithURL:url];
    self.player  = [[AVPlayer alloc] initWithPlayerItem:songItem];
    
    //通过KVO监听播放器的状态
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
}

-(void) play:(id)sender{
    NSLog(@"self.playState == %ld",(long)self.playState);
    if(!self.playState){
        [self.player play];
        [self setPlayState:1];
        [self.play setTitle:@"暂停" forState:UIControlStateNormal];
    }else if (self.playState){
        [self.player pause];
        [self setPlayState:0];
        [self.play setTitle:@"播放" forState:UIControlStateNormal];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"status"]){
        
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                NSLog(@"未知状态");
                
                break;
                case AVPlayerStatusReadyToPlay:
                {
                NSLog(@"准备播放");
                __weak typeof(self) weakSelf = self;
                //                self.player.currentItem.duration.value;
                float duration = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
                    self.durationTime.text = [self timeFormatted: duration];
                self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
                    float current = CMTimeGetSeconds(time);
                    float total = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
                    if(current){
                        float progress = current / total;
                        weakSelf.progress.value = progress;
                        weakSelf.currentTime.text = [weakSelf timeFormatted:current];
                    }
                }];
                    }
                break;
                
                case AVPlayerStatusFailed:
                NSLog(@"加载失败");
                break;
            default:
                break;
        }
        
    }
}


-(void)playFinished:(id)sender{
    NSLog(@"play finished");
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    
    if (self.timeObserver) {
        [self.player removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
    }
}

/**
 *拖动进度条
 **/
-(void)playSliderValueChange:(UISlider *)sender{
    
    float time  = sender.value * CMTimeGetSeconds(self.player.currentItem.duration);
    
    [self.player seekToTime: CMTimeMake(time, 1)];
    
}

//转换成时分秒
- (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
