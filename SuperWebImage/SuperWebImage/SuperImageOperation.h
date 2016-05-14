//
//  SuperImageOperation.h
//  SuperWebImage
//
//  Created by SuperWang on 16/5/13.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//1.下载
//2,更新ui
//3,缓存

@interface SuperImageOperation : NSOperation
#pragma mark 和
//@property(nonatomic,strong)UIImageView *imageView;
//@property(nonatomic,strong)NSURL *imgUrl;

//初始化方法
-(id)initWithUrl:(NSURL*)url imageView:(UIImageView*)imgView;
@end











