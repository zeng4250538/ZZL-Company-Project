//
//  BasketNotUseTableViewCell.m
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BasketNotUseTableViewCell.h"


@interface BasketNotUseTableViewCell()
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *endTimeLabel;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UILabel *subNameLabel;
@end


@implementation BasketNotUseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.logoImageView = [UIImageView new];
        
        
        [self.contentView addSubview:self.logoImageView];
        
        
        self.nameLabel = [UILabel new];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.endTimeLabel = [UILabel new];
        
        [self.contentView addSubview:self.endTimeLabel];
        
        self.subNameLabel = [UILabel new];
        
        [self.contentView addSubview:self.subNameLabel];
        
        
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.equalTo(@120);
        }];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.logoImageView.mas_right).offset(10);
            make.top.equalTo(self.logoImageView).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
        }];
        
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = [GUIConfig grayFontColorDeep];
        
        [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
            make.width.equalTo(@200);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        
        self.endTimeLabel.textColor  = [GUIConfig grayFontColorLight];
        self.endTimeLabel.font = [UIFont systemFontOfSize:12];
        
        
        [self.subNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.logoImageView.mas_right).offset(10);
            make.top.equalTo(self.logoImageView).offset(35);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
            
        }];
        self.subNameLabel.font = [UIFont systemFontOfSize:14];
        self.subNameLabel.textColor = [UIColor grayColor];
        
    }
    
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
}

-(void)updateData{
    
    self.nameLabel.text = SafeString(self.data[@"shopName"]);
    
    self.subNameLabel.text = SafeString(self.data[@"name"]);
    
    NSURL *url = SafeUrl(self.data[@"smallPhotoUrl"]);
    
    
    SafeLoadUrlImage(self.logoImageView, url, ^{
        
        [self.logoImageView setNeedsLayout];
        
        
        
    });
    
    
//    [self.logoImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        
//    }];
//    
    //self.endTimeLabel.text =[NSString stringWithFormat:@"截止时间:%@", SafeString(self.data[@"endTime"])];
    
    
    
   ;
    
    
    
    
    
}

@end
