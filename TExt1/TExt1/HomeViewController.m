//
//  HomeViewController.m
//  登录界面
//
//  Created by 路人甲 on 16/6/7.
//  Copyright © 2016年 路人甲. All rights reserved.
//

#import "HomeViewController.h"
#import <BmobSDK/Bmob.h>
#import "WelcomeViewController.h"
@interface HomeViewController ()

@property (nonatomic,strong)NSArray *likes;
@property (nonatomic,strong)UIButton *countBtn;
@property (nonatomic,strong)BmobUser *buser;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buser = [BmobUser getCurrentUser];
    NSLog(@"用户名为:%@",self.buser.username);
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"首页";

    self.countBtn=[[UIButton alloc]initWithFrame:CGRectMake(50,100, 100, 42)];
    self.countBtn.backgroundColor=[UIColor lightGrayColor];
    [self.countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.countBtn];
    
    [self.countBtn addTarget:self action:@selector(countAdd) forControlEvents:UIControlEventTouchUpInside];
    
    //注销Button
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 300, 375, 100)];
    backBtn.backgroundColor=[UIColor redColor];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(BackWelcomeView) forControlEvents:UIControlEventTouchUpInside];
}

-(void)BackWelcomeView{

    [BmobUser logout];
    WelcomeViewController *wvc=[[WelcomeViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}

-(void)countAdd{
    
    BmobObject *bObj = [BmobObject objectWithClassName:@"Like"];
    
    [bObj setObject:[BmobUser getCurrentUser].username forKey:@"username"];
    
    [bObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"点赞成功");
            [self findLikes];
        }else{
            NSLog(@"点赞失败");
        }
    }];
}

-(void)findLikes{
    
    //查询多少条赞
    BmobQuery *q = [BmobQuery queryWithClassName:@"Like"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.likes = array;
        
        [self.countBtn setTitle:[NSString stringWithFormat:@"%ld赞",array.count] forState:UIControlStateNormal];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    
    //显示已赞数量
    BmobQuery *q = [BmobQuery queryWithClassName:@"Like"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.likes = array;
        
        [self.countBtn setTitle:[NSString stringWithFormat:@"%ld赞",array.count] forState:UIControlStateNormal];
    }];
    
}

@end
