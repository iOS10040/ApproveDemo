//
//  SXEditPanelView.h
//  TableViewDemo
//
//  Created by iOSDeveloper on 2017/2/23.
//  Copyright © 2017年 iOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InputFinishedBlock) (NSDictionary *dic);
@protocol SXEditPanelViewDelegate <NSObject>
//完成输入的代理方法
- (void)inputFinished:(NSMutableDictionary *)dic;

@end

@interface SXEditPanelView : UIView

@property (weak, nonatomic) IBOutlet UITextField *goodsTextField;
@property (weak, nonatomic) IBOutlet UITextField *pirceTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
/** 代理 */
@property (nonatomic, weak) id<SXEditPanelViewDelegate> sxEditPanelVDelegate;
+ (instancetype)sxeditPanelView;

@end
