//
//  SongItem.h
//  MusicApp
//
//  Created by wangky on 2020/4/1.
//  Copyright © 2020年 wangky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongItem : NSObject
@property long id;
@property(nonatomic,strong) NSString* name;

-(instancetype)initObjectWithDict:(NSDictionary *)dict;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
