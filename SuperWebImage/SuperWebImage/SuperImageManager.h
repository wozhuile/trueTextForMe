//
//  SuperImageManager.h
//  SuperWebImage
//
//  Created by SuperWang on 16/5/13.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperImageOperation.h"

@interface SuperImageManager : NSObject
{
    //下载队列
    //operation 放在队列里使用
    NSOperationQueue *imgQueue;
}

//公共缓存区域
@property(nonatomic,strong)NSCache *imageCache;



+(SuperImageManager*)sharedManager;



//下载入口方法
-(void)downloadImgWithUrl:(NSURL*)url
                imageView:(UIImageView*)imageV;

//将获取文件地址的方法,封装到单例中
+(NSString*)getFilePathWithName:(NSString*)fileName;









@end




