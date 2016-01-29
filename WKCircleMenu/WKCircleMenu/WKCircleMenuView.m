//
//  WKCircleMenuView.m
//  WKCircleMenu
//
//  Created by 吴珂 on 16/1/29.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import "WKCircleMenuView.h"

#define kSmallWH 50



@interface WKCircleMenuView ()

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, copy) NSArray *images;

@end

@implementation WKCircleMenuView

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images
{
    if (self = [super initWithFrame:frame]) {
        _images = [images copy];
        
        [self creatBtn];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = self.bounds.size.width / 2;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1.f;
        
    }
    return self;
}


- (void)creatBtn
{
    _btns = [NSMutableArray array];
    
    
    for (int i = 0; i < _images.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:_images[i]] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(0, 0, 60, 60);
        
        btn.backgroundColor = [UIColor blueColor];
        
        btn.center = self.center;
        
        [_btns addObject:btn];
        
        
        btn.layer.cornerRadius = btn.bounds.size.width / 2;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)hideMenuItem
{
    for (UIButton *btn in _btns) {
        NSInteger index = [_btns indexOfObject:btn];
        [UIView animateWithDuration:0.2f * index animations:^{
            btn.center = [self.superview convertPoint:self.center toView:self];
        } completion:^(BOOL finished) {
            if (finished) {
                btn.hidden = YES;
                [btn removeFromSuperview];
            }
        }];
    }
}

- (void)showMenuItem
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.bounds.size.width / 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.f;
    
    [self removeBtnAnimation];
    
    for (UIButton *btn in _btns) {
        NSInteger index = [_btns indexOfObject:btn];
        
        CGFloat angle = M_PI * 2 / _images.count * index;
        CGFloat x = btn.center.x + cosf(angle) * (CGRectGetWidth(self.bounds) / 2.0 - (btn.bounds.size.width + 10) / 2.0);
        CGFloat y = btn.center.y - sinf(angle) * (CGRectGetWidth(self.bounds) / 2.0 - (btn.bounds.size.width + 10) / 2.0);
        
        [self addSubview:btn];
        
        btn.hidden = NO;
        
        [UIView animateWithDuration:0.2f * index animations:^{
            btn.center = CGPointMake(x, y);
        } completion:^(BOOL finished) {
            [self addScaleAnimation:btn.layer];
        } ];
        
    }
    
}

- (void)addScaleAnimation:(CALayer *)layer
{
    CAKeyframeAnimation *scaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    
    scaleXAnimation.fillMode = kCAFillModeForwards;
    scaleXAnimation.values = @[@1.0, @1.2, @1.1, @0.8, @1.0];
    scaleXAnimation.keyTimes = @[@0.2, @0.4, @0.6, @0.8, @1.0];
    scaleXAnimation.duration = 1.f;
    
    scaleXAnimation.removedOnCompletion = YES;
    
    scaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [layer addAnimation:scaleXAnimation forKey:@"scaleX"];
    
    
    CAKeyframeAnimation *scaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleYAnimation.fillMode = kCAFillModeForwards;
    scaleYAnimation.values = @[@1.0, @0.8, @0.9, @1.2, @1.0];
    scaleYAnimation.duration = 1.f;
    
    scaleYAnimation.removedOnCompletion = YES;
    scaleYAnimation.keyTimes = @[@0.2, @0.4, @0.6, @0.8, @1.0];
    
    
    scaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [layer addAnimation:scaleYAnimation forKey:@"scaleY"];
}

- (void)selectBtn:(UIButton *)btn
{
    NSLog(@"点击了第%li个按钮", btn.tag);
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectAtIndex:)]) {
        [self.delegate menuView:self didSelectAtIndex:btn.tag];
    }
}

- (void)removeBtnAnimation
{
    for (UIButton *btn in _btns) {
        btn.hidden = NO;
        btn.center = [self.superview convertPoint:self.center toView:self];
        [btn.layer removeAllAnimations];
    }
}
@end
