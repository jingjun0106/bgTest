//
//  AnimationSecondToFirst.m
//  bgTest
//
//  Created by 오픈태스크iOS on 2017. 12. 14..
//  Copyright © 2017년 오픈태스크iOS. All rights reserved.
//

#import "AnimationSecondToFirst.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation AnimationSecondToFirst

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SecondViewController *fromViewController = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FirstViewController *toViewController = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *snapShot = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    [containerView addSubview:snapShot];
    
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.alpha = 0.0;
        snapShot.frame = toViewController.button.frame;
        
    } completion:^(BOOL finished) {
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];
}


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

@end
