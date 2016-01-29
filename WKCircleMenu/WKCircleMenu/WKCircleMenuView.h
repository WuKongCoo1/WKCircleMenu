//
//  WKCircleMenuView.h
//  WKCircleMenu
//
//  Created by 吴珂 on 16/1/29.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  WKCircleMenuView;
@protocol WKCircleMenuViewDelegate <NSObject>

- (void)menuView:(WKCircleMenuView *)menuView didSelectAtIndex:(NSInteger)index;

@end

@interface WKCircleMenuView : UIView

@property (nonatomic, assign) id<WKCircleMenuViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;

- (void)hideMenuItem;
- (void)showMenuItem;
- (void)removeBtnAnimation;

@end
