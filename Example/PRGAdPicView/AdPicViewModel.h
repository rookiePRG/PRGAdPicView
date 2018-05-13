//
//  AdPicViewModel.h
//  PRGAdPicView
//
//  Created by belief on 2018/5/13.
//  Copyright © 2018年 PRG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRGAdPicProtocol.h"

@interface AdPicViewModel : NSObject<PRGAdPicProtocol>

@property (nonatomic,copy)NSURL *adImgURL;

@end
