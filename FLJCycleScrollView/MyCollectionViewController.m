//
//  MyCollectionViewController.m
//  UIScrollView
//
//  Created by 贾林飞 on 2017/12/27.
//  Copyright © 2017年 贾林飞. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"
#import <AVFoundation/AVFoundation.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kItemWidth  kScreenWidth

#define TLTRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define TLTRGB(r,g,b) TLTRGBA(r,g,b,1.0)

//随机色
#define TLTRandomColor TLTRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface MyCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UICollectionView* collectionView;

@property(nonatomic,strong)UIImagePickerController* pickerController;

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
   
}

#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth - 18, 90);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.layer.borderWidth = .5f;
    //  cell.layer.borderColor = TLTRGB(226, 226, 226).CGColor;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = TLTRandomColor;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%s",__func__);
    if (scrollView.isDragging) {
        NSLog(@"scrollView.isDragging");
    }else
        NSLog(@"3111111111111111111");
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%s",__func__);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%s",__func__);
//    CGFloat contentOffSet_x = scrollView.contentOffset.x;
//    CGFloat margin = (kScreenWidth-7-11);
//    int page = contentOffSet_x / margin;
//    if (page == 0) {
//        [scrollView setContentOffset:CGPointMake(margin * (self.dataSource.count/2), 0) animated:NO];
//
//    }else if(page == self.dataSource.count - 2)
//    {
//        [scrollView setContentOffset:CGPointMake(margin*(self.dataSource.count/2-1), 0) animated:NO];
//
//    }else if(page == self.dataSource.count-1)
//    {
//        //        [scrollView setContentOffset:CGPointMake(margin*(self.dataSource.count/2), 0) animated:NO];
//    }
    
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth-18, 100) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor blueColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.clipsToBounds = NO;
        _collectionView.bounces = NO;
    }
    return _collectionView;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self selectVideo];
}

-(void)selectVideo
{
    self.pickerController = [[UIImagePickerController alloc] init];
    
    //sourcetype有三种分别是camera，photoLibrary和photoAlbum
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    //设置媒体类型为public.movie
    self.pickerController.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];
    self.pickerController.delegate = self;
    
    [self presentViewController:self.pickerController animated:YES completion:nil];
}

@end
