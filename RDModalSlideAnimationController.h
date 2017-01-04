//
//  RDModalAnimationController.h
//  RiceDonate
//
//  Created by ozr on 16/4/5.
//  Copyright © 2016年 ricedonate. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RDModalSlideTransitionType) {
    kRDModalSlideTransitionTypePresentation,
    kRDModalSlideTransitionTypeDismissal,
};

@interface RDModalSlideAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) RDModalSlideTransitionType transitionType;

- (instancetype)initWithTransitionType:(RDModalSlideTransitionType)transitionType;

@end
