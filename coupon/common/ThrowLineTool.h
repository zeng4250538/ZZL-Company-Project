//
//  ThrowLineTool.h
//  coupon
//
//  Created by chijr on 16/1/25.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol ThrowLineToolDelegate;


typedef void(^animationDidFinish)();



@interface ThrowLineTool : NSObject

@property (nonatomic, assign) id<ThrowLineToolDelegate>delegate;
@property (nonatomic, strong) UIView *showingView;

@property (nonatomic, copy) animationDidFinish didFinishBlock;


+ (ThrowLineTool *)sharedTool;

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 *  @param height 高度，抛物线最高点比起点/终点y坐标最低(即高度最高)所超出的高度
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
             height:(CGFloat)height duration:(CGFloat)duration;


- (void)throwBall:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
           height:(CGFloat)height duration:(CGFloat)duration;


@end


@protocol ThrowLineToolDelegate <NSObject>

/**
 *  抛物线结束的回调
 */
- (void)animationDidFinish;

@end

