//
//  DiscoverViewController.m
//  MusicApp
//
//  Created by wangkly on 2020/3/15.
//  Copyright © 2020 wangky. All rights reserved.
//

#import "DiscoverViewController.h"
extern char *host;
@interface DiscoverViewController ()

@property(nonatomic,strong) BannerView * bannerView;
@property(nonatomic,strong) NSArray *banner;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect frame = self.view.bounds;
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    [self initBanner];
    [self loadData];
    
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(100, 200, 100, 50);
    [btn setTitle:@"歌单" forState:UIControlStateNormal];
//    [btn setTitle:@"摸我干啥" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(navigate:) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor grayColor];
    //设置文字颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    [self.view addSubview:btn];
    
    
    UIImageView * image = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"dog"]];
    image.frame =CGRectMake(100, 300, 100, 100);
    [self.view addSubview:image];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(250, 200, 100, 50);
    [btn2 setTitle:@"跳转" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(presentPlaylistController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn2];

    // Do any additional setup after loading the view.
}


-(void) loadData{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",host, @"/banner"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url ];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *temp = [NSMutableArray array];
        NSArray *arr = [root objectForKey:@"banners"];
        for (NSDictionary *dict in arr) {
            NSString *imageUrl = [dict objectForKey:@"imageUrl"];
            [temp addObject:imageUrl];
        }
        self.banner = [temp mutableCopy];
        NSLog(@"----> %@",self.banner);
        [self.bannerView initHeaderViewData: self.banner];
    }];
    [dataTask resume];
}

-(void)initBanner{
    self.bannerView = [BannerView initHeaderView];
    [self.view addSubview:self.bannerView];
}

-(void)presentPlaylistController{
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self presentViewController: navi animated:YES completion:^{
        NSLog(@"presentViewController");
    }];
}



-(void)navigate:(id)sender{
    NSString *str = [NSString stringWithFormat:@"%s%@",host,@"/playlist/hot"];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * cats = [json valueForKey:@"tags"];
        
        NSMutableArray *temp = [NSMutableArray array];
        
        [temp addObject:@{@"name": @"推荐"}];
        [temp addObjectsFromArray:cats];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
          
            PlaylistGroundController* controller = [[PlaylistGroundController alloc] init];
            [controller setHotCats:temp];
            [self presentViewController: [[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
        }];
    }];
    
    [task resume];
  
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
