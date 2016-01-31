//
//  CouponView.m
//  coupon
//
//  Created by chijr on 16/1/14.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponView.h"

@implementation CouponView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary*)data{
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor=[UIColor whiteColor];
    
    
    
    self.data = data;
    
    if (self) {
        
        UIImageView *uv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        
        
        
        uv.contentMode = UIViewContentModeScaleToFill;
        
        
        
        if (self.data==nil) {
            
            uv.image =[UIImage imageNamed:[Utils getRandomImage:@"商家图片"]];
            
            
            
        }else{
        
            uv.image =[UIImage imageNamed:self.data[@"imgurl"]];
        }
        
    
        
        
        
        [self addSubview:uv];
        
        
        UILabel *nameLabel = [UILabel new];
        [self addSubview:nameLabel];
        
        
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(uv.mas_bottom);
            make.left.right.equalTo(uv);
            make.right.right.equalTo(uv);
            
            make.height.equalTo(@20);
        }];
        
        nameLabel.textAlignment = NSTextAlignmentCenter;
        
        nameLabel.backgroundColor = [UIColor whiteColor];
        
        nameLabel.font = [UIFont systemFontOfSize:15];
        
        nameLabel.text = self.data[@"name"];
        
        
        UILabel *priceLabel = [UILabel new];
        
        [self addSubview:priceLabel];
        
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom);
            make.left.right.equalTo(uv);
            
            
        }];
        
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.backgroundColor = [UIColor whiteColor];
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textColor = [UIColor redColor];
        
        
        
        priceLabel.text = self.data[@"price"];
        
       
        
        
        
    }
    
    return self;
    
    
    
}

@end
