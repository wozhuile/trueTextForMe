//
//  UIImageView+SuperImage.m
//  SuperWebImage
//
//  Created by SuperWang on 16/5/13.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import "UIImageView+SuperImage.h"
#import "SuperImageManager.h"
@implementation UIImageView (SuperImage)

-(void)setImageWithUrl:(NSURL*)url
{
    
    [[SuperImageManager sharedManager]downloadImgWithUrl:url imageView:self];
    //UIImageView*im=[[UIImageView alloc]init];
    //im.image=
}




//添加默认图片
-(void)setImageWithUrl:(NSURL *)url placeholderImg:(UIImage*)plImg
{
    self.image = plImg;
    [self setImageWithUrl:url];
}


@end







