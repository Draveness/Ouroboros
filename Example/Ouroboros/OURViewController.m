//
//  OURViewController.m
//  Ouroboros
//
//  Created by Draveness on 10/28/2015.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "OURViewController.h"
#import "Ouroboros.h"

@interface OURViewController ()

@end

@implementation OURViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
    scrollView.ou_scrollDirection = OURScrollDirectionHorizontal;

    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor redColor];
    yellowView.frame = CGRectMake(50, 50, 100, 100);
    [scrollView addSubview:yellowView];

    [yellowView.ouroboros animateWithProperty:OURAnimationPropertyViewBackgroundColor
                        configureBlock:^(Ouroboros *ouroboros) {
                            ouroboros.toValue = [UIColor blueColor];
                            ouroboros.offset = self.view.frame.size.width;
                        }];
    [yellowView.ouroboros animateWithProperty:OURAnimationPropertyViewFrame
                        configureBlock:^(Ouroboros *ouroboros) {
                            ouroboros.toValue = [NSValue valueWithCGRect:CGRectMake(50, 500, 100, 100)];
                            ouroboros.offset = self.view.frame.size.width;
                        }];
    [yellowView.ouroboros pinWithConfigureBlock:^(Ouroboros * _Nonnull ouroboros) {
        ouroboros.offset = self.view.frame.size.width;
    }];
}

@end
