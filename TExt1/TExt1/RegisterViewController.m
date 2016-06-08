//
//  RegisterViewController.m
//  登录界面
//
//  Created by 路人甲 on 16/6/6.
//  Copyright © 2016年 路人甲. All rights reserved.
//

#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Settings(设置页面)/SettingsViewController.h"

#define NewFont [UIFont fontWithName:@"FZMiaoWuS-GB" size:30];

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *myView;


@property (nonatomic,strong) BmobUser *user;

@end

@implementation RegisterViewController

-(void)RegisterButtonaction{
    self.user = [[BmobUser alloc]init];
    self.user.username = self.userName.text;
    self.user.password = self.Password.text;
    
    [self.user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"Sign up successfully");
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"注册监听" object: @"注册成功"];
            
            [self Login];
        }else{
            NSLog(@"%@",error);
        }
    }];
}

-(void)Login{
    [BmobUser loginInbackgroundWithAccount:self.userName.text andPassword:self.Password.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"登录成功:%@",user);
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Password.secureTextEntry=YES;
    
    self.RegisterButton.layer.cornerRadius = self.RegisterButton.bounds.size.height/2;
    self.RegisterButton.alpha=0.5f;
    self.RegisterButton.titleLabel.font=NewFont;
    self.PhoneNumber.backgroundColor=self.Password.backgroundColor=self.userName.backgroundColor=[UIColor clearColor];
    
    //设置bar颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.title = @"注册";

    [self.RegisterButton addTarget:self action:@selector(RegisterButtonaction) forControlEvents:UIControlEventTouchUpInside];
    
    //监听软键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyboardFrameChange:(NSNotification *)noti{
    
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        if (keyboardF.origin.y==[UIScreen mainScreen].bounds.size.height) {//收键盘
            self.myView.transform= CGAffineTransformIdentity;
        }else
        {//软件盘弹出的时候 把表情隐藏
            self.myView.transform=CGAffineTransformMakeTranslation(0,-keyboardH);
        }
    }];
}



-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.PhoneNumber.text.length>0&&self.userName.text.length>0&&self.Password.text.length>0) {
        self.RegisterButton.enabled = YES;
    }else{
        self.RegisterButton.enabled = NO;
        self.RegisterButton.backgroundColor = [UIColor lightGrayColor];
    }
}
@end
