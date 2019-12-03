//
//  PlayListCell.h
//  MusicApp
//
//  Created by wangky on 2019/12/2.
//  Copyright © 2019年 wangky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayListCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cover;
@property (strong, nonatomic) IBOutlet UILabel *title;

-(instancetype) init;

-(instancetype) initWithFrame:(CGRect)frame;

-(void) setImage:(NSString *) image andTitle:(NSString *) title;

@end
