//
//  XMGKeyboardTool.m
//  键盘处理
//
//  Created by xiaomage on 15/7/23.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGKeyboardTool.h"

@implementation XMGKeyboardTool
+ (instancetype)tool
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (IBAction)previous:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(keyboardToolDidClickPreviousItem:)]) {
//        [self.delegate keyboardToolDidClickPreviousItem:self];
//    }
    if ([self.toolbarDelegate respondsToSelector:@selector(keyboardTool:didClickItem:)]) {
        [self.toolbarDelegate keyboardTool:self didClickItem:XMGKeyboardToolItemPrevious];
    }
}

- (IBAction)next:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(keyboardToolDidClickNextItem:)]) {
//        [self.delegate keyboardToolDidClickNextItem:self];
    //    }
    if ([self.toolbarDelegate respondsToSelector:@selector(keyboardTool:didClickItem:)]) {
        [self.toolbarDelegate keyboardTool:self didClickItem:XMGKeyboardToolItemNext];
    }
}

- (IBAction)done:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(keyboardToolDidClickDoneItem:)]) {
//        [self.delegate keyboardToolDidClickDoneItem:self];
    //    }
    
    if ([self.toolbarDelegate respondsToSelector:@selector(keyboardTool:didClickItem:)]) {
        [self.toolbarDelegate keyboardTool:self didClickItem:XMGKeyboardToolItemDone];
    }
}

@end
