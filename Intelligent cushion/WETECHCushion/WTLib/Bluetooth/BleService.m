//
//  BleService.m
//  SignTest
//
//  Created by 蔡军伟 on 15/8/17.
//  Copyright (c) 2015年 蔡军伟. All rights reserved.
//

#import "BleService.h"

NSString *kRoadGuardServiceUUIDString        = @"0000ffe0-0000-1000-8000-00805f9b34fb";
NSString *kRoadGuardCharacteristicUUIDString = @"0000ffe1-0000-1000-8000-00805f9b34fb";

@interface BleService()<CBPeripheralDelegate>
{
    CBService *roadGuardService;
    
    CBUUID *rwServiceUUID;
    CBUUID *readCharacteristicUUID;
    CBUUID *writeCharacteristicUUID;
    
    id<BleAlarmProtocol> peripheralDelegate;
}

@property (nonatomic,strong) CBCharacteristic *roadGuardCharacteristic;

@end

@implementation BleService

/****************************************************************************/
/*								初始化方法									*/
/****************************************************************************/
- (id)initWithPeripheral:(CBPeripheral *)peripheral controller:(id<BleAlarmProtocol>)controller  type:(NSInteger)bleType{
    self = [super init];
    if (self) {
        //初始化时传入的外设对象
        _servicePeripheral = peripheral;
        _bleType = bleType;
        //设置代理
        [_servicePeripheral setDelegate:self];
        //外设代理
        peripheralDelegate = controller;
        if (_bleType == BLEV2)
        {
            //初始化Service UUID
            rwServiceUUID = [CBUUID UUIDWithString:BLEV2_SERVICE_UUID];
            //初始化Characteristic 的UUID
            readCharacteristicUUID= [CBUUID UUIDWithString:BLEV2_CHARACT_READ_FROM_PERIPHERAL];
            writeCharacteristicUUID = [CBUUID UUIDWithString:BLEV2_CHARACT_WRITE_TO_PERIPHERAL];
        }
        else if (_bleType == BLEV1)
        {
            //初始化Service UUID
            rwServiceUUID = [CBUUID UUIDWithString:BLEV1_SERVICE_UUID];
            //初始化Characteristic 的UUID
            readCharacteristicUUID= [CBUUID UUIDWithString:BLEV1_CHARACT_READ_FROM_PERIPHERAL];
            writeCharacteristicUUID = [CBUUID UUIDWithString:BLEV1_CHARACT_WRITE_TO_PERIPHERAL];
        }
    }
    return self;
}

- (void)reset{
}

#pragma mark Characteristics Interactions

- (NSData *)nofityData{
    
    NSData *data = nil;
    
//    if (self.roadGuardCharacteristic) {
//       data = [_roadGuardCharacteristic value];
//    }
    if (_bleType == BLEV2)
    {
        CBService * service = [self getService:BLEV2_SERVICE_UUID fromPeripheral:_servicePeripheral];
        CBCharacteristic  * charact = [self getCharacteristic:BLEV2_CHARACT_READ_FROM_PERIPHERAL fromService:service];
        data = [charact value];
    }
    else if (_bleType == BLEV1)
    {
        CBService * service = [self getService:BLEV1_SERVICE_UUID fromPeripheral:_servicePeripheral];
        CBCharacteristic  * charact = [self getCharacteristic:BLEV1_CHARACT_READ_FROM_PERIPHERAL fromService:service];
        data = [charact value];
    }
    
    return data;
}

-(CBService *)getService:(NSString *)serviceID fromPeripheral:(CBPeripheral *)peripheral
{
    CBUUID *uuid = [CBUUID UUIDWithString:serviceID];
    
    for (NSUInteger i=0; i<peripheral.services.count; i++) {
        CBService *service = [peripheral.services objectAtIndex:i];
        if ([service.UUID isEqual:uuid]) {
            return service;
        }
    }
    
    return nil;
}

-(CBCharacteristic *)getCharacteristic:(NSString *)characteristicID fromService:(CBService *)service
{
    CBUUID *uuid = [CBUUID UUIDWithString:characteristicID];
    
    for (NSUInteger i=0; i<service.characteristics.count; i++) {
        CBCharacteristic *characteristic = [service.characteristics objectAtIndex:i];
        if ([characteristic.UUID isEqual:uuid]) {
            return characteristic;
        }
    }
    
    return nil;
}

