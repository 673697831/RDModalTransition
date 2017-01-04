//
//  RDModalPresentationController.m
//  RiceDonate
//
//  Created by ozr on 16/4/5.
//  Copyright © 2016年 ricedonate. All rights reserved.
//

#import "RDModalPresentationController.h"

@interface RDModalPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation RDModalPresentationController

- (UIView *)dimmingView
{
    if (!_dimmingView) {
        _dimmingView = [UIView new];
    }
    
    return _dimmingView;
}

- (void)presentationTransitionWillBegin
{
    [self.containerView addSubview:self.dimmingView];
//    CGFloat dimmingViewInitailWidth = self.containerView.frame.size.width * 2 / 3;
//    CGFloat dimmingViewInitailHeight = self.containerView.frame.size.height * 2 / 3;
    self.dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    self.dimmingView.alpha = 0;
    __weak typeof(self) wself = self;
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        wself.dimmingView.alpha = 1;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    __weak typeof(self) wself = self;
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        wself.dimmingView.alpha = 0;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews
{
    self.dimmingView.center = self.containerView.center;
    self.dimmingView.bounds = self.containerView.bounds;
    CGFloat width = self.containerView.frame.size.width ;
    CGFloat height = self.containerView.frame.size.height;
//    self.presentedView.center = self.containerView.center;
//    self.presentedView.bounds = CGRectMake(0, 0, width, height);
    self.presentedView.frame = CGRectMake(0, 20, width, height - 20);
}

@end
