//
//  SJAvatarBrowser.h
//  test
//
//  Created by jc on 16/6/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SJAvatarBrowser : NSObject
/**
 
 *
 @brief  浏览头像
 
 *
 
 *
 @param  oldImageView    头像所在的imageView
 
 */
@property(nonatomic,strong)UIImageView *imageView;
+(void)showImage:(UIImageView*)avatarImageView;
@end
