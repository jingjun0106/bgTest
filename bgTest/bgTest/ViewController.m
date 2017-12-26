//
//  ViewController.m
//  bgTest
//
//  Created by 오픈태스크iOS on 2017. 12. 14..
//  Copyright © 2017년 오픈태스크iOS. All rights reserved.
//

#import "ViewController.h"
#import "KJDefine.h"
#import "FirstViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set grandient(梯度)Layer
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.button.bounds;
    [self.button.layer addSublayer:layer];
    
    
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    
    layer.colors = @[(__bridge id)UIColorFromRGB(0x5b9ced).CGColor,(__bridge id)[UIColor blueColor].CGColor];
    
    //layer.locations =@[@(0.5f),@(1.0f)];
    self.index = 0;
    
    
    CGRect rect = self.topButton.bounds;
    //일부 radio
    CGSize radio = CGSizeMake(5, 5);//radio size
    
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;//radio position
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    
    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    
    masklayer.frame = self.topButton.bounds;
    
    masklayer.path = path.CGPath;//set path
    
    self.topButton.layer.mask = masklayer;
    
    self.topButton.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonClicked:(id)sender {
    
    FirstViewController *vc = [[FirstViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
    
}

- (IBAction)topButtonClicked:(id)sender {
    
    
    FirstViewController *vc = [[FirstViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    
    navi.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//UIModalTransitionStyleCoverVertical;
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.8;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    switch (self.index) {
        case 0:
            animation.subtype = kCATransitionFromTop;
            break;
        case 1:
            animation.subtype = kCATransitionFromRight;
            break;
        case 2:
            animation.subtype = kCATransitionFromLeft;
            break;
        case 3:
            animation.subtype = kCATransitionFromBottom;
            break;
        default:
            break;
    }
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:navi animated:NO completion:nil];
    self.index++;
    if (self.index > 3) {
        self.index = 0;
    }
}
@end
