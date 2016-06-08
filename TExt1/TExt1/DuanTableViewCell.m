//
//  DuanTableViewCell.m
//  test
//
//  Created by jc on 16/5/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DuanTableViewCell.h"

@implementation DuanTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}

#pragma mark - 初始化

-(void)initLayuot{
    
    //增加点击cell的效果
    self.selectedBackgroundView = [UIView new];
    
    //初始化边框
    [self Content_Bg_Action];
    
    //初始化内容
    [self introductionAction];
    
    //初始化趣图
    [self ImageAction];
    
    //初始化按钮
    [self BtnAction];
}

#pragma mark - 初始化边框

-(void)Content_Bg_Action{
    _all_content_bg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 375 - 20, 100 - 10)];
    [self addSubview:_all_content_bg];
    _all_content_bg.image = [UIImage imageNamed:@"all_kuang"];
    _all_content_bg.highlightedImage = [UIImage imageNamed:@"all_kuang_up"];
    _all_content_bg.image = [_all_content_bg.image resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2) resizingMode:UIImageResizingModeStretch];
    _all_content_bg.highlightedImage = [_all_content_bg.highlightedImage resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2) resizingMode:UIImageResizingModeStretch];
}

#pragma mark - 初始化文本内容

-(void)introductionAction{
    _introduction = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 345, 40)];
    _introduction.backgroundColor = [UIColor clearColor];
    _introduction.font = NewFont
    [_all_content_bg addSubview:_introduction];
}

#pragma mark - 初始化趣图

-(void)ImageAction{
    //趣图
    _img_content = [[UIImageView alloc] initWithFrame:CGRectMake(_introduction.frame.origin.x, _introduction.frame.size.height+5, ImageWidth, ImageHeight)];
    _img_content.contentMode = UIViewContentModeScaleAspectFill;
    _img_content.userInteractionEnabled = YES;
    _img_content.clipsToBounds = YES;
    
    //图片提示配图
    _imagePS = [[UILabel alloc]initWithFrame:CGRectMake(0, ImageHeight-40, ImageWidth, 40)];
    [_img_content addSubview:_imagePS];
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    [SJAvatarBrowser showImage:(UIImageView *)tap.view];//调用方法
}

#pragma mark - 初始化“收藏”，“转发”，“点赞”，等等。。 按钮

