//
//  SXToolBarMessageCell.h
//  ShuxinCustom
//
//  Created by iOS开发者 on 2017/1/20.
//  Copyright © 2017年 iOS开发者. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXToolBarMessageModel.h"

@interface SXToolBarMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goods;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;


@property(nonatomic,strong)SXToolBarMessageModel *model;
@end
