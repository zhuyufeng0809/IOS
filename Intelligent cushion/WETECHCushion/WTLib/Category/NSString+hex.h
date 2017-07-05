//
//  NSString+hex.h
//  lightBLE
//
//  Created by zhanghailong on 15-1-23.
//  Copyright (c) 2015年 zhanghailong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (hex)
- (NSData *)stringToHex:(NSString *)string;
@end
