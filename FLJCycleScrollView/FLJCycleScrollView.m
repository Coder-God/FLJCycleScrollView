//
//  View.m
//  UIScrollView
//
//  Created by 贾林飞 on 2017/12/19.
//  Copyright © 2017年 贾林飞. All rights reserved.
//

#import "FLJCycleScrollView.h"
#import <UIImageView+WebCache.h>

#define kRightMargin 18

#define kItemWidth  (kScreenWidth-kRightMargin)

#define TLTRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define TLTRGB(r,g,b) TLTRGBA(r,g,b,1.0)

//随机色
#define TLTRandomColor TLTRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface FLJCycleScrollView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView* scrollView;

@property(nonatomic,strong)NSArray* dataSource;

@property(nonatomic,assign)int currentIndex;

@end
@implementation FLJCycleScrollView

-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    if (self == [super initWithFrame:frame]) {
        
        NSAssert(dataSource.count>0, @"不能为空");
        self.dataSource = dataSource;
        if (dataSource.count > 1) {
            NSMutableArray* array = [NSMutableArray arrayWithArray:self.dataSource];
            [array addObject:self.dataSource.firstObject];
            [array addObject:self.dataSource[1]];
            [array insertObject:self.dataSource.lastObject atIndex:0];
            self.dataSource = array;
            
            self.currentIndex = 1;
        }
        
        [self setupScrollView];

    }
    return self;
}

-(void)setupScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, self.bounds.size.height)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.clipsToBounds = NO;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = kItemWidth;
    CGFloat height = self.bounds.size.height;
    int maxCount = 4;

    if (self.dataSource.count == 1) {
        self.scrollView.scrollEnabled = NO;
        maxCount = 1;
    }else
    {
        self.scrollView.scrollEnabled = YES;
    }

    for (int i = 0; i<maxCount; i++) {
        if (self.dataSource.count == 1) {
            x = kRightMargin/2;
        }else
            x = i*width;
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        imageView.tag = i+1;
        [self configureImageViewDataWithImageView:imageView imageUrl:[self.dataSource objectAtIndex:i]];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectImageView:)];
        [imageView addGestureRecognizer:tapGesture];
    }
    if (self.dataSource.count > 1) {
        [self.scrollView setContentOffset:CGPointMake(kItemWidth, 0)];
    }
    
    self.scrollView.contentSize = CGSizeMake(width*maxCount, self.bounds.size.height);
    [self addSubview:self.scrollView];

}

//点击事件
-(void)didSelectImageView:(UITapGestureRecognizer*)gesture
{
    UIImageView* imageView = (UIImageView*)gesture.view;

    NSInteger index = self.currentIndex;
    if (imageView.tag == 2) {
        index = self.currentIndex-1;
    }else{
        index = self.currentIndex;
    }
    if (index == self.dataSource.count-3){
        index = 0;
    }
    NSString* url = [self.dataSource objectAtIndex:index];
    
    if (self.selectBlock) {
        self.selectBlock(index);
    }
}

//刷新scrollView数据
-(void)reloadScrollView
{
    UIImageView* leftImageView = [self.scrollView viewWithTag:1];
    UIImageView* middleImageView = [self.scrollView viewWithTag:2];
    UIImageView* rightImageView = [self.scrollView viewWithTag:3];
    UIImageView* lastImageView = [self.scrollView viewWithTag:4];

    [self configureImageViewDataWithImageView:leftImageView imageUrl:[self.dataSource objectAtIndex:self.currentIndex-1]];
    [self configureImageViewDataWithImageView:middleImageView imageUrl:[self.dataSource objectAtIndex:self.currentIndex]];
    [self configureImageViewDataWithImageView:rightImageView imageUrl:[self.dataSource objectAtIndex:self.currentIndex+1]];
    [self configureImageViewDataWithImageView:lastImageView imageUrl:[self.dataSource objectAtIndex:self.currentIndex+2]];

    [self.scrollView setContentOffset:CGPointMake(kItemWidth, 0) animated:NO];

}

//imageview展示图片
-(void)configureImageViewDataWithImageView:(UIImageView*)imageView imageUrl:(NSString*)imageUrl
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

//scrollView停止减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentOffSet_x = scrollView.contentOffset.x;
    
    if (contentOffSet_x < kItemWidth) {
        //-------------------------------->
        NSLog(@"右");
        self.currentIndex -- ;
        if (self.currentIndex == 0) {
            self.currentIndex = (int)self.dataSource.count - 3;
        }
        [self reloadScrollView];

    }else if(contentOffSet_x>kItemWidth)
    {
        ///<-----------------------------
        NSLog(@"左");
        self.currentIndex++;
        if (self.currentIndex>=self.dataSource.count-2) {
            self.currentIndex = 1;
        }
        [self reloadScrollView];
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* view = [super hitTest:point withEvent:event];
    //view存在且 view是self或者self的子控件
    if (view && [view isDescendantOfView:self]) {
        //如果点击区域在x在（0，kItemWidth）肯定是uiimageView，如果在scrollView右边缘，是self相应。因为该demo是第一个uiimageView一直在中间，self相应的时候直接return第三个uiimageView就ok了
        if ([view isKindOfClass:[UIImageView class]]) {
            return view;
        }else
        {
            UIImageView* imageView = [self.scrollView viewWithTag:3];
            return imageView;
        }
    }
    return [self pointInside:point withEvent:event] ? self.scrollView : nil;
}

@end
