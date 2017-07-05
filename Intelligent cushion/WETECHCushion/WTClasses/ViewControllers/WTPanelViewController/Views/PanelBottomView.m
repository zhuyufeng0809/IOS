//
//  PanelBottomView.m
//  WETECHCushion
//
//  Created by Will Hu on 5/7/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "PanelBottomView.h"
#import "PanelMiddleView.h"

#import "BleDiscovery.h"
#import "BleService.h"
#import "ProgressHUD.h"
#import "NSString+hex.h"


@interface PanelBottomView()<LeDiscoveryDelegate,BleAlarmProtocol>

@property (nonatomic, strong) UIButton *coldButton;
@property (nonatomic, strong) UIButton *warmButton;

@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *autoButton;
@property (nonatomic, strong) UIButton *switchButton;

@property (nonatomic, assign) BOOL bColdButtonOn;
@property (nonatomic, assign) BOOL bWarmButtonOn;
@property (nonatomic, assign) BOOL bAutoButtonOn;
@property (nonatomic, assign) BOOL bSwitchButtonOn;
@property (nonatomic, assign) NSInteger nSetTemperature;

@property (nonatomic, strong) UILabel *temperatureIndicatorLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;

/*----------------------蓝牙相关----------------------*/
@property (nonatomic,strong) BleDiscovery *bleDiscovery;
@property (nonatomic,strong) BleService *bleService;
@property (nonatomic,strong) CBPeripheral *blePeripheral;

@end

@implementation PanelBottomView


#pragma mark - Private properties

