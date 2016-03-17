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
        
            
            NSString *urlString = self.data[@"couponSmallPhotoUrl"];
            
            
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlString];
            
            
            [uv sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [uv setNeedsDisplay];
            }];
            
            
            
            
            
         //   uv.image =[UIImage imageNamed:self.data[@"icon"]];
        }
        
    
        
        
        
        [self addSubview:uv];
        
        
        UILabel *nameLabel = [UILabel new];
        [self addSubview:nameLabel];
        
        
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(uv.mas_bottom);
            make.left.right.equalTo(uv).offset(10);
            make.right.right.equalTo(uv);
            
            make.height.equalTo(@35);
        }];
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        
        nameLabel.backgroundColor = [UIColor whiteColor];
        
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        
        nameLabel.text = self.data[@"name"];
        
        nameLabel.textColor = [UIColor darkGrayColor];
        
        
        UILabel *priceLabel = [UILabel new];
        
        [self addSubview:priceLabel];
        
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(uv.mas_bottom);
            make.right.equalTo(uv).offset(-10);
            make.height.equalTo(@35);
            
            
        }];
        
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.backgroundColor = [UIColor whiteColor];
        priceLabel.font = [UIFont boldSystemFontOfSize:16];
        priceLabel.textColor = [UIColor redColor];
        
        
        
        priceLabel.text =[NSString stringWithFormat:@"￥%@元",self.data[@"price"]];
        
        //self.data[@"price"];
        
       
        
        
        
    }
    
    return self;
    
    
    
}

@end
