//
//  FirstViewController.m
//  bgTest
//
//  Created by 오픈태스크iOS on 2017. 12. 14..
//  Copyright © 2017년 오픈태스크iOS. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "KJDefine.h"
#import "AnimationFirstToSecond.h"
#import "UIButton+Action.h"
#import <objc/runtime.h>


@interface FirstViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        [self.navigationController.navigationBar setTintColor:[UIColor blueColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x5b9ced)}];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        
        self.navigationItem.title = @"FirstView";
        self.navigationController.delegate = self;
    }
    
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, SCREEN_SIZE.width - 100 * 2, 100)];
    [self.button setTitle:@"toNextView" forState:UIControlStateNormal];
    [self.button setTitleColor:UIColorFromRGB(0x5b9ced) forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.button.layer.borderWidth = 1.0f;
    
    [self.view addSubview:self.button];
    
    
    UIButton *button1 = [UIButton createBtnWithFrame:CGRectMake((SCREEN_SIZE.width - 100)/2, (SCREEN_SIZE.height - 50)/2 - 50, 100, 50) title:@"按钮" actionBlock:^(UIButton *button) {
        float r = random()%255/255.0;
        float g = random()%255/255.0;
        float b = random()%255/255.0;
        self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    }];
    button1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button1];
    
    //第二个按钮
    UIButton *button2 = [UIButton createBtnWithFrame:CGRectMake((SCREEN_SIZE.width - 100)/2, CGRectGetMaxY(button1.frame) + 50, 100, 50) title:@"按钮2" actionBlock:nil];
    button2.actionBlock = ^(UIButton *button){
        NSLog(@"---%@---",button.currentTitle);
    };
    button2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button2];
    
    
    // Do any additional setup after loading the view.
    /*
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.view.bounds;
    
    
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    
    layer.colors = @[(__bridge id)[UIColor yellowColor].CGColor,(__bridge id)[UIColor grayColor].CGColor];
    */
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(20, SCREEN_SIZE.height - 100, SCREEN_SIZE.width - 20 * 2, 44)];
    tf.borderStyle = UITextBorderStyleLine;
    tf.delegate = self;
    [tf addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:tf];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.navigationController) {
        self.navigationController.delegate = self;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController) {
        if (self.navigationController.delegate == self) {
            self.navigationController.delegate = nil;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldTextChanged:(UITextField *)textField
{
    [self getiOSPrivateAPiWithClassName:textField.text];
}

#pragma mark - 获取苹果私有的APi方法
- (void)getiOSPrivateAPiWithClassName:(NSString *)className{
    //NSString *className = NSStringFromClass([UIView class]);
    
    const char *cClassName = [className UTF8String];
    
    id theClass = objc_getClass(cClassName);
    
    unsigned int outCount;
    
    Method *m =  class_copyMethodList(theClass,&outCount);
    
    NSLog(@"%@--%d", className,outCount);
    
    for (int i = 0; i<outCount; i++) {
        
        SEL a = method_getName(*(m+i));
        
        NSString *sn = NSStringFromSelector(a);
        
        NSLog(@"%@%d--%@",className, i,sn);
    }
}


#pragma mark UINavigationControllerDelegate methods

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC
{
    if (fromVC == self && [toVC isKindOfClass:[SecondViewController class]]) {
        return [[AnimationFirstToSecond alloc] init];
    }else{
        return nil;
    }
}
#pragma mark buttonAction
-(void)buttonClicked:(id)sender
{
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
