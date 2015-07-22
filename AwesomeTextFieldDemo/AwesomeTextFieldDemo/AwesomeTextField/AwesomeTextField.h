//
//  AwesomeTextField.h
//  TrainingWithTextField
//
//  Created by MacBookPro on 21.07.15.
//  Copyright (c) 2015 MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface AwesomeTextField : UITextField

@property (strong, nonatomic) IBInspectable UIColor *underlineColor;
@property (assign, nonatomic) IBInspectable CGFloat underlineWidth;
@property (assign, nonatomic) IBInspectable CGFloat underlineAlpha;
@property (strong, nonatomic) IBInspectable UIColor *placeholderColor;
@property (assign, nonatomic) IBInspectable CGFloat animationDuration;

@end
