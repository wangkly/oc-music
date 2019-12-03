//
//  PlaylistItem.h
//  MusicApp
//
//  Created by wangky on 2019/12/3.
//  Copyright © 2019年 wangky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaylistItem : NSObject

@property(nonatomic,strong)NSString *coverImgUrl;
@property(nonatomic,strong) NSString *name;

-(instancetype)initObjectWithDict:(NSDictionary *)dict;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
