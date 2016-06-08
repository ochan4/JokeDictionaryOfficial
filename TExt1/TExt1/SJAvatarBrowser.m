//
//  SJAvatarBrowser.m
//  test
//
//  Created by jc on 16/6/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SJAvatarBrowser.h"
#import <QuartzCore/QuartzCore.h>
static CGRect oldframe;
static UIImageView *imageViews;

@implementation SJAvatarBrowser

+(void)showImage:(UIImageView
                  *)avatarImageView{
    
    UIImage
    *image=avatarImageView.image;
    
    UIWindow
    *window=[UIApplication sharedApplication].keyWindow;
    
    UIView
    *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0,
                                                            0,
                                                            [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    oldframe=[avatarImageView
              convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor=[UIColor
                                    blackColor];
    
    backgroundView.alpha=0;
    
    UIImageView
    *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    
    imageView.image=image;
    
    imageView.tag=1;
    
    imageView.userInteractionEnabled = YES;
        
    [backgroundView
     addSubview:imageView];
    
    
    [window
     addSubview:backgroundView];
    
    
    UITapGestureRecognizer
    *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView
     addGestureRecognizer: tap];
    
    
    
    [UIView
     animateWithDuration:0.3
     
     animations:^{
         
         imageView.frame=CGRectMake(0,([UIScreen
                                        mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2,
                                    [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
         
         backgroundView.alpha=1;
         
         imageViews = imageView;
         
     }
     completion:^(BOOL finished) {
         
         UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
         [imageView addGestureRecognizer:pinch];
         
         UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
         saveBtn.center = CGPointMake(backgroundView.frame.size.width/2, backgroundView.frame.size.height-35);
         [backgroundView addSubview:saveBtn];
         [backgroundView bringSubviewToFront:saveBtn];
         
         [saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
         [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         saveBtn.backgroundColor = [UIColor whiteColor];
         saveBtn.layer.cornerRadius = 16;
         saveBtn.layer.masksToBounds = YES;
         
         [saveBtn addTarget:self action:@selector(saveImageAction) forControlEvents:UIControlEventTouchUpInside];
         
     }];
    
}



+(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView
    *backgroundView=tap.view;
    
    UIImageView
    *imageView=(UIImageView*)[tap.view viewWithTag:1];
    
    [UIView
     animateWithDuration:0.3
     
     animations:^{
         
         imageView.frame=oldframe;
         
         backgroundView.alpha=0;
         
     }
     completion:^(BOOL finished) {
         
         [backgroundView
          removeFromSuperview];
         
     }];
    
}

+(void)pinchAction:(UIPinchGestureRecognizer *)pinch{
    
    UIImageView *iv = (UIImageView*)pinch.view;
    //第一种：通过修改bounds缩放
    //    iv.bounds = CGRectMake(0, 0, iv.bounds.size.width*pinch.scale, iv.bounds.size.height*pinch.scale);
    
    //第二种通过矩阵变换缩放控件，可以通过宽高给负值，让图片旋转
    iv.transform = CGAffineTransformScale(iv.transform, pinch.scale, pinch.scale);
    
    //缩放一次后要重置缩放比 以当前显示状态为基准
    pinch.scale = 1;
}
+(void)saveImageAction{
    
    UIGraphicsBeginImageContext(imageViews.bounds.size);
    
    [imageViews.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(temp, nil, nil, nil);

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
    label.center = CGPointMake(imageViews.frame.size.width/2, imageViews.window.frame.size.height/2);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.textColor = [UIColor whiteColor];
    label.font = NewFont
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0;
    label.layer.cornerRadius = 16;
    label.layer.masksToBounds = YES;
    label.text = @"保存好咯~                      您可以在相册里查看啦~";
    
    [imageViews addSubview:label];
    
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

@end