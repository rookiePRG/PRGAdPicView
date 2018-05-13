//
//  PRGAdPicProtocol.h
//  PRGAdPicView
//
//  Created by belief on 2018/5/12.
//  Copyright © 2018年 PRG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PRGAdPicProtocol <NSObject>

/**
 *  广告图片URL
 */
@property (nonatomic, copy, readonly) NSURL *adImgURL;

@end
