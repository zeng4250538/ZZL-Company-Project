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
        
        UIImageView *uv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width-60)];
        
        
        
       // uv.contentMode = UIViewContentModeScaleToFill;
        
        
        
        if (self.data==nil) {
            
            uv.image =[UIImage imageNamed:[Utils getRandomImage:@"商家图片"]];
            
            
            
        }else{
        
            
             
            NSURL *url = SafeUrl(self.data[@"smallPhotoUrl"]);
            
            
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
            
            make.height.equalTo(@30);
        }];
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        
        nameLabel.backgroundColor = [UIColor whiteColor];
        
        nameLabel.font = [UIFont systemFontOfSize:12];
        
        nameLabel.text =SafeString(self.data[@"name"]);
        
        
        nameLabel.textColor = [GUIConfig grayFontColorDeep];
        
        
        
        
        
        UILabel *shopNameLabel = [UILabel new];
        
        [self addSubview:shopNameLabel];
        
        
        [shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(0);
            make.left.equalTo(uv).offset(10);
            make.height.equalTo(@30);
            
            
        }];
        
        shopNameLabel.textAlignment = NSTextAlignmentCenter;
       // shopNameLabel.backgroundColor = [UIColor whiteColor];
        shopNameLabel.font = [UIFont systemFontOfSize:12];
        shopNameLabel.textColor = [GUIConfig grayFontColorDeep];
        
        
        
        shopNameLabel.text =[NSString stringWithFormat:@"%@(100米)",SafeString(self.data[@"shopName"])];
        
        
        UIView *line = [UIView new];
        
        [uv addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom);
            make.left.equalTo(uv);
            make.right.equalTo(uv);
            make.height.equalTo(@1);
        }];
        
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        

        
        //self.data[@"price"];
        
       
        
        
        
    }
    
    return self;
    
    
    
}

@end
