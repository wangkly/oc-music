//
//  PlaylistDetailController.m
//  MusicApp
//
//  Created by wangky on 2020/4/1.
//  Copyright © 2020年 wangky. All rights reserved.
//
#import "PlaylistDetailController.h"
#import "SongItem.h"
#import "SongItemCell.h"

extern char* host;
static NSString const *identifier = @"myCell";
@interface PlaylistDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *playlist;
@property(nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation PlaylistDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"detailId==viewDidLoad==%@",self.detailId);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"歌单详情"];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)] animated:YES];
    UITableView *playlist = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self setPlaylist:playlist];
    [self.playlist registerClass:[SongItemCell class] forCellReuseIdentifier:identifier];
    [self.playlist setDataSource:self];
    [self.playlist setDelegate:self];
    [self.view addSubview:self.playlist];
    
    [self loadData];
    
    // Do any additional setup after loading the view.
}

-(void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadData{
    NSString *str = [NSString stringWithFormat:@"%s%@%@",host,@"/playlist/detail?id=",self.detailId];
    NSURL *url = [NSURL URLWithString:str];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *playlist = [dict valueForKey:@"playlist"];
        NSArray *tracks = [playlist valueForKey:@"tracks"];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *song in tracks) {
            SongItem *songItem = [[SongItem alloc] initObjectWithDict:song];
            [temp addObject:songItem];
        }
        self.dataSource = [temp mutableCopy];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.playlist reloadData];
        }];
        
    }];
    
    [task resume];
    
}


#pragma tableviewdatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SongItemCell * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    SongItem *item = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateCell:item];
    return cell;
}

#pragma tablviewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
