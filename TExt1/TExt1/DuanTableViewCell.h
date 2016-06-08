//
//  DuanTableViewCell.h
//  test
//
//  Created by jc on 16/5/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DuanTableViewCell : UITableViewCell
//图片
@property(strong,nonatomic)UIImageView* img_content;
//边框
@property(strong,nonatomic)UIImageView* all_content_bg;
//用户介绍
@property(nonatomic,strong) UILabel *introduction;
//按钮托盘
@property(nonatomic,strong)UIView *btnView;
//按钮
@property(nonatomic,strong)UIButton *likeBtn;//点赞
@property(nonatomic,strong)UIButton *relayBtn;//转发
@property(nonatomic,strong)UIButton *collectBtn;//收藏
@property(nonatomic,strong)UIButton *copysBtn;
//图片提示
@property(nonatomic,strong)UILabel *imagePS;
//给用户介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;

@end
