//
//  YQPanoramaView.h
//  鱼眼全景图
//
//  Created by 杨帆 on 2019/5/8.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQPanoramaView : UIView

@property(nonatomic,strong)UIImage *image;

//鱼眼效果，默认开启
@property(nonatomic,assign)BOOL Fisheye;

//惯性滑动，追求滑动稳定可以关闭。
@property(nonatomic,assign)BOOL scrollInertia;


@end

NS_ASSUME_NONNULL_END
