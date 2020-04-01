//
//  SongItemCell.h
//  MusicApp
//
//  Created by wangky on 2020/4/1.
//  Copyright © 2020年 wangky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongItem.h"
@interface SongItemCell : UITableViewCell
@property(strong,nonatomic) UILabel *nameLabel;
-(void)updateCell:(SongItem *)item;
@end
