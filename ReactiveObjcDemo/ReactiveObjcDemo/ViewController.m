//
//  ViewController.m
//  ReactiveObjcDemo
//
//  Created by He Bob on 2017/12/26.
//  Copyright © 2017年 He Bob. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()
@property (nonatomic, strong) NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"2");
        return [RACDisposable disposableWithBlock:^{}];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"1");
    }];
    
    //代替 target
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [[testButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击");
    }];
    
    //代替 notification
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"name" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"通知");
    }];
    
    //代替 KVO
    [RACObserve(self, name) subscribeNext:^(NSString *newName) {
        NSLog(@"%@", newName);
    }];
    
    //代替 delegate 只能用于返回void的代理
    [[self rac_signalForSelector:@selector(tableView:heightForRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        NSLog(@"delegate");
    }];
}

@end
