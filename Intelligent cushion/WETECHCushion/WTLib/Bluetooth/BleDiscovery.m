//
//  BleDiscovery.m
//  SignTest
//
//  Created by 蔡军伟 on 15/8/16.
//  Copyright (c) 2015年 蔡军伟. All rights reserved.
//

#import "BleDiscovery.h"


@interface BleDiscovery()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    CBCentralManager *centralManager;
}

@end

@implementation BleDiscovery

/****************************************************************************/
/*									Init									*/
/****************************************************************************/
+ (BleDiscovery *)sharedInstance{
    //保证该对象只实例化一次
    static BleDiscovery *this = nil;
    if ( !this ) {
        this = [[BleDiscovery alloc] init];
    }
    return  this;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
        _foundPeripherals = [[NSMutableArray alloc] init];
        _connectedServices = [[NSMutableArray alloc] init];
        _bleType = BLEV2;
    }
    return  self;
}

/****************************************************************************/
/*									discovery				     			*/
/****************************************************************************/

//启动扫描指定UUID的服务
- (void)startScanningForUUIDString:(NSString *)uuidString
{
//    NSLog(@"startScanningForUUIDString, uuidString is %@", uuidString);
//    NSArray *uuidArray = [NSArray arrayWithObjects:[CBUUID UUIDWithString:uuidString], nil];
    NSArray *uuidArray = [NSArray arrayWithObjects:nil, nil];
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    [centralManager scanForPeripheralsWithServices:uuidArray options:options];
    //[centralManager scanForPeripheralsWithServices:nil options:options];
}

//停止扫描
- (void)stopScanning{
    [centralManager stopScan];
}

- (void)startScanning{
    [self startScanningForUUIDString:kRoadGuardServiceUUIDString];
}

/**
 *  发现了外部BLE设备
 *
 *  @param central
 *  @param peripheral  外部设备
 *  @param advertisementData  广播信息
 *  @param RSSI              信号强度
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSLog(@"(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral: %@", peripheral);
    if( ![_foundPeripherals containsObject:peripheral])
    {
        [_foundPeripherals addObject:peripheral];
        [_discoveryDelegate discoveryDidRefresh];
    }
}

/****************************************************************************/
/*					Connection/Disconnection				     			*/
/****************************************************************************/

//连接外设
- (void)connectPeripheral:(CBPeripheral *)peripheral{
    if ([peripheral state] != CBPeripheralStateConnected) {
        [centralManager connectPeripheral:peripheral options:nil];
    }
}

//断开连接
- (void)disconnectPeripheral:(CBPeripheral *)peripheral{
    [centralManager cancelPeripheralConnection:peripheral];
}

//BLE连接上之后的回调方法
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral");
    BleService *service = nil;
    
    service = [[BleService alloc] initWithPeripheral:peripheral controller:_peripheralDelegate type:_bleType];
    //启动发现服务
    //[service start];
    
    if(![_connectedServices containsObject:service]){
        [_connectedServices addObject:service];
    }
    
    if ([_foundPeripherals containsObject:peripheral]) {
        [_foundPeripherals removeObject:peripheral];
    }
    
    [_peripheralDelegate alarmServiceDidChangeStatus:service];
    [_discoveryDelegate discoveryDidRefresh];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"Attempted connection to peripheral %@ failed: %@", [peripheral name], [error localizedDescription]);
}

/**
 *  断开连接
 *  @param central
 *  @param peripheral
 *  @param error
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    BleService *service = nil;
    for (service in _connectedServices) {
        if ([service servicePeripheral] == peripheral) {
            [_connectedServices removeObject:service];
            [_peripheralDelegate alarmServiceDidChangeStatus:service];
            break;
        }
    }
    
    [_discoveryDelegate discoveryDidRefresh];
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    static CBCentralManagerState previousState = -1;
    switch ([centralManager state]) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"BLE关掉了");
            break;
        case CBCentralManagerStateUnauthorized:
            /*Tell user the app is not allowed*/
            break;
        case CBCentralManagerStateUnknown:
            /* Bad news, let's wait for another event. */
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"蓝牙已经打开");
//            //开始扫描
            if (self.bleType == BLEV2)
            {
                [self startScanningForUUIDString:BLEV2_SERVICE_UUID];
            }
            else if (self.bleType == BLEV1)
            {
                [self startScanningForUUIDString:BLEV1_SERVICE_UUID];
            }
            break;
        case CBCentralManagerStateResetting:
            break;
        default:
            break;
    }
    previousState = [centralManager state];
}

@end
