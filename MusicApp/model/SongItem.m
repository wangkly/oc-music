//
//  SongItem.m
//  MusicApp
//
//  Created by wangky on 2020/4/1.
//  Copyright © 2020年 wangky. All rights reserved.
//

#import "SongItem.h"

@implementation SongItem
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
