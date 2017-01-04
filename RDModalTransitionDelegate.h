//
//  RDModalTransitionDelegate.h
//  RiceDonate
//
//  Created by ozr on 16/4/5.
//  Copyright © 2016年 ricedonate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDModalTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UIViewController *toVC;

- (instancetype)initWithVC:(UIViewController *)vc;

@end
