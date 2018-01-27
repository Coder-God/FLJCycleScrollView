//
//  ViewController.m
//  UIScrollView
//
//  Created by 贾林飞 on 2017/12/19.
//  Copyright © 2017年 贾林飞. All rights reserved.
//

#import "ViewController.h"
#import "FLJCycleScrollView.h"
#import "MyCollectionViewController.h"
#import <UIImageView+WebCache.h>

@interface ViewController ()


@property(nonatomic,strong)FLJCycleScrollView* myView;

@property(nonatomic,strong)UIImageView* imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray* array = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516969352525&di=6a289965308f7ed3eaf7a41fefc43535&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F500fd9f9d72a6059f550a1832334349b023bbae3.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516969352524&di=cba71242d2230ca1ba32d0d1e23f4c18&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa044ad345982b2b713b5ad7d3aadcbef76099b65.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516969352524&di=7488de292ed2326d1bc73b2544a64e9f&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F500fd9f9d72a6059099ccd5a2334349b023bbae5.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/c8ea15ce36d3d5397966ba5b3187e950342ab0cb.jpg"];
//    array = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516969352525&di=6a289965308f7ed3eaf7a41fefc43535&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F500fd9f9d72a6059f550a1832334349b023bbae3.jpg"];
    
    self.myView = [[FLJCycleScrollView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 150) dataSource:array];

    __weak typeof(self) weakSelf = self;
    self.myView.selectBlock = ^(NSInteger index) {
        NSString* url = [array objectAtIndex:index];
        [weakSelf.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    };
    [self.view addSubview:self.myView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 150, 150)];
    [self.view addSubview:self.imageView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    MyCollectionViewController* vc = [[MyCollectionViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];

}

@end
