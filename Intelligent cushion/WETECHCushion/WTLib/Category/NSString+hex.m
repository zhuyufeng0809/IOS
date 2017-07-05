//
//  NSString+hex.m
//  lightBLE
//
//  Created by zhanghailong on 15-1-23.
//  Copyright (c) 2015年 zhanghailong. All rights reserved.
//

#import "NSString+hex.h"

@implementation NSString (hex)

- (NSData *)stringToHex:(NSString *)string
{
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (string.length%2 != 0) //长度不是偶数的倍数
    {
        return nil;
    }
    NSUInteger len = string.length/2;
    Byte byte;
    for (NSUInteger i=0; i<len; i++)
    {
        byte = ([self toByte:[string characterAtIndex:2*i]]<<4) + [self toByte:[string characterAtIndex:2*i+1]];
        [data appendBytes:&byte length:1];
    }
    
    return data;

}

//将字符转换为对应的asci值
-(Byte)toByte:(unichar)ch;
{
    if (ch>='a' && ch<='f')
    {
        return ch-'a'+10;
    }
    else if (ch>='A' && ch<='F')
    {
        return ch-'A'+10;
    }
    else if (ch>='0' && ch<='9')
    {
        return ch-'0';
    }
    else
    {
        return 0;
    }
}


@end
