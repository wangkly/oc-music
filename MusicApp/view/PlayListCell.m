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
    NSLog(@"setImage== %@",image);
    NSString *str = [image lastPathComponent];
    NSArray *path =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *fullPath  =[NSString stringWithFormat:@"%@%@", @"/imageCache/",str];
    NSString *localPath = [[path objectAtIndex:0] stringByAppendingPathComponent:fullPath];
    if([[NSFileManager defaultManager] fileExistsAtPath:localPath]){
        
        NSData * data =[NSData dataWithContentsOfFile:localPath];
        self.cover.image =[UIImage imageWithData:data];
        
    }else{
        
        [self loadImageData:image];
    }
    
    

}

- (void)awakeFromNib {
    NSLog(@"====awakeFromNib====");
    [super awakeFromNib];
    // Initialization code
}


-(void)loadImageData:(NSString *)imgUrl{
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    NSString *str = [imgUrl lastPathComponent];
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:imgUrl];
        NSData *data =[NSData dataWithContentsOfURL:url];
        
        NSArray *path =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *fullPath  =[NSString stringWithFormat:@"%@%@", @"/imageCache/",str];
        NSString *localPath = [[path objectAtIndex:0] stringByAppendingPathComponent:fullPath];
        if(data){
            if(![[NSFileManager defaultManager] fileExistsAtPath:localPath]){

               BOOL boo =  [[NSFileManager defaultManager] createFileAtPath:localPath contents:data attributes:nil];
            }
        }
        UIImage  *image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.cover.image = image;
        }];
        
    });
    
}

@end
