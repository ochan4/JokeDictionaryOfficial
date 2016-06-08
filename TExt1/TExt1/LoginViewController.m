//
//  LoginViewController.m
//  登录界面
//
//  Created by 路人甲 on 16/6/6.
//  Copyright © 2016年 路人甲. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/Bmob.h>
#import "AppDelegate.h"
#import "RegisterViewController.h"

#define NewFont [UIFont fontWithName:@"FZMiaoWuS-GB" size:30];

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation LoginViewController

#pragma mark:登录Bmob
- (IBAction)LoginAction:(UIButton *)sender {
    

    [BmobUser loginInbackgroundWithAccount:self.userName.text andPassword:self.PassWord.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"登录成功:%@",user);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"登陆监听" object: @"名字和签名"];
            [self dismissViewControllerAnimated:YES completion:nil];

        }
        
        if (error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                //确定时做的事
            }];
            
            [alert addAction:cancel];
            [alert addAction:confirm];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置密码显示密文
    self.PassWord.secureTextEntry=YES;
    
    self.Loginbutton.layer.cornerRadius = self.Loginbutton.bounds.size.height/2;
    self.Loginbutton.alpha=0.5f;
    self.Loginbutton.titleLabel.font=NewFont;
    
    //设置bar的颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.title = @"登陆";
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
            self.myView.transform=CGAffineTransformMakeTranslation(0, -keyboardH);
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



@end
