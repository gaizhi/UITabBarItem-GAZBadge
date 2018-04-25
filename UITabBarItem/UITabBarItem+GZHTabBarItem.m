//
//  UITabBarItem+GZHTabBarItem.m
//  GZHTabBarItem
//
//  Created by 徐强 on 2017/5/23.
//  Copyright © 2017年 starnet. All rights reserved.
//

#import "UITabBarItem+GZHTabBarItem.h"

#import <NSObject-GZHObject/NSObject+GZHObject.h>

#import <objc/runtime.h>

static char GZHTabBarItemDotViewKey;

@implementation UITabBarItem (GZHTabBarItem)

+ (void)load {
    [self gzh_swizzleSelector:@selector(setBadgeValue:) withSelector:@selector(gzh_setBadgeValue:)];
    [self gzh_swizzleSelector:@selector(setBadgeColor:) withSelector:@selector(gzh_setBadgeColor:)];
    [self gzh_swizzleSelector:@selector(setView:) withSelector:@selector(gzh_setView:)];
}

# pragma mark swizzle method
- (void)gzh_setBadgeValue:(NSString *)badgeValue {
    // 如果设置为红点，即badgeVaule=@"", 则隐藏原生的badge并自定义红点，否则隐藏自定义红点，并显示原生badge
    if (badgeValue != nil && badgeValue.length == 0) {
        [self gzh_setBadgeValue:nil];
        [self showBadgeDot];
    } else {
        [self hideBadgeDot];
        [self gzh_setBadgeValue:badgeValue];
    }
}

- (void)gzh_setBadgeColor:(UIColor *)color {
    [self gzh_setBadgeColor:color];

    // 如果当前存在自定义dot，则修改dot的颜色
    if (self.dotView) {
        self.dotView.backgroundColor = color;
    }
}

- (void)gzh_setView:(UIView *)view {
    [self gzh_setView:view];

    // 每次dot的superView发生变化时，应该重新设置dot
    [self setBadgeValue:(self.dotView && self.dotView.superview && !self.dotView.hidden ? @"" : self.badgeValue)];
}

# pragma mark private method
- (void)showBadgeDot {
    if (!self.dotView) {
        //新建小红点
        UIView *dotView = [[UIView alloc] init];
        dotView.hidden = YES;
        dotView.layer.cornerRadius = 5;
        dotView.backgroundColor = [UIColor redColor];
        if (@available(iOS 10.0, *)) {
            if (self.badgeColor) {
                dotView.backgroundColor = self.badgeColor; // 设置dot的颜色为原生badge的颜色
            }
        }
        dotView.userInteractionEnabled = NO;
        dotView.translatesAutoresizingMaskIntoConstraints = NO;

        [self setDotView:dotView]; // 保存dot
    }

    // 避免dot的superView变更，此处重新绑定superView
    [self.dotView removeFromSuperview];
    [self.dotView removeConstraints:self.dotView.constraints];

    if (self.dotView) {
        UIView *view = [self valueForKey:@"view"];
        UIView *dotView = self.dotView;

        [view addSubview:dotView];

        //确定小红点的位置
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:dotView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:dotView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:dotView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:dotView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:0.05 constant:4];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:dotView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:0.53 constant:0];

        [view addConstraints:@[top, left]];
        [dotView addConstraints:@[width, height]];
    }

    self.dotView.hidden = NO;
}

- (void)hideBadgeDot {
    if (self.dotView && self.dotView.superview) {
        self.dotView.hidden = YES;
    }
}

# pragma mark getter setter
- (void)setDotView:(UIView *)dotView {
    objc_setAssociatedObject(self, &GZHTabBarItemDotViewKey, dotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dotView {
    return objc_getAssociatedObject(self, &GZHTabBarItemDotViewKey);
}

@end
