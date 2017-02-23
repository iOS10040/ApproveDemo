//
//  SXToolBarMessageCell.m
//  ShuxinCustom
//
//  Created by iOS开发者 on 2017/1/20.
//  Copyright © 2017年 iOS开发者. All rights reserved.
//

#import "SXToolBarMessageCell.h"

@implementation SXToolBarMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SXToolBarMessageModel *)model{
    _model = model;
    
    self.goods.text = model.goods;
    self.price.text = model.price;
    self.amount.text = model.amount;
    self.money.text = model.money;
}

@end
