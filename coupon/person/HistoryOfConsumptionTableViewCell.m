//
//  HistoryOfConsumptionTableViewCell.m
//  coupon
//
//  Created by ZZL on 16/3/23.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "HistoryOfConsumptionTableViewCell.h"

@interface HistoryOfConsumptionTableViewCell()

@property(strong,nonatomic)UIImageView *image;
@property(strong,nonatomic)UILabel *taitleLable;
@property(strong,nonatomic)UILabel *detailsTaitleLable;
@property(strong,nonatomic)UIButton *evaluationButton;
@end

@implementation HistoryOfConsumptionTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        _image = [[UIImageView alloc]init];
//        _image.backgroundColor = [UIColor whiteColor];
//        _image.image = [UIImage imageNamed:@"sampleImg001b.png"];
        
        
        [self.contentView addSubview:_image];
        
        _taitleLable = [[UILabel alloc]init];
//        _taitleLable.backgroundColor = [UIColor orangeColor];
        _taitleLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_taitleLable];
//        _taitleLable.text = @"咖啡陪你";
        
        _detailsTaitleLable = [[UILabel alloc]init];
//        _detailsTaitleLable.text = @"五折优惠券";
        [_detailsTaitleLable setFont:[UIFont systemFontOfSize:10]];
        [_detailsTaitleLable setTextColor:UIColorFromRGB(174, 174, 174)];
        [self.contentView addSubview:_detailsTaitleLable];
        
        _evaluationButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _evaluationButton.backgroundColor = UIColorFromRGB(294, 191, 66);
        [_evaluationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _evaluationButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _evaluationButton.layer.masksToBounds = YES;
        _evaluationButton.layer.cornerRadius = 5;
        [_evaluationButton setTitle:@"去评价" forState:UIControlStateNormal];
        [_evaluationButton addTarget:self action:@selector(evaluationButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_evaluationButton];
        
        
  
    
    }
    
    return self;

}

-(void)evaluationButtonClick{

    


}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
    }];
//    _image.backgroundColor = [UIColor whiteColor];
    
    [self.taitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@150);
        make.height.equalTo(@30);
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(90);
    }];
    
    [self.detailsTaitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@30);
        make.top.equalTo(self.contentView).offset(40);
        make.left.equalTo(self.contentView).offset(90);
    }];
    
    [self.evaluationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@45);
        make.height.equalTo(@24);
        make.top.equalTo(self.contentView).offset(58);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    _evaluationButton.backgroundColor = UIColorFromRGB(294, 191, 66);

    
}

#pragma mark ------- 加载数据
-(void)lodeData:(NSDictionary *)data{


    
    [_image sd_setImageWithURL:data[@"couponPhotoUrl"] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
//        [self setNeedsLayout];
        
    }];
    
    _taitleLable.text = data[@"shopName"];
    _detailsTaitleLable.text = data[@"couponName"];



//    [self.contentView reloadInputViews];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
