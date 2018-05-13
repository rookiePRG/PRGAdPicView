//
//  PRGAdPicView.m
//  PRGAdPicView
//
//  Created by belief on 2018/5/12.
//  Copyright © 2018年 PRG. All rights reserved.
//

#import "PRGAdPicView.h"
#import "AdPickViewCell.h"

static NSString *const adPicViewCellID = @"adPicViewCellID";

@interface PRGAdPicView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 自动滚动timer
 */
@property (nonatomic, strong) NSTimer *scrollTimer;
/**
 视图
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  页码指示
 */
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation PRGAdPicView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

+(instancetype)picViewWithFrame:(CGRect)frame LoadImageViewBlock:(LoadImageBlock)loadImageBlock
{
    PRGAdPicView *adPicView = [[PRGAdPicView alloc] initWithFrame:frame];
    adPicView.loadBlock = loadImageBlock;
    return adPicView;
}

#pragma mark -lazy


-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        //创建Layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
        [_collectionView registerNib:[UINib nibWithNibName:@"AdPickViewCell" bundle:currentBundle] forCellWithReuseIdentifier:adPicViewCellID];
        
    }
    return _collectionView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _pageControl.frame = CGRectMake(0, self.bounds.size.height -20, self.bounds.size.width, 20);
}

#pragma 设置界面UI
-(void)setupUI
{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

#pragma mark -setter
-(void)setPicModels:(NSArray<id> *)picModels
{
    _picModels = picModels;
    
    [self.collectionView reloadData];

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_picModels.count *100 inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    _pageControl.numberOfPages = picModels.count;
    
    [self removeScrollTimer];
    [self addScrollTimer];
    
}

#pragma mark -定时器

//添加定时器
-(void)addScrollTimer{
    
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
}

//移除定时器
-(void)removeScrollTimer
{
    if (_scrollTimer) {
        
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
    
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picModels.count*1000;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AdPickViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:adPicViewCellID forIndexPath:indexPath];
    id<PRGAdPicProtocol> picM = self.picModels[indexPath.item % self.picModels.count];
    if (self.loadBlock) {
        self.loadBlock(cell.AdimageView, picM.adImgURL);
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<PRGAdPicProtocol> picM = self.picModels[indexPath.item % self.picModels.count];
    if (self.delegate && [self.delegate respondsToSelector:@selector(adPicViewDidSelectedPicModel:)]) {
        [self.delegate adPicViewDidSelectedPicModel:picM];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.获取滚动的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;

    //2.计算pageControl的currentIndex
    if (_picModels.count) {
        
        NSInteger page = offsetX / scrollView.bounds.size.width;
        page = page % _picModels.count;
        _pageControl.currentPage = page;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeScrollTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addScrollTimer];
}

#pragma mark -事件

-(void)scrollNextPage
{
    CGFloat currentOffsetX = self.collectionView.contentOffset.x;
    [self.collectionView setContentOffset:CGPointMake(currentOffsetX+self.collectionView.bounds.size.width, 0) animated:YES];
}



@end
