//
//  UIView+Ouroboros.m
//  Ouroboros
//
//  Created by Draveness on 15/10/5.
//  Copyright © 2015年 Draveness. All rights reserved.
//

#import "UIView+Ouroboros.h"
#import "UIScrollView+Ouroboros.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) NSMutableArray *ouroboroses;

@end

@implementation UIView (Ouroboros)

- (void)ou_updateState:(NSNotification *)notification {
    CGPoint contentOffset = [[notification userInfo][@"contentOffset"] CGPointValue];
    OURScrollDirection direction = [[notification userInfo][@"direction"] integerValue];
    for (Ouroboros *ouroboros in self.ouroboroses) {
        CGFloat currentPosition = 0;
        if (direction == OURScrollDirectionHorizontal) {
            currentPosition = contentOffset.x;
        } else {
            currentPosition = contentOffset.y;
        }
        CGFloat percent = (currentPosition - ouroboros.trggier) / ouroboros.duration;
        id value = [ouroboros calculateInternalValueWithPercent:percent];

        OURAnimationProperty property = ouroboros.property;
        switch (property) {
            case OURAnimationPropertyViewBackgroundColor: {
                self.backgroundColor = value;
            }
                break;
            case OURAnimationPropertyViewBounds:
            case OURAnimationPropertyViewFrame: {
                self.frame = [value CGRectValue];
            }
                break;
            case OURAnimationPropertyViewSize: {
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [value CGSizeValue].width, [value CGSizeValue].height);
            }
                break;
            case OURAnimationPropertyViewCenter: {
                self.center = [value CGPointValue];
            }
                break;
            case OURAnimationPropertyViewCenterX: {
                self.center = CGPointMake(self.center.x, [value floatValue]);
            }
                break;
            case OURAnimationPropertyViewCenterY: {
                self.center = CGPointMake([value floatValue], self.center.y);
            }
                break;
            case OURAnimationPropertyViewTintColor: {
                self.tintColor = value;
            }
                break;
            case OURAnimationPropertyViewOrigin: {
                self.frame = CGRectMake([value CGPointValue].x, [value CGPointValue].y, self.frame.size.width, self.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewOriginX: {
                self.frame = CGRectMake([value floatValue], self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewOriginY: {
                self.frame = CGRectMake(self.frame.origin.x, [value floatValue], self.frame.size.width, self.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewWidth: {
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [value floatValue], self.frame.size.height);
            }
                break;
            case OURAnimationPropertyViewHeight: {
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [value floatValue]);
            }
                break;
            case OURAnimationViewAlpha: {
                self.alpha = [value floatValue];
            }
            default:
                break;
        }
    }
}

- (void)ou_animateWithProperty:(OURAnimationProperty)property
                configureBlock:(OuroborosAnimationBlock)configureBlock {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ou_updateState:) name:@"ScrollView" object:nil];

    Ouroboros *ouroboros = [[Ouroboros alloc] initWithProperty:property];
    configureBlock(ouroboros);
    [self.ouroboroses addObject:ouroboros];
}

#pragma mark - Getter/Setter

- (NSMutableArray *)ouroboroses {
    if (!objc_getAssociatedObject(self, @selector(ouroboroses))) {
        objc_setAssociatedObject(self, @selector(ouroboroses), [[NSMutableArray alloc] init], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(ouroboroses));
}

- (void)setOuroboros:(NSMutableArray *)ouroboroses {
    objc_setAssociatedObject(self, @selector(ouroboroses), ouroboroses, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
