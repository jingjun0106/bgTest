//
//  UIButton+Action.m
//  bgTest
//
//  Created by 오픈태스크iOS on 2017. 12. 22..
//  Copyright © 2017년 오픈태스크iOS. All rights reserved.
//

#import "UIButton+Action.h"
#import <objc/runtime.h>

static NSString *keyOfMethod;
static NSString *keyOfBlock;

@implementation UIButton (Action)

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock{
    UIButton *button = [[UIButton alloc]init];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject (button , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return button;
}

- (void)buttonClick:(UIButton *)button{
    
    //通过key获取被关联对象
    //objc_getAssociatedObject(id object, const void *key)
    ActionBlock block1 = (ActionBlock)objc_getAssociatedObject(button, &keyOfMethod);
    if(block1){
        block1(button);
    }
    
    ActionBlock block2 = (ActionBlock)objc_getAssociatedObject(button, &keyOfBlock);
    if(block2){
        block2(button);
    }
}  

-(void)setActionBlock:(ActionBlock)actionBlock
{
    objc_setAssociatedObject(self, &keyOfBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(ActionBlock)actionBlock
{
    return objc_getAssociatedObject(self, &keyOfBlock);
}

@end
