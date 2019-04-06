//
//  ZQInternationalManager.m
//  runtimeBlockLocalizable
//
//  Created by Alan on 2019/4/4.
//  Copyright © 2019年 Alan. All rights reserved.
//

#import "ZQInternationalManager.h"

static ZQInternationalManager *manager = nil;

@implementation ZQInternationalManager

+ (instancetype)sharedInternationalManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ZQInternationalManager alloc]init];
    });
    
    return manager;
}

@end
