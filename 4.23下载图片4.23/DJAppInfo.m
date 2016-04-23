//
//  DJAppInfo.m
//  4.23下载图片4.23
//
//  Created by 邓金明 on 16/4/23.
//  Copyright © 2016年 邓金明. All rights reserved.
//

#import "DJAppInfo.h"

@implementation DJAppInfo

+(NSArray *)appInfo{

    NSArray *dicArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
    
    NSMutableArray *desArr = [NSMutableArray array];
    
    [dicArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        DJAppInfo *app = [DJAppInfo appInfoWithDic:obj];
        [desArr addObject:app];
    }];
    
    return desArr;
}


+(instancetype)appInfoWithDic:(NSDictionary *)dic{

    DJAppInfo *app = [[DJAppInfo alloc] init];
    
    [app setValuesForKeysWithDictionary:dic];
    
    return app;
}

@end
