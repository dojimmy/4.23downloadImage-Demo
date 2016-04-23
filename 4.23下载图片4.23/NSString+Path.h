//
//  NSString+Path.h
//  4.23下载图片4.23
//
//  Created by 邓金明 on 16/4/23.
//  Copyright © 2016年 邓金明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

-(NSString *)appendTemp;

-(NSString *)appendDocuments;

-(NSString *)appendCaches;

@end
