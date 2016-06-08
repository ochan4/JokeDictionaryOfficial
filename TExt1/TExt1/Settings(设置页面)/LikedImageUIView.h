//
//  LikedImageUIView.h
//  笑话大全_设置页面
//
//  Created by AierChen on 1/6/16.
//  Copyright © 2016年 Canterbury Tale Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikedImageUIView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView* tableView;
//存放数据模型的数组
@property(strong,nonatomic)NSMutableArray *tableData;
//计算cell的高度
@property(nonatomic,assign)CGFloat cellHeight;
//用于加载下一页的参数(页码)
@property (nonatomic,assign) NSInteger pn;
@end
