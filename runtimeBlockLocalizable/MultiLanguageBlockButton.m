//
//  MultiLanguageBlockButton.m
//  AIA_HK_iPoS_iOS
//
//  Created by Michael Wang on 29/10/2018.
//  Copyright © 2018 Treasure Frontier System Sdn. Bhd. All rights reserved.
//

#import "MultiLanguageBlockButton.h"

@implementation MultiLanguageBlockButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        UIColor *color1 = [UIColor colorWithRed:4.0 / 255 green:140.0 / 255 blue:245.0 / 255 alpha:1];
        //        UIColor *color2 = [UIColor colorWithRed:1.0 / 255 green:95.0 / 255 blue:230.0 / 255 alpha:1];
        [self setTitleColor:color1 forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)click:(UIButton *)button {
    self.block(button);
}

@end
