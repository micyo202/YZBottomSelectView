//
//  ViewController.m
//  YZBottomSelectView
//
//  Created by Apple on 2017/11/1.
//  Copyright © 2017年 Yanzheng. All rights reserved.
//

#import "ViewController.h"
#import "YZBottomSelectView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *logLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showYZBottomSelectView:(UIButton *)sender {
    
    // 创建使用方法
    [YZBottomSelectView showBottomSelectViewWithTitle:@"选择的标题" cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除（红色）" otherButtonTitles:@[@"JAVA", @"Objective-C", @"Python"] handler:^(YZBottomSelectView *bootomSelectView, NSInteger index) {
        NSLog(@"Yan -> 按钮index说明：取消：0，删除：-1，其他按钮：1、2、3...");
        NSString *logStr = [NSString stringWithFormat:@"Yan -> 当前点击按钮的index为：%ld", index];
        NSLog(@"%@", logStr);
        
        _logLabel.text = [NSString stringWithFormat:@"%@\n%@", _logLabel.text, logStr];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
