//
//  SXEditPanelView.m
//  TableViewDemo
//
//  Created by iOSDeveloper on 2017/2/23.
//  Copyright © 2017年 iOSDeveloper. All rights reserved.
//

#import "SXEditPanelView.h"
#import "XMGKeyboardTool.h"

@interface SXEditPanelView()<XMGKeyboardToolDelegate,UITextFieldDelegate>

/** 所有的文本框数组 */
@property (nonatomic, strong) NSArray *fields;
/** 工具条 */
@property (nonatomic, weak) XMGKeyboardTool *toolbar;

@end

@implementation SXEditPanelView

+ (instancetype)sxeditPanelView{
    NSLog(@"sxeditPanelView");
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        NSLog(@"initWithCoder");
        //[self setupUI];
    }
    return self;
}

- (void)layoutSubviews{
    NSLog(@"layoutSubviews");
    [self setupUI];
}

- (void)setupUI{
    self.fields = @[self.goodsTextField, self.pirceTextField, self.amountField,self.moneyTextField];
    
    // 加载工具条控件
    XMGKeyboardTool *toolbar = [XMGKeyboardTool tool];
    toolbar.toolbarDelegate = self;
    self.toolbar = toolbar;
    
    // 设置工具条
    self.goodsTextField.inputAccessoryView = toolbar;
    self.pirceTextField.inputAccessoryView = toolbar;
    self.amountField.inputAccessoryView = toolbar;
    self.moneyTextField.inputAccessoryView = toolbar;
}

#pragma mark - <XMGKeyboardToolDelegate>
- (void)keyboardTool:(XMGKeyboardTool *)tool didClickItem:(XMGKeyboardToolItem)item
{
    if (item == XMGKeyboardToolItemPrevious) {
        NSUInteger currentIndex = 0;
        for (UIView *view in self.subviews) {
            if ([view isFirstResponder]) {
                currentIndex = [self.fields indexOfObject:view];
            }
        }
        currentIndex--;
        
        [self.fields[currentIndex] becomeFirstResponder];
        
        self.toolbar.previousItem.enabled = (currentIndex != 0);
        self.toolbar.nextItem.enabled = YES;
        
    } else if (item == XMGKeyboardToolItemNext) {
        NSUInteger currentIndex = 0;
        for (UIView *view in self.subviews) {
            if ([view isFirstResponder]) {
                currentIndex = [self.fields indexOfObject:view];
            }
        }
        currentIndex++;
        
        [self.fields[currentIndex] becomeFirstResponder];
        
        self.toolbar.previousItem.enabled = YES;
        self.toolbar.nextItem.enabled = (currentIndex != self.fields.count - 1);
        
    } else if (item == XMGKeyboardToolItemDone) {
        
        [self endEditing:YES];
        
        if (self.sxEditPanelVDelegate && [self.sxEditPanelVDelegate respondsToSelector:@selector(inputFinished:)]) {
            //把数据传出去
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:self.goodsTextField.text forKey:@"goods"];
            [dic setValue:self.pirceTextField.text forKey:@"price"];
            [dic setValue:self.amountField.text forKey:@"amount"];
            [dic setValue:self.moneyTextField.text forKey:@"money"];
            [self.sxEditPanelVDelegate inputFinished:dic];
        }
    }
}

#pragma mark - <UITextFieldDelegate>
/**
 * 当点击键盘右下角的return key时,就会调用这个方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.goodsTextField) {
        // 让emailField成为第一响应者
        [self.pirceTextField becomeFirstResponder];
    } else if (textField == self.pirceTextField) {
        // 让addressField成为第一响应者
        [self.amountField becomeFirstResponder];
    } else if (textField == self.amountField) {
        [self.moneyTextField endEditing:YES];
    }else if (textField == self.moneyTextField) {
        [self endEditing:YES];
        //        [textField resignFirstResponder];
    }
    return YES;
}
/**
 * 键盘弹出就会调用这个方法
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSUInteger currentIndex = [self.fields indexOfObject:textField];
    
    self.toolbar.previousItem.enabled = (currentIndex != 0);
    self.toolbar.nextItem.enabled = (currentIndex != self.fields.count - 1);
}

@end
