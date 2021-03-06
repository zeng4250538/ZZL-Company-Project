//
//  ShopCouponTableViewCell.m
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "SubTableViewCell.h"
#import "ToPayTableViewCtrl.h"

@interface SubTableViewCell()
@property(nonatomic,strong)UIImageView *logoView;  //商店图片
@property(nonatomic,strong)UILabel *titleLabel;    //优惠券标题
@property(nonatomic,strong)UILabel *addtionLabel;    //额外说明
@property(nonatomic,strong)UILabel *detailLabel;    //明细
@property(nonatomic,strong)UILabel *priceLabel;    //价格
@property(nonatomic,strong)UIButton *recommentButton;    //提醒按钮

@end


@implementation SubTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        self.logoView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.logoView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [GUIConfig grayFontColorDeep];
        
        [self.contentView addSubview:self.titleLabel];
        
        
        self.detailLabel = [UILabel new];
        self.detailLabel.font = [UIFont systemFontOfSize:12];
        self.detailLabel.textColor = [GUIConfig grayFontColor];
        
        [self.contentView addSubview:self.detailLabel];
        
        self.priceLabel = [UILabel new];
        self.priceLabel.textColor = [GUIConfig mainColor];
        self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
        
        [self.contentView addSubview:self.priceLabel];
        
        self.recommentButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self.contentView addSubview:self.recommentButton];
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 80));
        
        
    }];
    
    

    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
    }];
    
    

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-90);
        
    }];
    
    self.detailLabel.numberOfLines=0;
    self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.bottom.equalTo(self.logoView.mas_bottom);
        
    }];
    
    
    self.priceLabel.hidden = YES;
    
    
    [self.recommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@30);
        make.width.equalTo(@60);
        make.bottom.equalTo(self.logoView.mas_bottom).offset(-25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
    }];
    
    self.recommentButton.backgroundColor = UIColorFromRGB(40, 162, 123);
    
    self.recommentButton.layer.cornerRadius = 4;
    self.recommentButton.clipsToBounds = YES;
    self.recommentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.recommentButton setTitle:@"取消订阅" forState:UIControlStateNormal];
    [self.recommentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    if (self.couponType == CouponTypeNormal) {
        self.recommentButton.hidden = YES;
 
    }else if (self.couponType == CouponTypeLimited) {
            self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"提醒" forState:UIControlStateNormal];

    }else if (self.couponType == CouponTypeToPay) {
        self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"支付" forState:UIControlStateNormal];
        
        
        [self.recommentButton bk_addEventHandler:^(id sender) {
            
            if (self.payBlock) {
                self.payBlock(nil);
                
            }
            
            
            
            
            
        } forControlEvents:UIControlEventTouchUpInside];

    }else if (self.couponType == CouponTypeToUse) {
        self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"退款" forState:UIControlStateNormal];
    
        
    }else{
        self.recommentButton.hidden = NO;
    }
    
    
    self.recommentButton.hidden = NO;
    
    
    
    
    
}



+(UIView*)headerView:(NSString*)title{
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uv addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uv.mas_top).offset(20);
        make.left.equalTo(uv.mas_left);
        make.right.equalTo(uv.mas_right);
        make.bottom.equalTo(uv.mas_bottom);
        
    }];
    
    
    btn.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel *nameLabel  = [UILabel new];
    
    [btn addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(btn.mas_top);
        make.left.equalTo(btn.mas_left).offset(15);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
        
    }];
    nameLabel.text=title;
    nameLabel.textColor = [GUIConfig mainColor];
    nameLabel.font = [UIFont systemFontOfSize:14];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH, 1)];
    line.backgroundColor = [GUIConfig mainBackgroundColor];
    
    [uv addSubview:line];
    
    
    
    
    return uv;
    
}


+(CGFloat)height{
    
    return 100.0f;
    
}


-(void)updateData{
   
    NSString *imgUrl = [Utils getRandomImage:@"商家图片"];
    self.logoView.image = [UIImage imageNamed:imgUrl];
    self.titleLabel.text=@"代金券";
    self.priceLabel.text=@"20";
    self.detailLabel.text=@"满100送20，全天通用，消费满100";
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
