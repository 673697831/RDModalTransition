//
//  RDModalAnimationController.m
//  RiceDonate
//
//  Created by ozr on 16/4/5.
//  Copyright © 2016年 ricedonate. All rights reserved.
//

#import "RDModalSlideAnimationController.h"

@interface RDModalSlideAnimationController ()

@property (nonatomic, strong) UIView *dimmingView;

- (void)initializationDimmingViewWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

@implementation RDModalSlideAnimationController

- (instancetype)initWithTransitionType:(RDModalSlideTransitionType)transitionType
{
    if (self = [self init]) {
        _transitionType = transitionType;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return .4;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView =  [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (!containerView) {
        return;
    }
    if (!fromVC) {
        return;
    }
    if (!toVC) {
        return;
    }
    
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        [self initializationDimmingViewWithTransitionContext:transitionContext];
    }
    
    CGFloat translation = containerView.frame.size.height - 20;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    if (self.transitionType == kRDModalSlideTransitionTypePresentation) {
        toViewTransform = CGAffineTransformMakeTranslation(0, translation);
        fromViewTransform = CGAffineTransformMakeTranslation(0, 0);
        toVC.view.frame = CGRectMake(0, 20, containerView.bounds.size.width, containerView.bounds.size.height - 20);
        [containerView addSubview:toVC.view];
    }else
    {
        toViewTransform = CGAffineTransformMakeTranslation(0, 0);
        fromViewTransform = CGAffineTransformMakeTranslation(0, translation);
    }
    
    toVC.view.transform = toViewTransform;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^
     {
         fromVC.view.transform = fromViewTransform;
         toVC.view.transform = CGAffineTransformIdentity;
     }
                     completion:^(BOOL finished)
     {
         fromVC.view.transform = CGAffineTransformIdentity;
         toVC.view.transform = CGAffineTransformIdentity;
         BOOL isCancelled = [transitionContext transitionWasCancelled];
         [transitionContext completeTransition:!isCancelled];
     }];
    
}

#pragma mark - ios 7不完美适配

- (void)initializationDimmingViewWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView =  [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGFloat toViewWidth = containerView.frame.size.width;
    CGFloat toViewHeight = containerView.frame.size.height;
    
    if ([toVC isBeingPresented]) {
        
        if (self.dimmingView) {
            return;
        }
        
        toVC.view.center = containerView.center;
        toVC.view.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
        UIView *dimmingView = [UIView new];
        [containerView insertSubview:dimmingView
                        belowSubview:toVC.view];
        dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        dimmingView.center = containerView.center;
        dimmingView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
        self.dimmingView = dimmingView;
    }
    
    if ([fromVC isBeingDismissed]) {
        //永远不通过
        if (self.dimmingView) {
            [UIView animateWithDuration:.1
                             animations:^
             {
                 self.dimmingView.backgroundColor = [UIColor blueColor];
             } completion:^(BOOL finished) {
                 if (finished) {
                     
                 }
             }];
        }
    }
}

@end
