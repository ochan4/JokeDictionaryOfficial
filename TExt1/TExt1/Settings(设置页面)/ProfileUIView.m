//
//  ProfileUIView.m
//  笑话大全_设置页面
//
//  Created by AierChen on 1/6/16.
//  Copyright © 2016年 Canterbury Tale Inc. All rights reserved.
//

#import "ProfileUIView.h"
#import "WelcomeViewController.h"
#import "HomeViewController.h"
#import "User.h"
#import <BmobSDK/Bmob.h>

@implementation ProfileUIView

- (void)awakeFromNib{
    [self.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.nightButton addTarget:self action:@selector(nightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cleanMemoryButton addTarget:self action:@selector(cleanMemoryAction) forControlEvents:UIControlEventTouchUpInside];
    [self.reportButton addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
    [self.aboutUsButton addTarget:self action:@selector(aboutUsAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)loginAction{
    WelcomeViewController *wvc = [WelcomeViewController new];
    
    //如果已经有用户登录过，着运行时直接进入到上一次登录的用户，否则进入到登录页面
    if ([BmobUser getCurrentUser]==nil){
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:wvc animated:YES completion:nil];
    }else{
        UIAlertController *ac3 = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac3 addAction:action3];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac3 animated:YES completion:nil];

    }

}

-(void)logoutAction{
    
    if ([BmobUser getCurrentUser]==nil){
        UIAlertController *ac3 = [UIAlertController alertControllerWithTitle:@"提示" message:@"还没有登陆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac3 addAction:action3];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac3 animated:YES completion:nil];
    }else{
        //创建添加AlertController:
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否注销" preferredStyle:UIAlertControllerStyleActionSheet];
        
        //创建action1:(alert里的小选项：确定或取消)
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //按了确定后要做的事情：
            
            [BmobUser logout];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"注销监听" object: @"注销"];
            
            UIAlertController *ac3 = [UIAlertController alertControllerWithTitle:@"完成注销" message:@"我们随时欢迎您回来！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [ac3 addAction:action3];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac3 animated:YES completion:nil];
        }];
        
        //创建action2:(alert里的小选项：确定或取消)
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        //AlertController添加两个选项
        [ac addAction:action1];
        [ac addAction:action2];
        
        //AlertController添加到主页面
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    }
}

-(void)nightAction{
    NSString *nightdayMessage = @"是否更改成其他颜色模式";
    
    //创建添加AlertController:
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:nightdayMessage preferredStyle:UIAlertControllerStyleAlert];
    
    //创建action1:(alert里的小选项：确定或取消)
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"紫色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //按了确定后要做的事情：
        
        //发出通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"背景颜色监听" object: @"紫色"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"背景颜色2监听" object: @"紫色"];

    }];
    
    //创建action2:(alert里的小选项：确定或取消)
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"蓝色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //按了确定后要做的事情：
        
        //发出通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"背景颜色监听" object: @"蓝色"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"背景颜色2监听" object: @"蓝色"];
        
    }];
    
    //创建action3:(alert里的小选项：确定或取消)
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"黑色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //按了确定后要做的事情：
        
        //发出通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"背景颜色监听" object: @"黑色"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"背景颜色2监听" object: @"黑色"];
        
    }];
    
    //AlertController添加两个选项
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    //AlertController添加到主页面
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
}

-(void)cleanMemoryAction{

    [[SDWebImageManager sharedManager].imageCache calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        
        NSString *message = [NSString stringWithFormat:@"您确认清除%.1fM缓存吗？",totalSize/1024.0/1024.0];
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //清除内存缓存
            [[SDWebImageManager sharedManager].imageCache clearMemory];
            
            //清除磁盘缓存
            [[SDWebImageManager sharedManager].imageCache clearDisk];
            
            //清除 系统Api所缓存的数据
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [ac addAction:action1];
        [ac addAction:action2];
     
        //当在NSObject或UIView里，使用这个转跳
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
     
    }];
}

-(void)reportAction{
    
    if ([BmobUser getCurrentUser]==nil){
        
        UIAlertController *noac = [UIAlertController alertControllerWithTitle:@"个人信息" message:@"需要登陆才能进行编辑" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [noac addAction:action2];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:noac animated:YES completion:nil];
    
    
    }else{
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"个人信息" message:@"编辑" preferredStyle:UIAlertControllerStyleAlert];
        
        __block UITextField *myTF = nil;
        __block UITextField *myTF2 = nil;
        
        [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            myTF = textField;
            textField.text = [User currentUser].name;
            
        }];
        
        [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            myTF2 = textField;
            textField.text = [User currentUser].intro;
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //处理保存用户信息的逻辑
            [User currentUser].name = myTF.text;
            [User currentUser].intro = myTF2.text;
            [[User currentUser] update];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"修改信息监听" object: @"名字和签名"];
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [ac addAction:action1];
        [ac addAction:action2];
        
        //当在NSObject或UIView里，使用这个转跳
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    }
}

-(void)aboutUsAction{
    //创建添加AlertController:
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"关于我们" message:@"我们一共是四个人开发这款笑话app, 排名不分前后: 林健聪,吴志勇,黄进,陈爱儿。" preferredStyle:UIAlertControllerStyleAlert];
    
    //创建action1:(alert里的小选项：确定或取消)
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    
    //AlertController添加两个选项
    [ac addAction:action1];
    
    //AlertController添加到主页面
    //当在NSObject或UIView里，使用这个转跳
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    
}


@end
