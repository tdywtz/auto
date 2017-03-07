//
//  LHTransitionAnimation.m
//  auto
//
//  Created by bangong on 17/2/27.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import "LHTransitionAnimation.h"

@implementation LHTransitionAnimation
#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    if (self.operation == UINavigationControllerOperationPush)
    {
        UIViewController *fromVC  = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC    = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

        // Animate
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:0.75
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{

                         }
                         completion:^(BOOL finished){

                             [transitionContext completeTransition:YES];
                         }];
          }

    else
    {
        UIViewController *fromVC  = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC    = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        // Animate
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:0.75
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{

                         }
                         completion:^(BOOL finished){

                             [transitionContext completeTransition:YES];
                         }];

    }
}


#pragma mark - Perspective Zoom

- (BOOL)canPerspectiveZoomWithImageSize:(CGSize)imageSize boundsSize:(CGSize)boundsSize
{
    CGFloat imageRatio  = imageSize.width / imageSize.height;
    CGFloat boundsRatio = boundsSize.width / boundsSize.height;

    // can perform perspective zoom when the difference of aspect ratios is smaller than 20%
    return (fabs( (imageRatio - boundsRatio) / boundsRatio ) < 0.2f);
}



#pragma mark - Snapshot

- (UIView *)resizedSnapshot:(UIImageView *)imageView
{
    CGSize size = imageView.frame.size;

    if (CGSizeEqualToSize(size, CGSizeZero))
        return nil;

    UIGraphicsBeginImageContextWithOptions(size, YES, 0);

    [[UIColor whiteColor] set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));

    [imageView.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return (UIView *)[[UIImageView alloc] initWithImage:resized];
}

@end
