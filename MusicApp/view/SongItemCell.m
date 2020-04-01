//
//  SongItemCell.m
//  MusicApp
//
//  Created by wangky on 2020/4/1.
//  Copyright © 2020年 wangky. All rights reserved.
//

#import "SongItemCell.h"

@implementation SongItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setNameLabel:[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20) ] ];
    [self.contentView addSubview:self.nameLabel];
    return self;
}

-(void)updateCell:(SongItem *)item{
    self.nameLabel.text = item.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
