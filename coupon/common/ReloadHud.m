//
//  ReloadHud.m
//  coupon
//
//  Created by chijr on 16/3/10.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ReloadHud.h"



@interface ReloadHud()
@property(nonatomic,strong)UIActivityIndicatorView *actView;
@property(nonatomic,strong)UIButton *touchButton;

@end


@implementation ReloadHud

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (void)removeHud:(UIView *)view animated:(BOOL)animated {
    
    for (UIView *uv  in [view subviews]) {
        
        if ([uv isKindOfClass:[ReloadHud class]]) {
            
            [uv removeFromSuperview];
        }
    }
    
}


+ (instancetype)showHUDAddedTo:(UIView *)view reloadBlock:(ReloadBlock)reloadBlock{
    
    
    CGRect r = view.frame;
    
    view.backgroundColor = [UIColor whiteColor];
    
    
    ReloadHud *hud = [[ReloadHud alloc] initWithFrame:r];
    

    
    [view addSubview:hud];
    
    
    [view bringSubviewToFront:hud];
    
    
   // [hud bringSubviewToFront:view];
    
    
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(view);
        make.width.equalTo(view);
        make.height.equalTo(view);
        
    }];
    
    hud.reloadBlock = reloadBlock;
    
    hud.backgroundColor =[UIColor whiteColor];
    
    return hud;

    
    
    
    
}



+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    
    CGRect r = view.frame;
    
    r.origin.x=0;
    r.origin.y=0;
    
    ReloadHud *hud = [[ReloadHud alloc] initWithFrame:r];
    
    [view addSubview:hud];
    
    
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.equalTo(view);
        make.height.equalTo(view);
        
    }];
    

    hud.backgroundColor =[UIColor whiteColor];
    
    return hud;
  
}



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        self.touchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self addSubview:self.touchButton];
        
        [self.touchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self);
            make.width.height.equalTo(self);
            
            
        }];
        
        
        
        [self.touchButton bk_addEventHandler:^(id sender) {
            
            self.touchButton.hidden = YES;
            
           self.actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            [self addSubview:self.actView];
            
            [self.actView startAnimating];
            
            [self.actView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self).offset(-30);
                
                
            }];

            
            self.reloadBlock();
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.touchButton.hidden = YES;
        
        self.actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [self addSubview:self.actView];
        
        [self.actView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            
        }];
        
    }
    
    return self;
    
    
    
}

-(void)showReloadMode{
    
    [self.actView stopAnimating];
    
    [self.actView removeFromSuperview];
    
    
    [self.touchButton setTitle:@"重新装载" forState:UIControlStateNormal];
    self.touchButton.titleLabel.font = [UIFont systemFontOfSize:25];
    
    [self.touchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.touchButton.hidden = NO;
    
    
    
}


+(void)showReloadMode:(UIView*)view{
    
    
    for (UIView *uv  in [view subviews]) {
        
        if ([uv isKindOfClass:[ReloadHud class]]) {
            
            ReloadHud *hud = (ReloadHud*)uv;
            
            [hud showReloadMode];
            
            
        }
    }
    

    
    
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.actView startAnimating];
    
    
}

-(void)dealloc{
    
    [self.actView stopAnimating];
    [self.actView removeFromSuperview];
    
    
}





@end