- (UIButton*)coldButton
{
    if (!_coldButton) {
        _coldButton = [UIButton new];
        _coldButton.backgroundColor = [UIColor clearColor];
        _coldButton.hidden = NO;
        [_coldButton addTarget:self action:@selector(coldButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOffImage"] forState:UIControlStateNormal];
        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOnImage"] forState:UIControlStateHighlighted];
    }
    return _coldButton;
}

- (UIButton*)warmButton
{
    if (!_warmButton) {
        _warmButton= [UIButton new];
        _warmButton.backgroundColor = [UIColor clearColor];
        _warmButton.hidden = NO;
        [_warmButton addTarget:self action:@selector(warmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOffImage"] forState:UIControlStateNormal];
        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOnImage"] forState:UIControlStateHighlighted];
    }
    return _warmButton;
}

- (UIButton*)decreaseButton
{
    if (!_decreaseButton) {
        _decreaseButton = [UIButton new];
        _decreaseButton.backgroundColor = [UIColor clearColor];
        _decreaseButton.hidden = NO;
        [_decreaseButton addTarget:self action:@selector(decreaseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_decreaseButton setImage:[UIImage imageNamed:@"coldButtonOffImage"] forState:UIControlStateNormal];
        [_decreaseButton setImage:[UIImage imageNamed:@"coldButtonOnImage"] forState:UIControlStateHighlighted];
    }
    return _decreaseButton;
}

- (UIButton*)increaseButton
{
    if (!_increaseButton) {
        _increaseButton = [UIButton new];
        _increaseButton.backgroundColor = [UIColor clearColor];
        _increaseButton.hidden = NO;
        [_increaseButton addTarget:self action:@selector(increaseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_increaseButton setImage:[UIImage imageNamed:@"warmButtonOffImage"] forState:UIControlStateNormal];
        [_increaseButton setImage:[UIImage imageNamed:@"warmButtonOnImage"] forState:UIControlStateHighlighted];
    }
    return _increaseButton;
}

- (UIButton*)autoButton
{
    if (!_autoButton) {
        _autoButton = [UIButton new];
        _autoButton.backgroundColor = [UIColor clearColor];
        _autoButton.hidden = NO;
        [_autoButton addTarget:self action:@selector(autoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOffImage"] forState:UIControlStateNormal];
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOnImage"] forState:UIControlStateHighlighted];
    }
    return _autoButton;
}

- (UIButton*)switchButton
{
    if (!_switchButton) {
        _switchButton = [UIButton new];
        _switchButton.backgroundColor = [UIColor clearColor];
        _switchButton.hidden = NO;
        [_switchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_switchButton setImage:[UIImage imageNamed:@"turnOffImage"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"turnOnImage"] forState:UIControlStateHighlighted];
    }
    return _switchButton;
}

- (UILabel*)temperatureIndicatorLabel
{
    if (!_temperatureIndicatorLabel) {
        _temperatureIndicatorLabel = [UILabel new];
        _temperatureIndicatorLabel.backgroundColor = [UIColor clearColor];
        _temperatureIndicatorLabel.hidden = NO;
        _temperatureIndicatorLabel.text = @"当前设置温度";
        _temperatureIndicatorLabel.textAlignment = NSTextAlignmentCenter;
        _temperatureIndicatorLabel.textColor = [UIColor grayColor];
    }
    return _temperatureIndicatorLabel;
}

- (UILabel*)temperatureLabel
{
    if (!_temperatureLabel) {
        _temperatureLabel = [UILabel new];
        _temperatureLabel.backgroundColor = [UIColor clearColor];
        _temperatureLabel.hidden = NO;
//        _temperatureLabel.text = @"20度";
        _temperatureLabel.textAlignment = NSTextAlignmentCenter;
        _temperatureLabel.textColor = MAIN_BLUE_COLOR;
        _temperatureLabel.font = [UIFont boldSystemFontOfSize:30];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"20\u00b0c"];
        [attributedString setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-light" size:30.0]
                                          , NSBaselineOffsetAttributeName : @0} range:NSMakeRange(2, 2)];
        _temperatureLabel.attributedText = attributedString;
    }
    return _temperatureLabel;
}

#pragma mark - Button Actions

- (void)excecuteCommand:(NSInteger)nCMD Temperature:(NSInteger)temperature
{
    NSString *sendContent = nil;
    NSData *sendData = nil;
    switch (nCMD) {
        case CMD_REVISE_PASW:
            sendContent = @"AA0d01020304050601060504030201";
            break;
        case CMD_TURN_ON:
            sendContent = @"AA0701020304050602";
            break;
        case CMD_INCR_TEMP:
            sendContent = [NSString stringWithFormat:@"AA0801020304050603%@",[[NSString alloc] initWithFormat:@"%2x", (unsigned char)_nSetTemperature]];
            NSLog(@"sendContent is %@, _nSetTemperature is %d", sendContent, (unsigned char)_nSetTemperature);
//            sendContent = @"AA080102030405060319";  // 25度
            break;
        case CMD_DESC_TEMP:
            sendContent = [NSString stringWithFormat:@"AA0801020304050604%@",[[NSString alloc] initWithFormat:@"%2x", (unsigned char)_nSetTemperature]];
//            NSLog(@"sendContent is %@, _nSetTemperature is %d", sendContent, (unsigned char)_nSetTemperature);
//            sendContent = @"AA080102030405060412";  // 18度
            break;
        case CMD_SET_TEMP:
            sendContent = [NSString stringWithFormat:@"AA0801020304050605%@",[[NSString alloc] initWithFormat:@"%2x", (unsigned char)_nSetTemperature]];
//            NSLog(@"sendContent is %@, _nSetTemperature is %d", sendContent, (unsigned char)_nSetTemperature);
//            sendContent = @"AA080102030405060516";  // 22度
            break;
        case CMD_TURN_OFF:
            sendContent = @"AA0701020304050606";
            break;
        default:
            break;
    }
    sendData = [sendContent stringToHex:sendContent];
    if (_bleService)
    {
        NSLog(@"将向蓝牙设备发送命令");
        [_bleService writeValue:sendData];
    }
    else
    {
        NSLog(@"不能向蓝牙设备发送命令");
    }
}

- (void)decreaseButtonPressed:(UIButton*)button
{
//    NSLog(@"decreaseButtonPressed");
    if (!_bSwitchButtonOn) { return; }
    [self excecuteCommand:CMD_DESC_TEMP Temperature:--_nSetTemperature];    // 调高一度
    [self setTemperatureWithType:TEMP_CURRENT_SETTING AndTemperature:_nSetTemperature];
    
    self.bAutoButtonOn = NO;
    [_autoButton setImage:[UIImage imageNamed:@"autoButtonOffImage"] forState:UIControlStateNormal];
    [_autoButton setImage:[UIImage imageNamed:@"autoButtonOnImage"] forState:UIControlStateHighlighted];
}

- (void)increaseButtonPressed:(UIButton*)button
{
    //    NSLog(@"warmButtonPressed");
    if (!_bSwitchButtonOn) { return; }
    [self excecuteCommand:CMD_INCR_TEMP Temperature:++_nSetTemperature];    // 降低一度
    [self setTemperatureWithType:TEMP_CURRENT_SETTING AndTemperature:_nSetTemperature];
    
    self.bAutoButtonOn = NO;
    [_autoButton setImage:[UIImage imageNamed:@"autoButtonOffImage"] forState:UIControlStateNormal];
    [_autoButton setImage:[UIImage imageNamed:@"autoButtonOnImage"] forState:UIControlStateHighlighted];
}

- (void)coldButtonPressed:(UIButton *)button
{
//    NSLog(@"coldButtonPressed");
    if (self.bColdButtonOn)
    {
        self.bColdButtonOn = NO;
        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOffImage"] forState:UIControlStateNormal];
        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOnImage"] forState:UIControlStateHighlighted];
    }
    else
    {
        if (!_bSwitchButtonOn) { return; }
        self.bColdButtonOn = YES;
        [self excecuteCommand:CMD_DESC_TEMP Temperature:18];    // 设置制冷模式的温度
        [self setTemperatureWithType:TEMP_CURRENT_SETTING AndTemperature:18];
        self.bAutoButtonOn = NO;
        self.bWarmButtonOn = NO;
        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOnImage"] forState:UIControlStateNormal];
        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOffImage"] forState:UIControlStateHighlighted];
        
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOffImage"] forState:UIControlStateNormal];
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOnImage"] forState:UIControlStateHighlighted];
        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOffImage"] forState:UIControlStateNormal];
        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOnImage"] forState:UIControlStateHighlighted];
    }
}

- (void)autoButtonPressed:(UIButton *)button
{
//    NSLog(@"autoButtonPressed");
     if (self.bAutoButtonOn)
    {
        self.bAutoButtonOn = NO;
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOffImage"] forState:UIControlStateNormal];
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOnImage"] forState:UIControlStateHighlighted];
    }
    else
    {
        if (!_bSwitchButtonOn) { return; }
        self.bAutoButtonOn = YES;
        _nSetTemperature = 28;
        [self excecuteCommand:CMD_SET_TEMP Temperature:_nSetTemperature]; // 设置恒温
        [self setTemperatureWithType:TEMP_CURRENT_SETTING AndTemperature:_nSetTemperature];
        
//        self.bColdButtonOn = NO;
//        self.bWarmButtonOn = NO;
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOnImage"] forState:UIControlStateNormal];
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOffImage"] forState:UIControlStateHighlighted];
        
//        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOffImage"] forState:UIControlStateNormal];
//        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOnImage"] forState:UIControlStateHighlighted];
//        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOffImage"] forState:UIControlStateNormal];
//        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOnImage"] forState:UIControlStateHighlighted];
    }
}

- (void)warmButtonPressed:(UIButton *)button
{
//    NSLog(@"warmButtonPressed");
    if (self.bWarmButtonOn)
    {
        self.bWarmButtonOn = NO;
        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOffImage"] forState:UIControlStateNormal];
        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOnImage"] forState:UIControlStateHighlighted];
    }
    else
    {
        if (!_bSwitchButtonOn) { return; }
        self.bWarmButtonOn = YES;
        [self excecuteCommand:CMD_INCR_TEMP Temperature:25];    // 设置制热模式的温度
        [self setTemperatureWithType:TEMP_CURRENT_SETTING AndTemperature:25];
        self.bAutoButtonOn = NO;
        self.bColdButtonOn = NO;
        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOnImage"] forState:UIControlStateNormal];
        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOffImage"] forState:UIControlStateHighlighted];
        
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOffImage"] forState:UIControlStateNormal];
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOnImage"] forState:UIControlStateHighlighted];
        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOffImage"] forState:UIControlStateNormal];
        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOnImage"] forState:UIControlStateHighlighted];
    }
}

- (void)switchButtonPressed:(UIButton *)button
{
//    NSLog(@"switchButtonPressed");
    if (self.bSwitchButtonOn)
    {
        self.bSwitchButtonOn = NO;
        [self excecuteCommand:CMD_TURN_OFF Temperature:28];
        [_switchButton setImage:[UIImage imageNamed:@"turnOffImage"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"turnOnImage"] forState:UIControlStateHighlighted];
        
//        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOffImage"] forState:UIControlStateNormal];
//        [_coldButton setImage:[UIImage imageNamed:@"coldButtonOnImage"] forState:UIControlStateHighlighted];
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOffImage"] forState:UIControlStateNormal];
        [_autoButton setImage:[UIImage imageNamed:@"autoButtonOnImage"] forState:UIControlStateHighlighted];
//        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOffImage"] forState:UIControlStateNormal];
//        [_warmButton setImage:[UIImage imageNamed:@"warmButtonOnImage"] forState:UIControlStateHighlighted];
    }
    else
    {
        self.bSwitchButtonOn = YES;
        [self excecuteCommand:CMD_TURN_ON Temperature:28];
        [_switchButton setImage:[UIImage imageNamed:@"turnOnImage"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"turnOffImage"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - Set temperature

- (void)setTemperatureWithType:(NSInteger)nType AndTemperature:(NSInteger)nTemperature
{
    switch (nType) {
        case TEMP_CURRENT_SETTING:
        {
            NSString *temperatureString = [NSString stringWithFormat:@"%ld\u00b0c", (long)nTemperature];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:temperatureString];
            [attributedString setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-light" size:30.0]
                                          , NSBaselineOffsetAttributeName : @0} range:NSMakeRange(2, 2)];
            _temperatureLabel.attributedText = attributedString;
            break;
        }
        case TEMP_CAR:
        {
            [self.middleView setTemperatureWithType:nType AndTemperature:nTemperature];
//            [self.middleView setTemperatureWithType:nType AndTemperature:28];
            break;
        }
        case TEMP_CUSHION:
        {
            [self.middleView setTemperatureWithType:nType AndTemperature:nTemperature];
//            [self.middleView setTemperatureWithType:nType AndTemperature:18];
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - Initialization

/**
 *  初始化蓝牙连接
 */
- (void)initBle
{
    if(_bleDiscovery == nil)
    {
        _bleDiscovery = [BleDiscovery sharedInstance];
        _bleDiscovery.discoveryDelegate = self;
        _bleDiscovery.peripheralDelegate = self;
        [_bleDiscovery startScanning];
        
    }
    else
    {
        [_bleDiscovery startScanning];
    }
}

#pragma mark - <LeDiscoveryDelegate>

//发现了外部设备
- (void)discoveryDidRefresh
{
    NSMutableArray *foundPeripherals =  [_bleDiscovery foundPeripherals];
    CBPeripheral *peripheral = nil;
    
    for (peripheral in foundPeripherals)
    {
        //判断是否是名称为roadguard的Ble外设
        if ([peripheral.name isEqualToString:BLE_NAME_V2] ||
            [peripheral.name isEqualToString:BLE_NAME_V2_2])
        {
            _bleDiscovery.bleType = BLEV2;
            _blePeripheral = peripheral;                    //得到外设
            [_bleDiscovery connectPeripheral:peripheral];   //连接外设
            return;
        }
//        else if ([peripheral.name isEqualToString:BLE_NAME_V1])
//        {
//            _bleDiscovery.bleType = BLEV1;
//            _blePeripheral = peripheral;                    //得到外设
//            [_bleDiscovery connectPeripheral:peripheral];   //连接外设
//            return;
//        }
    }
}

- (void)discoveryStatePoweredOff{ }

#pragma mark - BleAlarmProtocol

- (void)alarmServiceDidReset{}
- (void)alarmServiceDidStopAlarm:(BleService *)service{}

/**
 *  CBPeripheralStateDisconnected = 0,
	CBPeripheralStateConnecting,
	CBPeripheralStateConnected,
 */
- (void)alarmServiceDidChangeStatus:(BleService *)service{
    CBPeripheralState state = [service.servicePeripheral state];
    switch (state) {
        case CBPeripheralStateConnected:
            [ProgressHUD showSuccess:@"已经连接到了智能坐垫" Interaction:YES];
            //启动发现服务，以及特征值
            [service start];
            break;
        case CBPeripheralStateConnecting:
            break;
        case CBPeripheralStateDisconnected:
        {
            NSLog(@"断开了蓝牙连接");
            //在导航栏的右上方显示连接按钮
            //显示导航栏上面的连接按钮
//            UIBarButtonItem *connectBtn = [[UIBarButtonItem alloc] initWithTitle:@"连接设备" style:UIBarButtonItemStylePlain target:self action:@selector(connectBle)];
//            self.navigationItem.rightBarButtonItem = connectBtn;
            
//            if(_isNeedDialog){
//                //提示框提示
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"蓝牙连接已经断开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新连接", nil];
//                [alert show];
//            }
//            else
            {
                //loginout
                //                    [BleDiscovery sharedInstance] = nil;
                [ProgressHUD showSuccess:@"蓝牙连接已经断开" Interaction:YES];
            }
            break;
        }
        default:
            break;
    }
}

- (void)alarmServiceDidFinish:(BleService *)service
{
    [ProgressHUD showSuccess:@"蓝牙初始化完成" Interaction:YES];
    //隐藏导航上面的连接按钮
//    self.navigationItem.rightBarButtonItem = nil;
    //得到服务
    _bleService = service;
}

//接收到数据
- (void)alarmServiceDidChange:(BleService *)service
{
    //拿到接收到的数据
//    NSLog(@"接收到数据");
    NSData *data = [service nofityData];
//    NSLog(@"%@", data);
    //转换成字节数组
    const Byte *byte =  data.bytes;
    
    //获取协议类型
    int nLen = (unsigned char)*(byte + 1);
    int nPRTL = (unsigned char)*(byte + 2);
    unsigned char errorCode = 0;
    unsigned char ucCarTemp = 30;
    unsigned char ucCushionTemp = 20;
    if (nLen == 2)
    {
        errorCode = (unsigned char)*(byte + 3);
    }
    else if(nLen == 3)
    {
        ucCushionTemp = (unsigned char)*(byte + 3);
        ucCarTemp = (unsigned char)*(byte + 4);
    }
    else return ;
//    得到结果字节
//    int b =  (int)*(byte + 3);
    
    if (nPRTL != PRTL_REAL_TEMP)
    {
        NSLog(@"nLen --->%d", nLen);
        NSLog(@"nPRTL --->%d", nPRTL);
        NSLog(@"%@", data);
        NSLog(@"result code is %d", errorCode);
    }
    if (nPRTL == 0) {
            NSLog(@"接收到了实时温度，车内温度为%d, 坐垫温度为%d", ucCarTemp, ucCushionTemp);
        return;
    }
    
    switch (nPRTL)
    {
        case PRTL_REVISE_PASW:
        {
            //修改密码
            switch (errorCode)
            {
                case 1:
                {
                    NSLog(@"密码修改成功");
                    //发送通知
                    NSNotification *notification = [NSNotification notificationWithName:@"changePWok" object:nil];
                    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
                    [notificationCenter postNotification:notification];
                    [ProgressHUD showSuccess:@"密码修改成功" Interaction:YES];
                }
                    return;
                case 2:
                    [ProgressHUD showError:@"原密码错误" Interaction:YES];
                    return;
                case 3:
                    [ProgressHUD showError:@"通讯异常" Interaction:YES];
                    return;
                default:
                    break;
            }
            break;
        }
        case PRTL_TURN_ON: // 开启智能坐垫
        {
            switch (errorCode) {
                case 0x01:
                    [ProgressHUD showSuccess:@"智能坐垫开启成功" Interaction:YES];
                    return;
                case 0x02:
                    [ProgressHUD showError:@"密码错误" Interaction:YES];
                    return;
                case 0x03:
                    [ProgressHUD showError:@"通讯异常" Interaction:YES];
                    return;
                default:
                    break;
            }
            break;
        }
        case PRTL_INCR_TEMP:
        {
            switch (errorCode) {
                case 0x01:
//                    [ProgressHUD showSuccess:@"升温工作开始进行" Interaction:YES];
                    return;
                case 0x02:
                    [ProgressHUD showError:@"密码错误" Interaction:YES];
                    return;
                case 0x03:
                    [ProgressHUD showError:@"通讯异常" Interaction:YES];
                    return;
                default:
                    break;
            }
            break;
        }
        case PRTL_DESC_TEMP:
        {
            switch (errorCode)
            {
                case 0x01:
//                    [ProgressHUD showSuccess:@"降温工作开始进行" Interaction:YES];
                    return;
                case 0x02:
                    [ProgressHUD showError:@"密码错误" Interaction:YES];
                    return;
                case 0x03:
                    [ProgressHUD showError:@"通讯异常" Interaction:YES];
                    return;
                default:
                    break;
            }
            break;
        }
        case PRTL_SET_TEMP:
        {
            switch (errorCode)
            {
                case 0x01:
                    [ProgressHUD showSuccess:@"温度设定成功" Interaction:YES];
                    return;
                case 0x02:
                    [ProgressHUD showError:@"密码错误" Interaction:YES];
                    return;
                case 0x03:
                    [ProgressHUD showError:@"通讯异常" Interaction:YES];
                    return;
                default:
                    break;
            }
            break;
        }
        case PRTL_TURN_OFF:
        {
            switch (errorCode)
            {
                case 0x01:
                    [ProgressHUD showSuccess:@"智能坐垫将关闭" Interaction:YES];
                    return;
                case 0x02:
                    [ProgressHUD showError:@"密码错误" Interaction:YES];
                    return;
                case 0x03:
                    [ProgressHUD showError:@"通讯异常" Interaction:YES];
                    return;
                default:
                    break;
            }
            break;
        }
        case PRTL_REAL_TEMP:
        {
//            NSLog(@"接收到了实时温度，车内温度为%d, 坐垫温度为%d", ucCarTemp, ucCushionTemp);
            [self setTemperatureWithType:TEMP_CAR AndTemperature:ucCarTemp];
            [self setTemperatureWithType:TEMP_CUSHION AndTemperature:ucCushionTemp];
            if (!_bSwitchButtonOn) // 当开关没打开时，将当前坐垫温度设为默认温度
            {
                _nSetTemperature = ucCushionTemp;
                [self setTemperatureWithType:TEMP_CURRENT_SETTING AndTemperature:_nSetTemperature];
            }
            else    // 当开关打开后，“当前设置温度”不受影响
            { }
            break;
       }
        default:
            break;
    }
}

#pragma mark - View lifecycle

- (void)addSubviewTree
{
    [self addSubview:self.coldButton];
    [self addSubview:self.warmButton];
    [self addSubview:self.decreaseButton];
    [self addSubview:self.increaseButton];
    [self addSubview:self.autoButton];
    [self addSubview:self.switchButton];
    self.coldButton.hidden = YES;
    self.warmButton.hidden = YES;
    
    [self addSubview:self.temperatureIndicatorLabel];
    [self addSubview:self.temperatureLabel];
}

- (void)setViewsLayout
{
    NSInteger nTopOffset = 5;
    [self.coldButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(nTopOffset);
        make.left.equalTo(self.left).offset(15);
        
        make.height.equalTo(@(77));
        make.width.equalTo(@(77));
    }];
    
    [self.decreaseButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(nTopOffset);
        make.left.equalTo(self.left).offset(15);
        
        make.height.equalTo(@(77));
        make.width.equalTo(@(77));
    }];
    
    [self.autoButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(nTopOffset);
        make.centerX.equalTo(self.centerX);
        
        make.height.equalTo(@(77));
        make.width.equalTo(@(77));
    }];
    
    [self.warmButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(nTopOffset);
        make.right.equalTo(self.right).offset(-15);
        
        make.height.equalTo(@(77));
        make.width.equalTo(@(77));
    }];
    
    [self.increaseButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(nTopOffset);
        make.right.equalTo(self.right).offset(-15);
        
        make.height.equalTo(@(77));
        make.width.equalTo(@(77));
    }];
    
    [self.temperatureIndicatorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.autoButton.bottom).offset(20);
        make.centerX.equalTo(self.centerX);
        
        make.height.equalTo(@20);
        make.width.equalTo(@120);
    }];
    
    [self.temperatureLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temperatureIndicatorLabel.bottom).offset(10);
        make.centerX.equalTo(self.centerX);
        
        make.height.equalTo(@40);
        make.width.equalTo(@120);
    }];
   
    [self.switchButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temperatureLabel.bottom).offset(-3);
        make.centerX.equalTo(self.centerX);
        
        make.height.equalTo(@(64));
        make.width.equalTo(@(264));
    }];
    
}

- (void)initViews
{
    
    [self setViewsLayout];
    
    self.bColdButtonOn = NO;
    self.bAutoButtonOn = NO;
    self.bWarmButtonOn = NO;
    self.bSwitchButtonOn = NO;
    self.nSetTemperature = 20;
}

- (void)simulateViewDidLoad
{
    [self addSubviewTree];
    [self initViews];
    
    [self initBle];
}


@end
