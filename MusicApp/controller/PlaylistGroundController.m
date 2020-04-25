//
//  PlaylistGroundController.m
//  MusicApp
//
//  Created by wangkly on 2020/4/12.
//  Copyright © 2020 wangky. All rights reserved.
//

#import "PlaylistGroundController.h"
#import "ViewController.h"
extern char * host;

@interface PlaylistGroundController ()<WMPageControllerDataSource>


@end

@implementation PlaylistGroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"歌单广场"];
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)] animated:YES ];
    // Do any additional setup after loading the view.
}

-(void)back{
 
    [self dismissViewControllerAnimated:YES completion:nil];
}

//-(NSArray *)_hotCats{
//    if(_hotCats == nil){
//        _hotCats = [self queryHotCats];
//    }
//    return _hotCats;
//}




#pragma "WMPageControllerDataSource"

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    NSLog(@"=====count=====");
    return _hotCats.count;
}

-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    NSLog(@"=====view=====");
    ViewController *view = [[ViewController alloc] init];
    NSDictionary *dict = [_hotCats objectAtIndex:index];
    if(![[dict valueForKey:@"name"] isEqualToString:@"推荐" ]){
     view.cats = [dict valueForKey:@"name"];
    }
    view.offset = 0;
    
    return view;
}


-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    NSDictionary *dict = [_hotCats objectAtIndex:index];
    NSLog(@"=====name=====");
    return [dict valueForKey:@"name"];
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
