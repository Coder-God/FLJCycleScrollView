//
//  TodayViewController.m
//  MyWidget
//
//  Created by 贾林飞 on 2018/1/5.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property(nonatomic,strong)UIButton* openBtn;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.openBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [self.openBtn setTitle:@"open" forState:UIControlStateNormal];
    [self.openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.openBtn addTarget:self action:@selector(openApp) forControlEvents:UIControlEventTouchUpInside];
    self.openBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.openBtn];
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);

}

-(void)openApp
{
    [self.extensionContext openURL:[NSURL URLWithString:@"aaaaa://"] completionHandler:^(BOOL success) {
        
    }];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {

    completionHandler(NCUpdateResultNewData);
}

@end
