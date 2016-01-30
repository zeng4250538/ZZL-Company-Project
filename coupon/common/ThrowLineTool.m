//
//  ThrowLineTool.m
//  coupon
//
//  Created by chijr on 16/1/25.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ThrowLineTool.h"

static ThrowLineTool *s_sharedInstance = nil;
@implementation ThrowLineTool

+ (ThrowLineTool *)sharedTool
{
    if (!s_sharedInstance) {
        s_sharedInstance = [[[self class] alloc] init];
    }
    return s_sharedInstance;
}

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 *  @param height 高度，抛物线最高点比起点/终点y坐标最低(即高度最高)所超出的高度
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
             height:(CGFloat)height duration:(CGFloat)duration
{
    self.showingView = obj;
    //初始化抛物线path
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat cpx = (start.x + end.x) / 2;
    CGFloat cpy = -height;
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, end.x, end.y);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.removedOnCompletion = NO;
    animation.autoreverses = NO;
    animation.fillMode =  kCAFillModeForwards;
    CFRelease(path);
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.autoreverses = NO;
    scaleAnimation.toValue = [NSNumber numberWithFloat:(CGFloat)((arc4random() % 4) + 4) / 100.0];
    
    scaleAnimation.removedOnCompletion = NO;
    
    scaleAnimation.fillMode =  kCAFillModeForwards;
    
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.delegate = self;
    groupAnimation.repeatCount = 0;
    groupAnimation.duration = duration;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = @[scaleAnimation, animation];
    
    groupAnimation.removedOnCompletion = NO;
    
    groupAnimation.fillMode =  kCAFillModeForwards;
    
    [groupAnimation setValue:obj.layer forKey:@"parentLayer"];
    
    

    
    groupAnimation.autoreverses = NO;
    
    
    
    
    
    [obj.layer addAnimation:groupAnimation forKey:@"position"];
}




/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 *  @param height 高度，抛物线最高点比起点/终点y坐标最低(即高度最高)所超出的高度
 */
- (void)throwBall:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
             height:(CGFloat)height duration:(CGFloat)duration
{
    self.showingView = obj;
    //初始化抛物线path
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat cpx = (start.x + end.x) / 2;
    CGFloat cpy = -height;
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, end.x, end.y);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.removedOnCompletion = NO;
    animation.autoreverses = NO;
    animation.fillMode =  kCAFillModeForwards;
    CFRelease(path);
    
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.delegate = self;
    groupAnimation.repeatCount = 0;
    groupAnimation.duration = duration;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = @[ animation];
    
    groupAnimation.removedOnCompletion = NO;
    
    groupAnimation.fillMode =  kCAFillModeForwards;
    
    [groupAnimation setValue:obj.layer forKey:@"parentLayer"];
    
    
    
    
    groupAnimation.autoreverses = NO;
    
    
    
    
    
    [obj.layer addAnimation:groupAnimation forKey:@"position"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

   
//    CALayer *layer = [anim valueForKey:@"parentLayer"];
//    
//    if (layer) {
//        layer.opacity=0;
//    }
//    
//    
//    [layer removeFromSuperlayer];
//    [layer removeAllAnimations];
//    
    
    self.showingView = nil;
    
    
    
    
    

    if (self.didFinishBlock) {

        self.didFinishBlock();
    }
    
 
    
}


@end


