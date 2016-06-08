//
//  ProfileUIView.h
//  笑话大全_设置页面
//
//  Created by AierChen on 1/6/16.
//  Copyright © 2016年 Canterbury Tale Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface ProfileUIView : UIView
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *nightButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanMemoryButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutUsButton;
@end