/**
 *  写数据
 *  To be deleted.
 *
 *  @param bytes
 */
- (void)writeToPeripheral:(Byte[]) bytes length:(NSUInteger)length
{
    NSData *data = nil;
    if (!_servicePeripheral) {
        NSLog(@"Not connected to a peripheral");
        return;
    }
    
    NSLog(@"self.roadGuardCharacteristic --UUID -->%@",[self.roadGuardCharacteristic UUID]);
    
    if (! self.roadGuardCharacteristic) {
        NSLog(@"No valid roadGuard characteristic");
        return;
    }
    data = [NSData dataWithBytes:bytes length:length];
    if (_bleType == BLEV2)
    {
        [self writeValue:data];
        return;
    }
    
    //    int16_t value	= (int16_t)35;
    CBService * service = [self getService:BLEV1_SERVICE_UUID fromPeripheral:_servicePeripheral];
    CBCharacteristic  * characteristic = [self getCharacteristic:BLEV1_CHARACT_WRITE_TO_PERIPHERAL fromService:service];
    
    
    [_servicePeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
    //[self.servicePeripheral writeValue:data forCharacteristic:self.roadGuardCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (void)writeValue:(NSData *)sendData // peripher:(CBPeripheral *)p
{
    if (!_servicePeripheral) {
        NSLog(@"Not connected to a peripheral");
        return;
    }
    CBService * service = nil;
    CBCharacteristic  * charact = nil;
    if (_bleType == BLEV2)
    {
        service = [self getService:BLEV2_SERVICE_UUID fromPeripheral:_servicePeripheral];
        charact = [self getCharacteristic:BLEV2_CHARACT_WRITE_TO_PERIPHERAL fromService:service];
    }
    else if (_bleType == BLEV1)
    {
        service = [self getService:BLEV1_SERVICE_UUID fromPeripheral:_servicePeripheral];
        charact = [self getCharacteristic:BLEV1_CHARACT_WRITE_TO_PERIPHERAL fromService:service];
    }
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    Byte nGroup = sendData.length/20;
    if (sendData.length%20 != 0)
    {
        nGroup ++;
    }
    
//    _sendCount = nGroup;
    for (int i=0; i<nGroup; i++)
    {
        [data setLength:0];
        if (i == (nGroup -1))
        {
            [data appendBytes:sendData.bytes+i*20 length:sendData.length%20];
        }
        else
        {
            [data appendBytes:sendData.bytes+i*20 length:20];
        }
        NSLog(@"%@",data);
        [_servicePeripheral writeValue:data forCharacteristic:charact type:CBCharacteristicWriteWithResponse];
    }
}

#pragma mark - Service Interaction
/****************************************************************************/
/*							Service Interactions							*/
/****************************************************************************/
- (void)start{
    //构造service的UUID
    CBUUID *serviceUUID = nil;
    if (_bleType == BLEV2)
    {
        serviceUUID = [CBUUID UUIDWithString:BLEV2_SERVICE_UUID];
    }
    else if (_bleType == BLEV1)
    {
        serviceUUID = [CBUUID UUIDWithString:BLEV1_SERVICE_UUID];
    }
    //启动发现服务
    NSArray *serviceArray = [NSArray arrayWithObjects:serviceUUID, nil];
    [_servicePeripheral discoverServices:serviceArray];
}

//发现了服务之后的回调方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSArray *services = nil;
//    NSArray *uuids = [NSArray arrayWithObjects:readCharacteristicUUID, writeCharacteristicUUID, nil];
    if (peripheral != _servicePeripheral)
    {
        NSLog(@"Wrong Peripheral.");
        return;
    }
    if (error != nil)
    {
        NSLog(@"Error %@",error);
        return;
    }
    services = [peripheral services];
    NSLog(@"SERVICE COUNT-->%ld",services.count);
    if (!services || ![services count]) { return; }
    
    roadGuardService = nil;
    //寻找是否有符合的UUID
    for (CBService *service in services) {
        NSLog(@"found uuid string is %@", service.UUID.UUIDString);
        if ([[service UUID].UUIDString isEqualToString:BLEV2_SERVICE_UUID] || [[service UUID].UUIDString isEqualToString:BLEV1_SERVICE_UUID]) //  || [[service UUID].UUIDString isEqualToString:@"FFE0"] )
        {
            //找到了匹配的服务
            roadGuardService = service;
            NSLog(@"找到了匹配的服务");
            break;
        }
    }
    
    if(roadGuardService){
        //接下来寻找Characteristics
//        [peripheral discoverCharacteristics:uuids forService: roadGuardService];
        [peripheral discoverCharacteristics:nil forService: roadGuardService];
    }
}

//发现了Characteristic
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    //得到所有Characteristics
    NSArray *characteristics = [service characteristics];
    NSLog(@"特征值的数量--->%ld" ,characteristics.count);
    CBCharacteristic *characteristic = nil;
    
    if (peripheral != _servicePeripheral) { NSLog(@"Wrong Peripheral."); }
    
    if (service != roadGuardService) { NSLog(@"Wrong Service."); }
    if (error != nil) { NSLog(@"Error"); }
    
    //查找我们需要的Characteristics
    for (characteristic in characteristics)
    {
        NSLog(@"discovered characteristic %@",[characteristic UUID]);
        NSLog(@"discovered characteristic %lu",(unsigned long)[characteristic properties]);
        
        if (_bleType == BLEV2)
        {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BLEV2_CHARACT_READ_FROM_PERIPHERAL]])
            {
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                //[peripheral readRSSI];
            }
            
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BLEV2_CHARACT_WRITE_TO_PERIPHERAL]])
            {
                //到此为止蓝牙初始化成功
                [peripheralDelegate alarmServiceDidFinish:self];
                self.roadGuardCharacteristic = characteristic;
                //[peripheral readValueForCharacteristic:c];
            }
            
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BLEV2_CHARACT_CONFIG]])
            {
                //[_peripheral readRSSI];
            }
        }
        else if(_bleType == BLEV1)
        {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BLEV1_CHARACT_READ_FROM_PERIPHERAL]])
            {
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                //[peripheral readRSSI];
            }
            
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BLEV1_CHARACT_WRITE_TO_PERIPHERAL]])
            {
                //到此为止蓝牙初始化成功
                [peripheralDelegate alarmServiceDidFinish:self];
                self.roadGuardCharacteristic = characteristic;
                //[peripheral readValueForCharacteristic:c];
            }
        }
       
