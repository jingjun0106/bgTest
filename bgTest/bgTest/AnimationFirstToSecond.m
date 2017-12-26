//
//  AnimationFirstToSecond.m
//  bgTest
//
//  Created by 오픈태스크iOS on 2017. 12. 14..
//  Copyright © 2017년 오픈태스크iOS. All rights reserved.
//

#import "AnimationFirstToSecond.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "KJDefine.h"

@implementation AnimationFirstToSecond

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    FirstViewController *fromViewController = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toViewController = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIButton *button = fromViewController.button;
    UIView *snapShot = [button snapshotViewAfterScreenUpdates:NO];
    CGRect snapShotFrame = [containerView convertRect:button.frame toView:button.superview];
    snapShot.frame = snapShotFrame;//원래 위치
    button.hidden = YES;
    
    CGRect frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = frame;
    toViewController.view.alpha = 0;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:snapShot];
    
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.alpha = 1.0;
        CGRect frame = [containerView convertRect:toViewController.view.frame toView:toViewController.view];
        snapShot.frame =frame;//커지면서 전체 스크린
    } completion:^(BOOL finished) {
        button.hidden = NO;
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

@end
