//
//  SuperImageManager.m
//  SuperWebImage
//
//  Created by SuperWang on 16/5/13.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import "SuperImageManager.h"
#import "SuperImageOperation.h"
#import "Base64.h"
@implementation SuperImageManager
//单例获取方法
+(SuperImageManager*)sharedManager
{
    static SuperImageManager *manager = nil;
    static dispatch_once_t onceToken;
    //执行一次,线程锁
    dispatch_once(&onceToken, ^
    {
        
        
        
        
        manager = [[SuperImageManager alloc]init];
    });

    return manager;

}




//初始化方法
-(instancetype)init
{
    self = [super init];
    if (self) {
        //初始化公共缓存对象
        _imageCache = [[NSCache alloc]init];
        //初始化队列
        imgQueue = [[NSOperationQueue alloc]init];
    }
    return self;
}
#pragma mark 2.到这里看看路径了..为什么第二次点击后都不在那个类而是来单这个单例类里边写呢??好像是逻辑不好做,就算逻辑业务不好处理??因为最后一个我们从内存找,找不到去本地找,找不到去下载并且缓存内存和本地,,如果在之前那个类里边写,我们还是需要参数URL和图片啊,为什么就不可以呢??反正都是去外边获取的URL和图片相框啊,,反正还是要在找不到的时候需要下载的,如果在那个类里边写,直接调用也可以的啊..为什么就不在那个类里边写呢??..不懂,,先研究现在目前的吧...我们要把那个类,那个operation任务添加到队列里边,也和单例类一样,需要一个唯一的全局变量,就创建一次,也就是保证就一个对象,一个队列..也许这就是为什么要来这里处理的原因了吧..初始化方法在单例类获取唯一对象的时候,也就调用了一次.所以也就得到一个唯一的队列??还有缓存对象也就是一个??保证每次请求的时候都是唯一??...不理先...我们写点击第二次后的逻辑吧...需要参数么??当然需要,从缓存内存里边取,存储的时候都要了一个key也就是URL来作为唯一的key,取出来我们还是需要这个的,所以第一个参数我们就是要URL了..如果内存没有,.,,我们就从本地里边取,,也需要一个key也就是URL来做唯一文件名字,如果本地有就保存一次到内存,没有就是下载,,下载??我们在operation类里边已经做过了啊,那我们创建那个类,初始化方法就好了,毕竟我们就写了一个方法,,里边需要一个图片参数,,,所以这里这个方法我们还需要一个参数:图片....得到这个后,就放到队列里边,,,,,到这里其实也就结束了,,但是如果我们调用这个方法,那么就需要给URL的时候,还需要给一个UIimageview...感觉怪怪的!...我们其实不是为了用得到的属性值image,在灵活的在外边展示相片么???那我们就在外在创建相框..所以这里就去外边得到,,,也就是外边给,,这里如果就是这样,当然是用户给了,,但是为了我们用,我们可以对UIimageview添加方法,让这个类给我们提供相框!!!!不用想着怎么给的,类别拓展的时候不是给了self么,,一个类都给了,,也就是所有的大小和属性和方法都给了,,相当于这个在别的地方创建UIimageview的时候,也就其实自动有了这个方法的,有了其中的这个参数属性啊,,创建UIimageview,之前得到图片image了..就保存到这个类里边了,,你想显示,直接调用方法就会有了,用相框对象调用,,属性相当于在URL请求的时候就给这个相框类了...所以我们调用的时候都没有打点调用image属性!!!!,,就是布局相框了,,,传个URL,,,就可以显示了...要知道,要显示一定还会有image赋值额,,好厉害!!!居然类别拓展直接给了..就和之前老师说的字典和数据类别封装一样了....属性默认赋值,,默认带上!.....

//下载入口方法
-(void)downloadImgWithUrl:(NSURL*)url
                imageView:(UIImageView*)imageV
{
    //为了安全起见,判断一下url
    if (!url)
    {
        return;
    }
    
    //获取图片的完整逻辑
    //1,从内存中找
    NSString *key = [url.absoluteString base64EncodedString];
    //根据key从缓存中去图片
    UIImage *img = [_imageCache objectForKey:key];
    
    if (img) {
        imageV.image = img;
        return;
    }
    
    
    
    //2,从本地-(保存到内存)
    NSString *filePath = [SuperImageManager getFilePathWithName:key];
    
    //本地取
    img = [UIImage imageWithContentsOfFile:filePath];
    if (img) {
        
        imageV.image = img;
        //放到内存里
        [_imageCache setObject:img forKey:key];
        
        return;
    }
    
    
    
    //3,下载 (保存到内存和本地)
    SuperImageOperation *operation = [[SuperImageOperation alloc]initWithUrl:url imageView:imageV];
    
    //将operation放到队列中,会自动执行
    //开始下载
    [imgQueue addOperation:operation];
}














//获取图片路径
+(NSString*)getFilePathWithName:(NSString*)fileName
{
    //1,你可以创建文件夹
    //2,将所有的文件放入文件夹
    //3,如果要清空缓存,就讲文件夹删除
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *directoryPath = [docPath stringByAppendingPathComponent:@"imageCache"];
    
    //如果,文件夹不存在,创建
    if (![[NSFileManager defaultManager]fileExistsAtPath:directoryPath])
    {
        NSError *error = nil;
        BOOL rs =
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (rs) {
            NSLog(@"创建文件夹成功");
        }
    }

    return [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",fileName]];
}
@end
























