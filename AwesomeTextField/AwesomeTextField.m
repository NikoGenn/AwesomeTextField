//
//  AwesomeTextField.m
//  TrainingWithTextField
//
//  Created by MacBookPro on 21.07.15.
//  Copyright (c) 2015 MacBookPro. All rights reserved.
//

#import "AwesomeTextField.h"

@interface AwesomeTextField ()

@property (strong, nonatomic) UILabel *placeholderLabel;
@property (strong, nonatomic) UIView *lineView;
@property (assign, nonatomic) BOOL isLifted;

@end

@implementation AwesomeTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    self.underlineColor = [UIColor blackColor];
    self.underlineAlpha = 0.5f;
    self.underlineWidth = 2.f;
    self.placeholderColor = [UIColor grayColor];
    self.animationDuration = 0.35f;
}


#pragma Draw methods

- (void) drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [self drawLine];
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeTextField)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didBeginChangeTextField)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didEndChangeTextField)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:self];
    
}

- (void) drawPlaceholderInRect:(CGRect)rect {
    
    [super drawPlaceholderInRect:rect];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x,
                                                                          self.lineView.frame.size.height + 1.f,
                                                                          rect.size.width,
                                                                          self.font.pointSize)];
    self.placeholderLabel.center = CGPointMake(self.placeholderLabel.center.x, self.frame.size.height - self.lineView.frame.size.height - self.placeholderLabel.frame.size.height / 2.f);
    self.placeholderLabel.font = [UIFont fontWithName:self.font.familyName size:self.font.pointSize];
    self.placeholderLabel.text = self.placeholder;
    self.placeholder = nil;
    
    if (self.placeholderColor) {
        self.placeholderLabel.textColor = self.placeholderColor;
    } else {
       self.placeholderLabel.textColor = [UIColor grayColor];
    }
    
    self.placeholderLabel.alpha = 0.5;
    
    
    [self addSubview:self.placeholderLabel];
    [self bringSubviewToFront:self.placeholderLabel];
    
}

- (void) drawTextInRect:(CGRect)rect {
    [super drawTextInRect:rect];
    
    self.textAlignment = NSTextAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
}

-(void) drawLine {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - [self underlineWidthSet], self.frame.size.width, [self underlineWidthSet])];
    if (self.underlineColor) {
       lineView.backgroundColor = self.underlineColor;
    } else {
       lineView.backgroundColor = [UIColor grayColor];
    }
    lineView.alpha = [self underlineAlphaSet];
    self.lineView = lineView;
    
    [self addSubview:self.lineView];
    
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 1.5, self.lineView.frame.size.height + 1.f);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 1.5, self.lineView.frame.size.height + 1.f);
}

#pragma mark - Delegate

- (void) didBeginChangeTextField {
    
    if (!self.isLifted) {
        [UIView animateWithDuration:[self animationDurationSet] animations:^{
            self.placeholderLabel.alpha = 0.85;
            self.placeholderLabel.center = CGPointMake(self.placeholderLabel.center.x, 0 + self.placeholderLabel.frame.size.height);
            self.placeholderLabel.font = [UIFont fontWithName:self.font.familyName size:self.font.pointSize - (1.f/4.f) * self.font.pointSize];
            self.lineView.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            if (finished ) {
                self.isLifted = YES;
            }
        }];
    } else {
        [UIView animateWithDuration:[self animationDurationSet] animations:^{
            self.lineView.alpha = 1.f;
        }];
    }
    
}

- (void) didChangeTextField {
    
    
}

- (void) didEndChangeTextField {
    
    if (self.isLifted && ![self hasText]) {
        [UIView animateWithDuration:[self animationDurationSet] animations:^{
            self.placeholderLabel.alpha = 0.5;
            self.placeholderLabel.center = CGPointMake(self.placeholderLabel.center.x, self.frame.size.height - self.lineView.frame.size.height - self.placeholderLabel.frame.size.height / 2.f);
            self.placeholderLabel.font = [UIFont fontWithName:self.font.familyName size:self.font.pointSize];
            
            self.lineView.alpha = [self underlineAlphaSet];
            
        } completion:^(BOOL finished) {
            if (finished) {
                self.isLifted = NO;
            }
        }];
    } else {
        [UIView animateWithDuration:[self animationDurationSet] animations:^{
            
            self.lineView.alpha = [self underlineAlphaSet];   
        }];
    }
    
}

#pragma mark - New Methods

- (CGFloat) animationDurationSet {
    
    if (self.animationDuration && self.animationDuration >= 0) {
        return self.animationDuration;
    } else {
        return 0.35;
    }
    
}

- (CGFloat) underlineAlphaSet {
    if (self.underlineAlpha && self.underlineAlpha > 0 && self.underlineAlpha <= 1) {
        return self.underlineAlpha;
    } else {
        return 0.5;
    }
}

- (CGFloat) underlineWidthSet {
    if (self.underlineWidth && self.underlineWidth >= 0) {
        return self.underlineWidth;
    } else {
        return 2.f;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
