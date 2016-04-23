//
//  DJAppInfo.h
//  4.23下载图片4.23
//
//  Created by 邓金明 on 16/4/23.
//  Copyright © 2016年 邓金明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJAppInfo : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *download;


+(NSArray *)appInfo;

@end
