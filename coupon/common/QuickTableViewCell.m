//
//  QuickTableViewCell.m
//  coupon
//
//  Created by chijr on 16/4/30.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "QuickTableViewCell.h"

@implementation QuickTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel = [UILabel new];
        [self.contentView addSubview:self.detailLabel];
        
        self.headLabel = [UILabel new];
        [self.contentView addSubview:self.headLabel];

        self.tailLabel = [UILabel new];
        [self.contentView addSubview:self.tailLabel];
 
        
        self.dateTimeLabel = [UILabel new];
        [self.contentView addSubview:self.dateTimeLabel];
        
        self.iconImageView = [UIImageView new];
        [self.contentView addSubview:self.iconImageView];
        
        
        
        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.layoutBlock) {
        self.layoutBlock(self);
    }
    
    
    
}

-(void)updateData{
    
    if (self.updateBlock) {
        self.updateBlock(self);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
