//
//  ViewController.m
//  MusicApp
//
//  Created by wangky on 2019/12/2.
//  Copyright © 2019年 wangky. All rights reserved.
//

#import "ViewController.h"
#import "PlayListCell.h"
#import "PlaylistItem.h"
extern char *host;
static NSString const *identifier = @"myCell";
static NSInteger const defaultColumnCount = 2;
static CGFloat const defaultColumnSpace = 10;
static CGFloat const defaultRowSpace = 10;
static UIEdgeInsets const defaultEdgeInsets = {10,10,10,10};

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,strong) UICollectionView *playList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"歌单"];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)] animated:YES];
    
    CGFloat width = (CGRectGetWidth(self.view.bounds)-defaultEdgeInsets.left-defaultEdgeInsets.right- (defaultColumnCount - 1)* defaultColumnSpace)/defaultColumnCount;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(width, 250);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInset = defaultEdgeInsets;
    
    UICollectionView *lists = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [lists setBackgroundColor:[UIColor whiteColor]];
    [lists registerClass:[PlayListCell class] forCellWithReuseIdentifier:identifier];
    
    [self setPlayList:lists];
    
    [self.playList setDelegate:self];
    [self.playList setDataSource:self];
    
    [self.view addSubview:self.playList];
    
    [self loadData];
    
}

-(void)back:(id *)sender{
    NSLog(@"back");
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PlayListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    PlaylistItem *item = [self.dataSource objectAtIndex:indexPath.row];
    
    
    [cell setImage:item.coverImgUrl andTitle:item.name];
    
    [cell setBackgroundColor:[UIColor grayColor]];
    
    return cell;
}




-(void)loadData{
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%s%@",host,@"/top/playlist"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil ];
        
        NSArray *arr = [dict valueForKey:@"playlists"];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            PlaylistItem *item = [[PlaylistItem alloc] initObjectWithDict:dict];
            [temp addObject:item];
        }
        
        self.dataSource = [temp mutableCopy];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.playList reloadData];
        }];
        
  }];
    
    [task resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