//        if ([[characteristic UUID] isEqual:rwCharacteristicUuid]) {
//            self.roadGuardCharacteristic = characteristic;
//            
//            [_servicePeripheral readValueForCharacteristic:characteristic];
//            [_servicePeripheral setNotifyValue:YES forCharacteristic:characteristic];
//            
//            //到此为止蓝牙初始化成功
//            [peripheralDelegate alarmServiceDidFinish:self];
//            
//            return;
//        }
    }
}

/****************************************************************************/
/*						Characteristics Interactions						*/
/****************************************************************************/

/**
 *  收到数据
 *
 *  @param peripheral
 *  @param characteristic
 *  @param error
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if(peripheral != _servicePeripheral)
    {
        NSLog(@"Wrong peripheral.");
        return;
    }
    
    if ([error code] != 0)
    {
        NSLog(@"Error %@\n",error);
        return;
    }
    
//    if ([[characteristic UUID] isEqual:rwCharacteristicUuid]) {
    if ([[characteristic UUID].UUIDString isEqualToString:BLEV2_CHARACT_READ_FROM_PERIPHERAL] || [[characteristic UUID].UUIDString isEqualToString:BLEV1_CHARACT_READ_FROM_PERIPHERAL])
    {
        [peripheralDelegate alarmServiceDidChange:self];
        return;
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
}

/**
 *  写数据完成
 *
 *  @param peripheral
 *  @param characteristic
 *  @param error
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        NSLog(@"error-->%@",[error localizedDescription]);
    }
    
    //NSUInteger length =  [[characteristic value] length];
    
    NSLog(@"发送完成");
    //[peripheral readValueForCharacteristic:characteristic];
}

@end