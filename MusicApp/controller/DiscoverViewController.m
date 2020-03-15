//
//  DiscoverViewController.m
//  MusicApp
//
//  Created by wangkly on 2020/3/15.
//  Copyright © 2020 wangky. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"发现"];
    self.tabBarItem.image=[UIImage imageNamed:@"discovery"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitle:@"摸我干啥" forState:UIControlStateHighlighted];
//    btn.backgroundColor = [UIColor grayColor];
    //设置文字颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    [self.view addSubview:btn];
    
    
    UIImageView * image = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"dog"]];
    image.frame =CGRectMake(100, 300, 100, 100);
    [self.view addSubview:image];


    
    
    // Do any additional setup after loading the view.
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
