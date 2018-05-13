//
//  PRGAdPicView.h
//  PRGAdPicView
//
//  Created by belief on 2018/5/12.
//  Copyright © 2018年 PRG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRGAdPicProtocol.h"

typedef void(^LoadImageBlock)(UIImageView *imageView, NSURL *url);

@protocol PRGAdPicViewDelegate <NSObject>

- (void)adPicViewDidSelectedPicModel: (id <PRGAdPicProtocol>)picM;

@end

@interface PRGAdPicView : UIView

+(instancetype)picViewWithFrame:(CGRect)frame LoadImageViewBlock:(LoadImageBlock)loadImageBlock;

/**
 *  用于加载图片的代码块, 必须赋值
 */
@property (nonatomic, copy) LoadImageBlock loadBlock;

/**
 *  用于告知外界, 当前滚动到的是哪个广告数据模型
 */
@property (nonatomic, strong) id<PRGAdPicViewDelegate> delegate;

/**
 *  用来展示图片的数据源
 */
@property (nonatomic, strong) NSArray <id<PRGAdPicProtocol>>*picModels;


@end
