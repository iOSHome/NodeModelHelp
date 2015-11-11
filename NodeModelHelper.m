//
//  NodeModelHelper.m
//  TextCapital
//
//  Created by YouXianMing on 15/11/11.
//  Copyright © 2015年 mc. All rights reserved.
//

#import "NodeModelHelper.h"
#import "NodeModel.h"
#import "NodeModelViewController.h"
#import "NodeModelRootNavigationController.h"

@implementation NodeModelHelper

+ (void)jsonData:(NSDictionary *)jsonData rootModelName:(NSString *)rootModelName {
    
    NSParameterAssert(jsonData);
    NSParameterAssert(rootModelName);
    
    if ([jsonData isKindOfClass:[NSDictionary class]]) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData
                                                       options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                         error:nil];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        if (data && window) {
            
            NodeModel                         *nodeModel = [NodeModel nodeModelWithDictionary:jsonData modelName:rootModelName level:0];
            NodeModelViewController           *nodeVC    = [[NodeModelViewController alloc] init];
            NodeModelRootNavigationController *nodeNC    = [[NodeModelRootNavigationController alloc] initWithRootViewController:nodeVC
                                                                                                                   rootNodeModel:nodeModel];
            [window.rootViewController presentViewController:nodeNC animated:YES completion:nil];
        }
    }
}

+ (void)ceateJsonData:(NSDictionary *)jsonData {

    if ([jsonData isKindOfClass:[NSDictionary class]]) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData
                                                       options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                         error:nil];
        
        if (data) {

            [data writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/data.json"]
                   atomically:YES];
            
            NSLog(@"生成的文件在以下地址: \n%@", [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/"]);
        }
    }
}

@end
