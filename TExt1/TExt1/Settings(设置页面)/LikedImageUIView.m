//
//  LikedImageUIView.m
//  笑话大全_设置页面
//
//  Created by AierChen on 1/6/16.
//  Copyright © 2016年 Canterbury Tale Inc. All rights reserved.
//

#import "LikedImageUIView.h"
#import "DuanTableViewCell.h"
#import "UserModel.h"

@implementation LikedImageUIView
#pragma mark - 全局常量
static NSString * const RequestURL = @"http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_pic";
static NSString *apikey = @"a3497acf07bc5d1204952a5a3284b11d";

- (void)awakeFromNib {

    [self setupTable];
}

#pragma mark - UITableviewDatasource 数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DuanTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self appearCell:cell andScale:2];
    
    UserModel *user = [_tableData objectAtIndex:indexPath.row];
    
    [cell.img_content sd_setImageWithURL:[NSURL URLWithString:user.imagePath] placeholderImage:[UIImage imageNamed:@"loadingImage"]];
    
    [cell setIntroductionText:user.introduction];
    
    self.cellHeight = cell.frame.size.height;
    
    return cell;
}

#pragma mark - UITableviewDelegate 代理方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 刷新cell时动画加载

- (void)appearCell:(UITableViewCell *)cell andScale:(CGFloat)scale
{
    CATransform3D rotate = CATransform3DMakeScale( 0.0, scale, scale);
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotate;
    [UIView beginAnimations:@"scale" context:nil];
    [UIView setAnimationDuration:.3];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark - 请求数据方法

//上拉刷新 发送请求并获取数据方法
- (void)loadData{
    
    //实例化一个回调，处理请求的返回值
    APISCallBack* callBack = [APISCallBack alloc];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    [parameter setObject:@(self.pn).stringValue forKey:@"page"];
    
    //请求API
    [ApiStoreSDK executeWithURL:RequestURL method:@"GET" apikey:apikey parameter:parameter callBack:callBack];
    
    callBack.onSuccess = ^(long status, NSString* responseString) {
        
        if(responseString != nil) {
            
            NSData* plistData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            
            NSDictionary *mainDic = [NSJSONSerialization JSONObjectWithData:plistData options:NSJSONReadingMutableContainers error:&error];
            
            NSDictionary *bodyDic = mainDic[@"showapi_res_body"];
            
            NSArray *contentlistArr = bodyDic[@"contentlist"];
            
            for (NSDictionary *contentDic in contentlistArr) {
                
                UserModel *user = [UserModel new];
                
                [user setIntroduction:contentDic[@"title"]];
                
                user.imagePath = contentDic[@"img"];
                
                [self.tableData addObject:user];
            }
        }
        // 刷新数据（若不刷新数据会显示不出）
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    };
    callBack.onError = ^(long status, NSString* responseString) {
        NSLog(@"onError");
        [self.tableView.mj_header endRefreshing];
    };
    
    callBack.onComplete = ^() {
        NSLog(@"onComplete");
    };
}

//下拉加载 更新页码并获取数据方法
- (void)loadMoreData{
    
    //实例化一个回调，处理请求的返回值
    APISCallBack* callBack = [APISCallBack alloc];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    [parameter setObject:@(++self.pn).stringValue forKey:@"page"];
    
    //请求API
    [ApiStoreSDK executeWithURL:RequestURL method:@"GET" apikey:apikey parameter:parameter callBack:callBack];
    
    callBack.onSuccess = ^(long status, NSString* responseString) {
        
        if(responseString != nil) {
            
            NSData* plistData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            
            NSDictionary *mainDic = [NSJSONSerialization JSONObjectWithData:plistData options:NSJSONReadingMutableContainers error:&error];
            
            NSDictionary *bodyDic = mainDic[@"showapi_res_body"];
            
            NSArray *contentlistArr = bodyDic[@"contentlist"];
            
            for (NSDictionary *contentDic in contentlistArr) {
                
                UserModel *user = [UserModel new];
                
                [user setIntroduction:contentDic[@"title"]];
                
                user.imagePath = contentDic[@"img"];
                
                [self.tableData addObject:user];
            }
        }
        // 刷新数据（若不刷新数据会显示不出）
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    };
    callBack.onError = ^(long status, NSString* responseString) {
        NSLog(@"onError");
        [self.tableView.mj_footer endRefreshing];
    };
    
    callBack.onComplete = ^() {
        NSLog(@"onComplete");
    };
}

#pragma mark - 页面初始化加载

-(void)setupTable{
    
    self.pn = 1;
    
    self.tableData = [NSMutableArray array];
    
    self.backgroundColor = [UIColor purpleColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor grayColor];;
    [self addSubview:_tableView];
    
    [_tableView registerClass:[DuanTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor lightTextColor];
    
    // 头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    
    // 尾部刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


@end
