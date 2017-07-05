//
//  BleDiscovery.h
//  SignTest
//
//  Created by 蔡军伟 on 15/8/16.
//  Copyright (c) 2015年 蔡军伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BleService.h"

//UI Protocol

@protocol LeDiscoveryDelegate <NSObject>

- (void) discoveryDidRefresh;
- (void) discoveryStatePoweredOff;

@end

@interface BleDiscovery : NSObject

//获取实例
+ (BleDiscovery *)sharedInstance;

@property (nonatomic,assign) id<LeDiscoveryDelegate> discoveryDelegate;
@property (nonatomic, assign) id<BleAlarmProtocol>	peripheralDelegate;
@property (nonatomic, assign) NSInteger	bleType;

/****************************************************************************/
/*							      Actions				        			*/
/****************************************************************************/
//- (void)startScanningForUUIDString:(NSString *)uuidString;
- (void)stopScanning;
- (void)connectPeripheral:(CBPeripheral *)peripheral;
- (void)disconnectPeripheral:(CBPeripheral *)peripheral;
- (void)startScanning;


/****************************************************************************/
/*							              获取设备							*/
/****************************************************************************/
@property (retain, nonatomic) NSMutableArray    *foundPeripherals;
@property (retain, nonatomic) NSMutableArray	*connectedServices;

@property (nonatomic) BOOL hasLoginout;

@end
