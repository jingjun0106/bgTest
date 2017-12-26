//
//  UIButton+Action.h
//  bgTest
//
//  Created by 오픈태스크iOS on 2017. 12. 22..
//  Copyright © 2017년 오픈태스크iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(UIButton *button);

@interface UIButton (Action)

@property (nonatomic,copy) ActionBlock actionBlock;

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock;

@end
