//
//  TestViewController.m
//  内存泄漏工具Instrument测试
//
//  Created by wangzhe on 2019/1/11.
//  Copyright © 2019年 MoGuJie. All rights reserved.
//

#import "TestViewController.h"
#import <objc/runtime.h>

typedef void(^TestBlock)(void);

@interface TestViewController ()
@property (nonatomic, strong) TestBlock block;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.block = ^{
        NSLog(@"进入这里面了");
        self.view.backgroundColor = [UIColor redColor];
    };
    
    [self testMethod];
    
    //引用runtime获取当前类的属性
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    //    free(ivars);
    
}

-(void)testMethod{
    self.block();
}

-(void)dealloc{
    NSLog(@"----%@被释放了---",[self class]);
}

@end
