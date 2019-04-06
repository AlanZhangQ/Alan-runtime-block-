//
//  ZQInternationalManager.h
//  runtimeBlockLocalizable
//
//  Created by Alan on 2019/4/4.
//  Copyright © 2019年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQInternationalManager : NSObject

+ (instancetype)sharedInternationalManager;

//当前加载的bundle
@property (strong, nonatomic) NSBundle *languageBunle;

@end
