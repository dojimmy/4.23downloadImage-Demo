//
//  ViewController.m
//  4.23下载图片4.23
//
//  Created by 邓金明 on 16/4/23.
//  Copyright © 2016年 邓金明. All rights reserved.
//

#import "ViewController.h"
#import "DJAppInfo.h"
#import "DJAppCell.h"
#import "NSString+Path.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *appInfos;

@property (nonatomic,strong) NSOperationQueue *queue;

//保存图片到内存中
@property (nonatomic,strong) NSMutableDictionary *appPicDic;


//操作缓存，判断是否正在下载
@property (nonatomic,strong) NSMutableDictionary *opCaches;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.appInfos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DJAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"app" forIndexPath:indexPath];
    
    DJAppInfo *appInfo = self.appInfos[indexPath.row];
    cell.nameLabel.text = appInfo.name;
    cell.downloadLabel.text = appInfo.download;
    cell.iconView.image = [UIImage imageNamed:@"user_default"];
    

    //内存取图片
    if ([self.appPicDic objectForKey:appInfo.icon]) {
        NSLog(@"内存取图片");
        cell.iconView.image = [self.appPicDic objectForKey:appInfo.icon];
        return cell;
    }
    
    //沙盒取图片
    NSString *path = [appInfo.icon appendCaches];

    UIImage *image = [UIImage imageWithContentsOfFile:path];

    if (image) {

        cell.iconView.image = image;
        
        [self.appPicDic setObject:image forKey:appInfo.icon];
        NSLog(@"缓存取图片");
        return cell;
    }
    
    [self downloadImageWithindexPath:indexPath];


    return cell;
}


-(void)downloadImageWithindexPath:(NSIndexPath *)indexPath{

    DJAppInfo *appInfo = self.appInfos[indexPath.row];
    
    if ([self.opCaches objectForKey:appInfo.icon]) {
        NSLog(@"正在下载");
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    //下载图片
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"下载图片");
        
        NSURL *url = [NSURL URLWithString:appInfo.icon];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        if (data) {
            //写到沙盒目录
            [data writeToFile:[appInfo.icon appendCaches] atomically:YES];
        }
        
        UIImage *image = [UIImage imageWithData:data];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            if (image) {
                //保存到内存--字典
                [weakSelf.appPicDic setObject:image forKey:appInfo.icon];
                
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
            
            [weakSelf.opCaches removeObjectForKey:appInfo.icon];
        }];
    }];
    
    
    [self.queue addOperation:op];
    
    [self.opCaches setObject:op forKey:appInfo.icon];
    
}

-(void)dealloc{

    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self.appPicDic removeAllObjects];
    [self.queue cancelAllOperations];
    [self.opCaches removeAllObjects];
}

-(NSMutableDictionary *)opCaches{

    if (_opCaches ==nil) {
        _opCaches = [NSMutableDictionary dictionary];
    }
    return _opCaches;
}

-(NSMutableDictionary *)appPicDic{

    if (_appPicDic==nil) {
        _appPicDic = [NSMutableDictionary dictionary];
    }
    return _appPicDic;
}

-(NSOperationQueue *)queue{

    if (_queue==nil) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}
-(NSArray *)appInfos{

    if (_appInfos==nil) {
        _appInfos = [DJAppInfo appInfo];
    }
    return _appInfos;
}

@end
