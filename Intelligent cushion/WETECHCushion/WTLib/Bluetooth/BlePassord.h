//
//  BlePassord.h
//  RoadGuard
//
//  Created by 蔡军伟 on 15/8/21.
//  Copyright (c) 2015年 wingteck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlePassord : NSObject

@property (nonatomic,readonly) NSString *blepassword;
@property (nonatomic) NSInteger senselevel;
@property (nonatomic) NSInteger userChooseSenseLv;


+ (id)sharedInstance;

- (void)updatesense;
- (void)updatepassword;


@end
