//
//  ViewController.m
//  SuperWebImage
//
//  Created by SuperWang on 16/5/13.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+SuperImage.h"
#import "SuperImageOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.frame = self.view.frame;
    [self.view addSubview:imageV];
    
    //SuperImageOperation*sdasd=[SuperImageOperation alloc]initWithUrl:<#(NSURL *)#> imageView:<#(UIImageView *)#>;
    
    //self.tabBarController.tabBar.hidden
    
    [imageV setImageWithUrl:[NSURL URLWithString:@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1294075540,3067966563&fm=80"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
