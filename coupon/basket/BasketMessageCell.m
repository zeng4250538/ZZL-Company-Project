//
//  BasketMessageCell.m
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BasketMessageCell.h"

@interface BasketMessageCell()
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *endTimeLabel;
@property(nonatomic,strong)UILabel *detailLabel;

@end


@implementation BasketMessageCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        
        self.nameLabel = [UILabel new];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.endTimeLabel = [UILabel new];
        
        [self.contentView addSubview:self.endTimeLabel];
        
        
        self.detailLabel = [UILabel new];
        [self.contentView addSubview:self.detailLabel];
        
        
        
        
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-100);
            make.height.equalTo(@20);
        }];
        
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [GUIConfig grayFontColorDeep];
        
        [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.nameLabel);
           // make.width.equalTo(@180);
            make.height.equalTo(@20);
        }];
        
        self.endTimeLabel.textColor  = [GUIConfig mainColor];
        self.endTimeLabel.font = [UIFont systemFontOfSize:12];

        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
            make.right.equalTo(self.contentView).offset(-20);
            make.height.equalTo(@20);
        }];
        
        self.detailLabel.textColor  = [GUIConfig grayFontColorLight];
        self.detailLabel.font = [UIFont systemFontOfSize:12];
        
        

        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.nameLabel.text= SafeString(self.data[@"title"]);
    self.detailLabel.text= SafeString(self.data[@"messageContent"]);
    self.endTimeLabel.text = SafeLeft(self.data[@"createdTime"],10);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
