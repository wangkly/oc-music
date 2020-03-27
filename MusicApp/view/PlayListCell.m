//
//  PlayListCell.m
//  MusicApp
//
//  Created by wangky on 2019/12/2.
//  Copyright © 2019年 wangky. All rights reserved.
//

#import "PlayListCell.h"

@implementation PlayListCell

-(instancetype)init{
    NSLog(@"====init====");
    PlayListCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PlayListCell" owner:self options:nil] lastObject];
    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"====initWithFrame====");
    self = [super initWithFrame: frame];
    if(self){
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        
        self.cover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height-20)];
        
        self.cover.layer.masksToBounds = YES;
        self.cover.layer.cornerRadius = 3;
        self.cover.image = [UIImage imageNamed:@"cat"];
        
        [self.contentView addSubview:self.cover];
        
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, height-20, width, 20)];
        [self.title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        
        self.title.text = @"夏天到来，想要沁心凉一下吗这个夏天都不会热哦";
        
        [self addSubview:self.title];
    }
    
    return self;
    
}

-(void)setImage:(NSString *)image andTitle:(NSString *)title{
    
    self.title.text = title;
}

- (void)awakeFromNib {
    NSLog(@"====awakeFromNib====");
    [super awakeFromNib];
    // Initialization code
}


-(void)loadImageData{
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"dispatch_queue=====>%@",[NSThread currentThread]);
        
        
    });
    
}

@end
