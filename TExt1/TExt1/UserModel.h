//
//  UserModel.h
//  test
//
//  Created by jc on 16/5/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
//文本内容
@property (nonatomic,copy) NSString *introduction;
//图片路径
@property (nonatomic,copy) NSString *imagePath;
//时间
@property (nonatomic,copy) NSString *timePath;

@end