-(void)BtnAction{
    _btnView = [[UIView alloc]initWithFrame:CGRectMake(10, _all_content_bg.frame.size.height-40, _all_content_bg.frame.size.width, 40)];
    [self addSubview:_btnView];
    
    //转发按钮
    _relayBtn = [[UIButton alloc]initWithFrame:CGRectMake(ButtonSize*1, 0, ButtonSize, ButtonSize)];
    _relayBtn.tag = 0;
    [_relayBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    _relayBtn.imageView.highlightedImage = [UIImage imageNamed:@"mainCellShareClick"];
    [_relayBtn addTarget:self action:@selector(hello:) forControlEvents:UIControlEventTouchUpInside];
    
    //复制按钮
    _copysBtn = [[UIButton alloc]initWithFrame:CGRectMake(ButtonSize*3, 0, ButtonSize, ButtonSize)];
    _copysBtn.tag = 1;
    [_copysBtn setImage:[UIImage imageNamed:@"mainCellCopy"] forState:UIControlStateNormal];
    _copysBtn.imageView.highlightedImage = [UIImage imageNamed:@"mainCellCopyClick"];
    [_copysBtn addTarget:self action:@selector(hello:) forControlEvents:UIControlEventTouchUpInside];
    
    //收藏按钮
    _collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(ButtonSize*5, 0, ButtonSize, ButtonSize)];
    _collectBtn.tag = 2;
    [_collectBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
    _collectBtn.imageView.highlightedImage = [UIImage imageNamed:@"mainCellCommentClick"];
    [_collectBtn addTarget:self action:@selector(hello:) forControlEvents:UIControlEventTouchUpInside];
    
    //点赞按钮
    _likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(ButtonSize*7, 0, ButtonSize, ButtonSize)];
    _likeBtn.tag = 3;
    [_likeBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    _likeBtn.imageView.highlightedImage = [UIImage imageNamed:@"mainCellDingClick"];
    [_likeBtn addTarget:self action:@selector(hello:) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnView addSubview:_relayBtn];
    [_btnView addSubview:_copysBtn];
    [_btnView addSubview:_collectBtn];
    [_btnView addSubview:_likeBtn];
    
}
-(void)hello:(UIButton *)btn{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
    label.center = CGPointMake(self.frame.size.width/2, self.window.frame.size.height/2);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.textColor = [UIColor whiteColor];
    label.font = NewFont
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0;
    label.layer.cornerRadius = 16;
    label.layer.masksToBounds = YES;
    [self.window.rootViewController.view addSubview:label];
    
    switch (btn.tag) {
        case 0://转发按钮
        {
            NSLog(@"btn1");
            
        }
            break;
        case 1://复制按钮
        {
            label.text = @"已复制~                      您可以粘贴给小伙伴噢~";
            
            [UIView animateWithDuration:1.5 animations:^{
                label.alpha = .7;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                }completion:^(BOOL finished) {
                    [label removeFromSuperview];
                }];
            }];
            
            UIPasteboard* board = [UIPasteboard generalPasteboard];
            board.string = self.introduction.text;
            
        }
            break;
        case 2://收藏按钮
        {
            
            label.text = @"收藏好咯~                  记得在收藏里回味噢~";
            
            [UIView animateWithDuration:1.5 animations:^{
                label.alpha = .7;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                }completion:^(BOOL finished) {
                    [label removeFromSuperview];
                }];
            }];
            
        }
            break;
        case 3://点赞按钮
        {
            label.text = @"点赞成功~                  火起来火起来火起来~";
            
            [UIView animateWithDuration:1.5 animations:^{
                label.alpha = .7;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:1.5 animations:^{
                    label.alpha = 0;
                }completion:^(BOOL finished) {
                    [label removeFromSuperview];
                }];
            }];
            
        }
            break;
    }
}

#pragma mark - 赋值和自动换行，计算cell和其他控件的高度

-(void)setIntroductionText:(NSString*)text{
    
    //获得当前cell高度
    CGRect frame = [self frame];
    
    //文本赋值
    _introduction.text = text;
    
    //设置label的最大行数
    _introduction.numberOfLines = 10;
    
    CGSize size = CGSizeMake(335, 1000);
    
    CGSize labelSize = [_introduction.text sizeWithFont:_introduction.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    
    _introduction.frame = CGRectMake(_introduction.frame.origin.x, _introduction.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    if (_img_content.image) {
        
        //带图片高度
        frame.size.height = labelSize.height+75+_img_content.frame.size.height;
        
        //提示配图
        _imagePS.backgroundColor = [UIColor blackColor];
        _imagePS.alpha = .5;
        _imagePS.text = @"点击查看大图";
        _imagePS.textColor = [UIColor whiteColor];
        _imagePS.textAlignment = NSTextAlignmentCenter;
        _imagePS.font = NewFont
        
        //增加点击放大手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_img_content addGestureRecognizer:tap];
        [self addSubview:_img_content];
        
    }else{
        //没图片高度
        frame.size.height = labelSize.height+70;
    }
    //cell的高度位置
    self.frame = frame;
    
    //边框图片的高度位置
    _all_content_bg.frame = CGRectMake(_all_content_bg.frame.origin.x, _all_content_bg.frame.origin.y, Content_bg_Width, self.frame.size.height-10);
    
    //按钮的高度位置
    _btnView.frame = CGRectMake(10, self.frame.size.height-45, 355, 40);
    
    //图片的高度位置
    _img_content.frame = CGRectMake(_all_content_bg.frame.origin.x*3, _introduction.frame.size.height+25, ImageWidth, ImageHeight);
}



@end
