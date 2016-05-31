//
//  HistoryCouponCell.m
//  coupon
//
//  Created by chijr on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "HistoryCouponCell.h"


@interface HistoryCouponCell()

@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)UIButton *commentButton;
@property(nonatomic,strong)UILabel *typeLabel;


@end


@implementation HistoryCouponCell

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
        
        self.detailLabel = [UILabel new];
        
        [self.contentView addSubview:self.detailLabel];
        
        
        self.commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self.contentView addSubview:self.commentButton];
        
        
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.equalTo(@120);
        }];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.logoImageView.mas_right).offset(10);
            make.top.equalTo(self.logoImageView);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
        }];
        
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [GUIConfig grayFontColorDeep];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.logoImageView.mas_right).offset(10);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
        }];
        
        self.detailLabel.font = [UIFont systemFontOfSize:12];
        self.detailLabel.textColor = [GUIConfig grayFontColor];
        
        
        
        [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@22);
            make.width.equalTo(@45);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        
        self.commentButton.clipsToBounds = YES;
        self.commentButton.layer.cornerRadius=4;
        [self.commentButton bk_addEventHandler:^(id sender) {
            
            
            if (self.commentTouchBlock) {
                
                self.commentTouchBlock(self.data);
            }
            
            
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.nameLabel.text = SafeString(self.data[@"shopName"]);
    
    NSURL *url = SafeUrl(self.data[@"couponPhotoUrl"]);
    
    
    
    
    
    self.detailLabel.text = SafeString(self.data[@"couponName"]);
    
    
    SafeLoadUrlImage(self.logoImageView, url, ^{
        
//        [self setNeedsLayout];
        
    });
    
    
    [self.logoImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [self.logoImageView setNeedsLayout];
        
    }];
  
    
    if (!SafeEmpty(self.data[@"reviewId"])) {
        
        self.commentButton.backgroundColor = [UIColor whiteColor];
        [self.commentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.commentButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.commentButton setTitle:@"已评论" forState:UIControlStateNormal];
        
        
        
    }else{
        
        
        self.commentButton.backgroundColor = [GUIConfig orangeColor];
        
        [self.commentButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
        self.commentButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.commentButton setTitle:@"评论" forState:UIControlStateNormal];
        

        
        
        
        
        
    }
    
    //self.endTimeLabel.text =[NSString stringWithFormat:@"截止时间:%@", SafeString(self.data[@"endTime"])];
    
    
    
    ;

    
    
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
