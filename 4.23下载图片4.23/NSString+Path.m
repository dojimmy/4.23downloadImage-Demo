//
//  NSString+Path.m
//  4.23下载图片4.23
//
//  Created by 邓金明 on 16/4/23.
//  Copyright © 2016年 邓金明. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

-(NSString *)appendTemp{

    NSString *path = NSTemporaryDirectory();
    
    NSString *fileName = [self lastPathComponent];
    
    return [path stringByAppendingPathComponent:fileName];
}

-(NSString *)appendDocuments{

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *fileName = [self lastPathComponent];
    
    return [path stringByAppendingPathComponent:fileName];
    
}

-(NSString *)appendCaches{

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *fileName = [self lastPathComponent];
    
    return [path stringByAppendingPathComponent:fileName];
}

@end
