//
//  UIView+DataLoad.m
//  coupon
//
//  Created by chijr on 16/3/20.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "UIView+DataLoad.h"

#import "ReloadHud.h"


@implementation UIView (DataLoad)





-(void)doLoad:(void(^)(BOOL ret))completion{
    
    
    
    
}








-(void)loadData{
    
    
   
    
    
    [ReloadHud showHUDAddedTo:self reloadBlock:^{
        
        
        
        
    
        
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self];
        }
        
        
    }];
    

    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
