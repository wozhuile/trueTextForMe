//
//  UIImageView+SuperImage.h
//  SuperWebImage
//
//  Created by SuperWang on 16/5/13.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SuperImage)
//根据url设置图片
-(void)setImageWithUrl:(NSURL*)url;



-(void)setImageWithUrl:(NSURL *)url placeholderImg:(UIImage*)plImg;
@end











