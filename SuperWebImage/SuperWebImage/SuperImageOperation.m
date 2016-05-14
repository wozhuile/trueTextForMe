//
//  SuperImageOperation.m
//  SuperWebImage
//
//  Created by SuperWang on 16/5/13.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import "SuperImageOperation.h"
#import "SuperImageManager.h"
#import "Base64.h"
//扩展- 一般用于私有化类的属性和方法
@interface SuperImageOperation ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSURL *imgUrl;
@end

@implementation SuperImageOperation
//初始化方法
-(id)initWithUrl:(NSURL*)url imageView:(UIImageView*)imgView
{
    self = [super init];
    if (self) {
        //在初始化的时候赋值
        _imgUrl = url;
        _imageView = imgView;
    }
    return self;
    
}
//自定义operation的子类,必须重新main函数,操作处理代码在main函数中执行

//operation要执行的任务
#pragma mark 1,这个方法是operation的,也会自动的调用,这是内部系统的机制,不用担心什么时候调用,也不用担心是上边初始化先调用还是这里先调用,我们看赋值等效果或者看一个类,一般来说,都是先用初始化方法猜到其他属性或者方法.我们这里也可以按照赋值逻辑来说先是初始化再到这里.为什么说赋值效果呢??我们看main方法里边.需要两个属性来赋值或者说保存值,我们都知道不说什么先,首先我们要操作的对象就是图片,这图片还是我们从网络上请求得到的,为什么就用这个办法而不是在向服务器请求??那其实没必要也差不多一样的,向服务器请求大多还不是给我们返回一个URL..直接以URL形式返回的...这样我们就先得到第一个方法代码,就数据源!!!至于那个参数URL,我们先不理也行的,也就是先搭建粗糙的基本框架,得到data,为什么就是data??我们客户端和服务器交流,就都是二进制的数据,也就是计算机就识别1和0,,data得到,就可以转换成图片了,得到图片我们一般要干什么??我们目的不就是展示图片么??好,我们就在这里展示.本质本来就是在这里展示的啊,但是问题来了.我们用的是operation,(之所以用这个,也是做到后边知道我们要得到的对象很多,反正卡死线程等原因,所以就创建这个operation来创建分线程),用到这个类,就会创建分线程,请求图片等也是在分线程啊,,我们就考虑到不要在分线程里边刷新.那怎么办??我们也在这里创建分线程?不行,我们要回到分线程里边去写的,那写出来了分线程,直接创建UIimageview来展示啊不行么??可以!!但是有个问题,那就是创建和展示可以了.我们不单单是一个相片,如果在这里创建对象,那不是请求一个图片就创建一个对象???那不行啊..现在操作就方法和属性,,我们回主线程都回了,,也就是方法都试试了,还有属性!!!属性可以保留值!!!我们像那个微博里边cell一样,我们得到属性值,然后在哪里创建UIimageview对象都可以,主要有image属性赋值!!!那这里我们就这样干,创建属性来保留值,然后想在外边哪里创建对象,大小怎么样都可以由你来的啊.,所以我们就创建属性来记录值,然后在外边创建这个类对象,调用属性,相当于记录值并传值了啊..URL也是一样的,我们最后还是要通过外部赋值的,我们也可以创建一个URL属性来记录值,我们怎么去取值??要么外边属性传值,要么方法参数在外边赋值,在这里我们第三方,就不需要用属性去外边取值了..那就不方便不简洁了啊,,所以我们考虑方法参数,,那重新写一个方法??不需要,我们可以吧刚刚声明的两个属性都在初始化的时候赋值啊!!我们要在外边创建对象的,直接在初始化的时候,吧需要的值写成参数就可以了.而且我们还可以在初始化的时候赋值给属性,这样,我们在外边得到的值,也就保留到属性里边, URL就可以给data哪里赋值了,我们也可以我们得到的图片给赋值给属性了.这里初始化带着这个图片真不好理解,但是看调用,其实最后就是把图片类别那个图片给这里了,后边会看到的,,也其实就保留到属性里边了,那属性里边得到的图片,就会可以到外边创建UIimageview后调用属性image后展示,(其实这个属性是相框,而不是真正的图片.我们是吧属性值传给相片保留了,初始化的时候其实就是创建相框一样而不是相片,初始化就是一开始先创建一个相框来接受下相片,保留下,),属性得到值保留值了,我们需要的都得到了.那我们就可以回主线程展示,,然后就是缓存到内存(数组字典NScache等容器类,自动保留到内存中,程序退出就会释放了,内存里边找到也比本地块,原因可以看到,我们就在内存里边,但是本地还需要路径啊什么的,我们拉一个文件到字段看路径,,如果在桌面还快写,如果文件夹里边还是文件夹,,,10多个,,找都要时间,,就可以看到内存不要路径的会快),缓存到内存我们选择NSCache,,本质就是在这里保存就可以,看下边我也写了本质,本来也是这样的,但是我们想,我们缓存就单单在这里类里边用么?就一个类里边会需要图片缓存等么??不一定,还有就是我们创建的是第三方啊,也就是导入其他工程也可以用的,,怎么办??我们可以创建单例类!!!对象就一个啊!!然后我们把这个NSCache声明称单例类属性,可以看看窗口类,然后单例类对象调用NSCache属性,因为这个属性还是类,所以也就还可以调用它本来的属性和方法,比如cell.textLabel.text..绝对是cell类里边声明了一个UILabel的属性,名字 是textLabel,,,窗口那个也一样,,,我们创建单例类得到单一的对象,调用属性,就可以在调用NSCache属性和方法了啊...还是可以直接保存到本地!!,,可以用writeToFile方法,,但是需要一个路径,,也不怕,,路径也是可能在其他地方都用到,比如我们第二阶段项目不就是这样么??我们用到的动画和路径的类封装,,这里我们还是可以用单例类的,,,在里边封装一个方法,,,需要传递参数么??可以也需要,我们要明白,我们保持到文件件里边,每个文件路径是不一样的,都是唯一的,没见我们创建文件或者文件夹都不能重复么??我们就给个唯一的路径!!在这里什么可以唯一呢??也要在保持到本地的key一样,,什么唯一??URL!!!!!!我们路径参数,就要字符串,,调用的时候就要URL来做文件唯一名字....路径要拼接,,得到路径了我们就保存了..保存value是data,key是URL..为什么value是data??我们其实也可以保留图片的,反正保留什么都可以,就看取出来的时候那个方便些.....保存好后,,,这个线程的路径就做好了...我们就想?第二次点击后我们这么做好点??先判断!!!为什么不在这里写??不在这个类里边写呢??不知道了..我们为了第三方,就需要接口,,,感觉应该也可以在这个类里边写,,是不是又是不单单用一次??..不懂就算先了...我们先按照逻辑去看...
-(void)main
{
    //1,下载
    NSData *imgData = [NSData dataWithContentsOfURL:self.imgUrl];
    
    UIImage *image = [UIImage imageWithData:imgData];
    
#pragma mark 本来本质就是应该在这里展示的,
    //UIImageView*asda=[[UIImageView  alloc]init];
    
    
    
    
    
    
    
    
    
    
    //2,更新UI-回主线程更新
    if (image)
    {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //本质可以在这里写,效果就是得到一个请求图片就创建一次图片,不方便安排也栈内存
            //UIImageView*asda=[[UIImageView  alloc]init];

         self.imageView.image = image;
        });
    }
    
    
    //3,缓存在内存,缓存在本地
    //使用NSCache ,放在单例里面
    NSCache*asdas=[[NSCache alloc]init];
    
    //asdas setObject:]; forKey:<#(id)#>
    //SuperImageManager*sdasd=[SuperImageManager sharedManager];
   //sdasd.imageCache setObject:<#(id)#> forKey:<#(id)#>
    

    
    
    //使用base64编码,规避url中的特殊符号
    NSString *key = [self.imgUrl.absoluteString base64EncodedString];
    
    //缓存图片到内存
    [[SuperImageManager sharedManager].imageCache setObject:image forKey:key];
    
    
    
    
   // [imgData writeToFile:<#(NSString *)#> atomically:<#(BOOL)#>];
    
    
    
    //保存到本地
    //原子性
    //某一个行为过程,如果中途被终止,这个行为会恢复到最原始的状态.
    BOOL rs =
    [imgData writeToFile:[SuperImageManager getFilePathWithName:key] atomically:YES];
    
    
    if (rs) {
        NSLog(@"文件写入成功!");
    }
    else
    {
        NSLog(@"文件写入失败!");
    }
    
    
}




@end












