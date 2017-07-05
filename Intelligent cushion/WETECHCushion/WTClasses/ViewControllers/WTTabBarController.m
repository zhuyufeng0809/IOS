//
//  WTTabBarController.m
//  WETECHCushion
//
//  Created by Will Hu on 5/7/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "WTTabBarController.h"
#import "WTPanelViewController.h"
#import "WTSettingsViewController.h"

#import "TColorfulTabBar.h"
#import "UIColor+STColorInit.h"

@interface WTTabBarController ()

@property (nonatomic, strong)UINavigationController* panelNavigationController;
@property (nonatomic, strong)UINavigationController* settingsNavigationController;

@end

@implementation WTTabBarController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private properties

- (UINavigationController *)panelNavigationController
{
    if (!_panelNavigationController) {
        WTPanelViewController * panelViewController = [[WTPanelViewController alloc] init];
        panelViewController.title = NSLocalizedString(@"智能坐垫",nil);
        panelViewController.tabBarItem.title = @"面板";
        UIImage *tabSeatImage = [self reSizeImage:[UIImage imageNamed:@"tabSeatImage"] toSize:CGSizeMake(30, 30)];
        panelViewController.tabBarItem.image = tabSeatImage;
        _panelNavigationController = [[UINavigationController alloc] initWithRootViewController:panelViewController];
        _panelNavigationController.navigationBar.translucent = NO;
        _panelNavigationController.hidesBottomBarWhenPushed = YES;
    }
    return  _panelNavigationController;
}

- (UINavigationController *)settingsNavigationController
{
    if (!_settingsNavigationController) {
        WTSettingsViewController * settingsViewController = [[WTSettingsViewController alloc] init];
        settingsViewController.title = NSLocalizedString(@"设置",nil);
        settingsViewController.tabBarItem.title = @"设置";
        UIImage *tabSettingsImage = [self reSizeImage:[UIImage imageNamed:@"tabSettingsImage"] toSize:CGSizeMake(30, 30)];
        settingsViewController.tabBarItem.image = tabSettingsImage;
        _settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        _settingsNavigationController.navigationBar.translucent = NO;
        _settingsNavigationController.hidesBottomBarWhenPushed = YES;
    }
    return  _settingsNavigationController;
}

//缩放image
-(UIImage*)reSizeImage:(UIImage *)image toSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //Determine whether the screen is retina
    //When set to 0.0, the scale factor of the main screen is used, which for Retina displays is 2.0 or higher (3.0 on the iPhone 6 Plus).
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//-(void)layoutSubviews{
//    for(UIView *child in self.tabBar.subviews){
//        NSLog(@"for");
//        Class class = NSClassFromString(@"UITabBarButton");
//        if([child isKindOfClass:class]){
//            NSLog(@"if");
//            [child mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.view.mas_left);
//                make.bottom.equalTo(self.view.mas_bottom);
//                
//                make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
//                make.height.equalTo(self.view.mas_height).multipliedBy(0.1);
//            }];
//            //将图层的边框设置为圆脚
//            
//            child.layer.cornerRadius = 8;
//            
//            child.layer.masksToBounds = YES;
//            //给图层添加一个有色边框
//            
//            child.layer.borderWidth = 5;
//            
//            child.layer.borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];
//
//        }
//    }
//}

#pragma mark - Initialization helpers

#pragma mark - tabbarcontroller helpers

- (void)initTabBarController
{
    self.viewControllers = @[
                             self.panelNavigationController,
                             self.settingsNavigationController
                             ];
    self.selectedIndex = 0;
    TColorfulTabBar *tabBar = [[TColorfulTabBar alloc]initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKey:@"tabBar"];
}

@end
