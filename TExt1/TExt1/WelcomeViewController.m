//
//  WelcomeViewController.m
//  登录界面
//
//  Created by 路人甲 on 16/6/6.
//  Copyright © 2016年 路人甲. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#define NewFont [UIFont fontWithName:@"FZMiaoWuS-GB" size:30];
@interface WelcomeViewController ()
@property (nonatomic,strong) UIButton *LoginButton;
@property (nonatomic,strong) UIButton *RegisterButton;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self LoginAndRegister];
    
}
//欢迎界面的登录和注册Button
-(void)LoginAndRegister{
    //登录
    self.LoginButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 667-60, 142, 40)];
    self.LoginButton.backgroundColor = [UIColor lightGrayColor];
    self.LoginButton.alpha=0.5f;
    self.LoginButton.titleLabel.font=NewFont;
    [self.LoginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.LoginButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:self.LoginButton];
    [self.LoginButton addTarget:self action:@selector(LoginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //注册
    self.RegisterButton = [[UIButton alloc]initWithFrame:CGRectMake(215, 667-60, 142, 40)];
    self.RegisterButton.backgroundColor = [UIColor lightGrayColor];
    [self.RegisterButton setTitle:@"注册" forState:UIControlStateNormal];
    self.RegisterButton.alpha=0.5f;
    self.RegisterButton.titleLabel.font=NewFont;
    [self.RegisterButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.RegisterButton];
    [self.RegisterButton addTarget:self action:@selector(RegisterButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.LoginButton.layer.cornerRadius = self.RegisterButton.layer.cornerRadius = self.RegisterButton.bounds.size.height/2;
    self.LoginButton.layer.masksToBounds = self.RegisterButton.layer.masksToBounds=YES;
    self.RegisterButton.layer.borderWidth=1;
    self.RegisterButton.layer.borderColor=[UIColor whiteColor].CGColor;

}

-(void)LoginButtonAction{
    LoginViewController *lvc = [LoginViewController new];
    [self presentViewController:lvc animated:YES completion:nil];
}

-(void)RegisterButtonAction{
    RegisterViewController *rvc = [RegisterViewController new];
    [self presentViewController:rvc animated:YES completion:nil];
    
}


-(void)viewWillAppear:(BOOL)animated{
    if ([BmobUser getCurrentUser]!=nil){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
