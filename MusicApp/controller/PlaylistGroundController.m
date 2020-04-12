//
//  PlaylistGroundController.m
//  MusicApp
//
//  Created by wangkly on 2020/4/12.
//  Copyright © 2020 wangky. All rights reserved.
//

#import "PlaylistGroundController.h"
#import "ViewController.h"
@interface PlaylistGroundController ()<WMPageControllerDataSource>

@end

@implementation PlaylistGroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma "WMPageControllerDataSource"

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    
    return 3;
}

-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    UIViewController *view = [[ViewController alloc] init];
    
    return view;
}


-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    
    return [NSString stringWithFormat:@"%ld",(long)index];
    
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
