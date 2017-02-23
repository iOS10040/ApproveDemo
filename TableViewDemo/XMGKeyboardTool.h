//
//  XMGKeyboardTool.h
//  键盘处理
//
//  Created by xiaomage on 15/7/23.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    XMGKeyboardToolItemPrevious,//上一项
    XMGKeyboardToolItemNext,//下一项
    XMGKeyboardToolItemDone//完成
} XMGKeyboardToolItem;

@class XMGKeyboardTool;

@protocol XMGKeyboardToolDelegate <NSObject>

@optional
//- (void)keyboardToolDidClickPreviousItem:(XMGKeyboardTool *)tool;
//- (void)keyboardToolDidClickNextItem:(XMGKeyboardTool *)tool;
//- (void)keyboardToolDidClickDoneItem:(XMGKeyboardTool *)tool;
- (void)keyboardTool:(XMGKeyboardTool *)tool didClickItem:(XMGKeyboardToolItem)item;
@end

@interface XMGKeyboardTool : UIToolbar
@property (weak, nonatomic, readonly) IBOutlet UIBarButtonItem *nextItem;
@property (weak, nonatomic, readonly) IBOutlet UIBarButtonItem *previousItem;

+ (instancetype)tool;

/** 代理 */
@property (nonatomic, weak) id<XMGKeyboardToolDelegate> toolbarDelegate;
@end
