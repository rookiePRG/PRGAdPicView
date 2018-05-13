//
//  PRGViewController.m
//  PRGAdPicView
//
//  Created by rookiePRG on 05/13/2018.
//  Copyright (c) 2018 rookiePRG. All rights reserved.
//

#import "PRGViewController.h"
#import "PRGAdPicView.h"
#import "AdPicViewModel.h"
#import "UIImageView+WebCache.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width


@interface PRGViewController ()

@end

@implementation PRGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PRGAdPicView *adPicView = [PRGAdPicView picViewWithFrame:CGRectMake(0, 20, kScreenW, 180) LoadImageViewBlock:^(UIImageView *imageView, NSURL *url) {
        
        [imageView sd_setImageWithURL:url];
        
    }];
    
    NSArray *imageURLs = @[@"https://staticlive.douyucdn.cn/storage/webpic_resources/upload/slide/2018/0306/201803061544126470.jpg",
                           @"https://staticlive.douyucdn.cn/storage/webpic_resources/upload/slide/2018/0505/201805051110022414.jpg",
                           @"https://staticlive.douyucdn.cn/storage/webpic_resources/upload/slide/2018/0327/201803271223428487.jpg",
                           @"https://cs-op.douyucdn.cn/douyu-vrp-admin/2018/04/17/8e66e68d8d9f321f58ab2388eeee52ce.jpg",
                           @"https://staticlive.douyucdn.cn/storage/webpic_resources/upload/slide/2018/0505/201805051118132479.jpg",
                           @"https://cs-op.douyucdn.cn/douyu-vrp-admin/2018/05/10/f17c7030b71413f6e2ee3fedf4bea09e.jpg"];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < imageURLs.count; i ++) {
        AdPicViewModel *model = [[AdPicViewModel alloc] init];
        model.adImgURL = [NSURL URLWithString:imageURLs[i]];
        [tempArr addObject:model];
    }
    
    adPicView.picModels = [tempArr copy];
    
    [self.view addSubview:adPicView];
}

@end
