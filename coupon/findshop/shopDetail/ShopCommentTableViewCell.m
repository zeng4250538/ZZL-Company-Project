//
//  ShopCommentTableViewCell.m
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopCommentTableViewCell.h"

@interface ShopCommentTableViewCell()

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *lineImage;
@property(nonatomic,strong)UIImageView *coarsLineImage;


@end


@implementation ShopCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.nameLabel =[UILabel new];
        [self.contentView addSubview:self.nameLabel];
        
        self.contentLabel = [UILabel new];
        
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [UILabel new];
        
        [self.contentView addSubview:self.timeLabel];
        
        self.lineImage = [UIImageView new];
        [self.contentView addSubview:self.lineImage];
        
        self.coarsLineImage = [UIImageView new];
        [self.contentView addSubview:self.coarsLineImage];
        
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.coarsLineImage setBackgroundColor:UIColorFromRGB(245, 245, 245)];
    [self.coarsLineImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.height.equalTo(@8);
        
    }];
    
    [self.lineImage setBackgroundColor:UIColorFromRGB(235, 235, 235)];
    [self.lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView).offset(40);
        make.height.equalTo(@1);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.equalTo(@180);
        make.height.equalTo(@20);
        
    }];
    [self.nameLabel setFont:[UIFont systemFontOfSize:15]];
    
//    self.nameLabel.text=@"无缺小鱼儿";
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
        
    }];
    
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.numberOfLines = 0;
    
//    self.contentLabel.text=@"测试测试测试，测试测试测试，测试测试测试，测试测试测试，测试测试测试，测试测试测试，测试测试测试";
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
        
    }];
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = [UIColor grayColor];
    
    self.nameLabel.text= SafeString(self.data[@"customerName"]);
    self.contentLabel.text= SafeString(self.data[@"comment"]);
    self.timeLabel.text = SafeString(self.data[@"time"]);

    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
