//
//  PlaylistItem.m
//  MusicApp
//
//  Created by wangky on 2019/12/3.
//  Copyright © 2019年 wangky. All rights reserved.
//

#import "PlaylistItem.h"

@implementation PlaylistItem

-(instancetype)initObjectWithDict:(NSDictionary *)dict{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
