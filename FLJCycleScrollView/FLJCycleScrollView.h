//
//  View.h
//  UIScrollView
//
//  Created by 贾林飞 on 2017/12/19.
//  Copyright © 2017年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSInteger index);

@interface FLJCycleScrollView : UIView

@property(nonatomic,copy)SelectBlock selectBlock;

-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray*)dataSource;

@end
