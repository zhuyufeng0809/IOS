//
//  BlePassord.m
//  RoadGuard
//
//  Created by 蔡军伟 on 15/8/21.
//  Copyright (c) 2015年 wingteck. All rights reserved.
//

#import "BlePassord.h"

@implementation BlePassord

+ (id)sharedInstance{
    //保证该对象只实例化一次
    static BlePassord *this = nil;
    if ( !this ) {
        this = [[BlePassord alloc] init];
    }
    return  this;
}

//在init方法中读取密码
- (instancetype)init{
    self = [super init];
    if (self ) {
        NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
        NSString *blepassword =  [userDefaults stringForKey:@"blepassword"];
        
        NSLog(@"BLEpassowrd is %@",blepassword);
        
        NSInteger senselevel = [userDefaults integerForKey:@"senselv"];
        if (blepassword == nil) {
            _blepassword = @"000000";
        }else{
            _blepassword = blepassword;
        }
        
        _senselevel = senselevel;
        
        //注册通知
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(updatepassword) name:@"updateBlePassword" object:nil];
        [notificationCenter addObserver:self selector:@selector(updatepassword) name:@"updateBleSenseLevel" object:nil];
    }
    return self;
}

- (void)updatepassword{
    NSLog(@"密码发生了改变");
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    _blepassword =  [userDefaults stringForKey:@"blepassword"];
}

- (void)updatesense{
    
    NSLog(@"灵敏度发生了改变");
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    _senselevel =  [userDefaults integerForKey:@"senselv"];
}

@end