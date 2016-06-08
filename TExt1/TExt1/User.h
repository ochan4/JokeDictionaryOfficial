//
//  User.h
//  ITSNS
//
//  Created by tarena on 16/5/16.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface User : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, copy)NSString *headUrlPath;

@property (nonatomic, strong)BmobUser *bUser;

-(instancetype)initWithBmobUser:(BmobUser *)bUser;

+(User *)currentUser;

-(void)update;

@end
