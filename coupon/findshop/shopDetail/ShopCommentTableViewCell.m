//
//  ShopCommentTableViewCell.m
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopCommentTableViewCell.h"

@interface ShopCommentTableViewCell()

@property(nonatomic,strong)UIImageView *personImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *timeLabel;




@end


@implementation ShopCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.personImageView = [UIImageView new];
        [self.contentView addSubview:self.personImageView];
        
        self.personImageView.layer.cornerRadius=20;
       // self.personImageView.layer.borderWidth=1;
        self.personImageView.clipsToBounds = YES;
        
        
        self.nameLabel =[UILabel new];
        [self.contentView addSubview:self.nameLabel];
        
        self.contentLabel = [UILabel new];
        
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [UILabel new];
        
        [self.contentView addSubview:self.timeLabel];
        
        
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.personImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        
        
        
    }];
    
    self.personImageView.image = [UIImage imageNamed:@"head_icon1.png"];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.personImageView.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
    }];
    
    self.nameLabel.text=@"无缺小鱼儿";
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        
    }];
    
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.numberOfLines = 0;
    
    self.contentLabel.text=@"测试测试测试，测试测试测试，测试测试测试，测试测试测试，测试测试测试，测试测试测试，测试测试测试";
    
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
