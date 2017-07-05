//
//  BleService.h
//  SignTest
//
//  Created by 蔡军伟 on 15/8/17.
//  Copyright (c) 2015年 蔡军伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


//#define BLEV1_SERVICE_UUID                  @"0000ffe0-0000-1000-8000-00805f9b34fb"
//#define BLEV1_CHARACT_WRITE_TO_PERIPHERAL   @"0000ffe1-0000-1000-8000-00805f9b34fb"
//#define BLEV1_CHARACT_READ_FROM_PERIPHERAL  @"0000ffe1-0000-1000-8000-00805f9b34fb"
#define BLEV1_SERVICE_UUID                  @"FFE0"
#define BLEV1_CHARACT_WRITE_TO_PERIPHERAL   @"FFE1"
#define BLEV1_CHARACT_READ_FROM_PERIPHERAL  @"FFE1"

#define BLEV2_SERVICE_UUID                  @"FFF0"
#define BLEV2_CHARACT_WRITE_TO_PERIPHERAL   @"FFF2"
#define BLEV2_CHARACT_READ_FROM_PERIPHERAL  @"FFF1"
#define BLEV2_CHARACT_CONFIG  @"FFF3"
#define MAIN_UUID           @"FFF1"
#define CENTERDATA_UUID     @"FFF2"
#define CONFIG_UUID         @"FFF3"

#define BLEV1   1
#define BLEV2   2

//#define BLE_NAME_V1   @"RoadGuard"
//#define BLE_NAME_V2   @"Guard"
#define BLE_NAME_V2   @"wetech cushion v1"
#define BLE_NAME_V2_2   @"wetech cushion v1"

#define CMD_REVISE_PASW 1
#define CMD_TURN_ON     2
#define CMD_TURN_OFF    3
#define CMD_INCR_TEMP   4
#define CMD_DESC_TEMP   5
#define CMD_SET_TEMP    6

#define PRTL_REVISE_PASW 0x01
#define PRTL_TURN_ON     0x02
#define PRTL_TURN_OFF    0x06
#define PRTL_INCR_TEMP   0x03
#define PRTL_DESC_TEMP   0x04
#define PRTL_SET_TEMP    0x05
#define PRTL_REAL_TEMP   0x07

/****************************************************************************/
/*						Service Characteristics								*/
/****************************************************************************/
//NSString *kRoadGuardUUIDString;
extern NSString *kRoadGuardServiceUUIDString ;
extern NSString *kRoadGuardCharacteristicUUIDString;

@class BleService;

@protocol BleAlarmProtocol <NSObject>

- (void)alarmServiceDidStopAlarm:(BleService *)service;
- (void)alarmServiceDidChange:(BleService *)service;
- (void)alarmServiceDidChangeStatus:(BleService *)service;
- (void)alarmServiceDidReset;
- (void)alarmServiceDidFinish:(BleService *)service;

@end

@interface BleService : NSObject

@property (readonly)CBPeripheral *servicePeripheral;
@property (readonly) NSData *nofityData;
@property (nonatomic, assign) NSInteger	bleType;

- (id)initWithPeripheral:(CBPeripheral *)peripheral controller:(id<BleAlarmProtocol>)controller type:(NSInteger)bleType;
- (void)reset;
- (void)start;
- (void)writeToPeripheral:(Byte[]) bytes length:(NSUInteger)length;
/**
 *  writeValue:peripher:
 *
 *  @param sendData 要发送的数据
 *  @param p        外设数据
 */
- (void)writeValue:(NSData *)sendData; //  peripher:(CBPeripheral *)p ;

-(CBService *)getService:(NSString *)serviceID fromPeripheral:(CBPeripheral *)peripheral;

@end
