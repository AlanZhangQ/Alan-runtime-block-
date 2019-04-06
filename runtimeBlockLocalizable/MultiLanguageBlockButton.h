//
//  MultiLanguageBlockButton.h
//  AIA_HK_iPoS_iOS
//
//  Created by Michael Wang on 29/10/2018.
//  Copyright © 2018 Treasure Frontier System Sdn. Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(UIButton * button);

@interface MultiLanguageBlockButton : UIButton

@property (nonatomic, copy) Block block;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
