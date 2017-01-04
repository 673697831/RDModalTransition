//
//  RDModalTransitionDelegate.m
//  RiceDonate
//
//  Created by ozr on 16/4/5.
//  Copyright © 2016年 ricedonate. All rights reserved.
//

#import "RDModalTransitionDelegate.h"
#import "RDModalSlideAnimationController.h"
#import "RDModalPresentationController.h"

@interface RDModalTransitionDelegate ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@property (nonatomic, assign) BOOL interactive;

@end

@implementation RDModalTransitionDelegate

- (instancetype)initWithVC:(UIViewController *)vc
{
    if (self = [self init]) {
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
        [vc.view addGestureRecognizer:panGestureRecognizer];
        _toVC = vc;
        
    }
    
    return self;
}

- (void)panned:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactive = YES;
            
            [self.toVC dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [gesture translationInView:self.toVC.view];
            
            CGFloat completionProgress = translation.y / (CGRectGetHeight(self.toVC.view.bounds));
            
            [self.interactionController updateInteractiveTransition:completionProgress];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            
            self.interactive = NO;
            
            if ([gesture velocityInView:self.toVC.view].y > 0) {
                [self.interactionController finishInteractiveTransition];
                return;
            }
            
            if (fabs([gesture locationInView:self.toVC.view].y) < self.toVC.view.bounds.size.height / 3) {
                [self.interactionController finishInteractiveTransition];
            }else
            {
                [self.interactionController cancelInteractiveTransition];
            }

            break;
        }
        default:{
            [self.interactionController cancelInteractiveTransition];

            self.interactive = NO;
            break;
        }
    }
}

#pragma mark - lazy 

- (UIPercentDrivenInteractiveTransition *)interactionController
{
    if (!_interactionController) {
        _interactionController = [UIPercentDrivenInteractiveTransition new];
    }
    
    return _interactionController;
}

#pragma mark -

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[RDModalSlideAnimationController alloc] initWithTransitionType:kRDModalSlideTransitionTypePresentation];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[RDModalSlideAnimationController alloc] initWithTransitionType:kRDModalSlideTransitionTypeDismissal];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactive ? self.interactionController: nil;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[RDModalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
