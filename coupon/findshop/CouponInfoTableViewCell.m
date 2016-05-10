//
//  ShopCouponTableViewCell.m
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponInfoTableViewCell.h"
#import "ToPayTableViewCtrl.h"

@interface CouponInfoTableViewCell()
@property(nonatomic,strong)UIImageView *logoView;  //商店图片
@property(nonatomic,strong)UILabel *titleLabel;    //优惠券标题
@property(nonatomic,strong)UILabel *addtionLabel;    //额外说明
@property(nonatomic,strong)UILabel *detailLabel;    //明细
//@property(nonatomic,strong)UILabel *priceLabel;    //价格
@property(nonatomic,strong)UIButton *recommentButton;    //提醒按钮
@property(nonatomic,strong)UILabel *timeLabel;







@end


@implementation CouponInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        self.logoView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.logoView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textColor = [GUIConfig grayFontColorDeep];
        
        [self.contentView addSubview:self.titleLabel];
        
        
        self.detailLabel = [UILabel new];
        self.detailLabel.font = [UIFont systemFontOfSize:12];
        self.detailLabel.textColor = [GUIConfig grayFontColor];
        
        [self.contentView addSubview:self.detailLabel];
        
//        self.priceLabel = [UILabel new];
//        self.priceLabel.textColor = [GUIConfig mainColor];
//        self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
//        
//        [self.contentView addSubview:self.priceLabel];
        
        self.recommentButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self.contentView addSubview:self.recommentButton];
        
        
        self.couponStatusLabel = [UILabel new];
        self.couponStatusLabel.font = [UIFont systemFontOfSize:13];
        self.couponStatusLabel.textColor = [UIColor redColor];
        
        [self.contentView addSubview:self.couponStatusLabel];
        
        
        [self.recommentButton bk_addEventHandler:^(id sender) {
            
            
            
            if (self.couponActionType == CouponTypeLimited) {
                
                [self.recommentButton setTitle:@"取消提醒" forState:UIControlStateNormal];
                
                self.couponActionType = CouponTypeUnLimited;
            }else if(self.couponActionType == CouponTypeUnLimited){
          
                [self.recommentButton setTitle:@"提醒" forState:UIControlStateNormal];
                self.couponActionType = CouponTypeLimited;
                
                
            }
            
            if (self.doActionBlock) {
                self.doActionBlock(nil);
                
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.timeLabel = [UILabel new];
        
        [self.contentView addSubview:self.timeLabel];
        
        self.timeLabel.font = [UIFont boldSystemFontOfSize:9];
        self.timeLabel.text=@"12:11:33";
        self.timeLabel.textColor = [GUIConfig mainColor];
        
        
        
        NSTimer *timer = [NSTimer bk_scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
            
            
            [Utils downCountLabel:self.timeLabel];
            
        } repeats:YES];
        
        [timer fire];
        
        
        self.couponStatusLabel = [UILabel new];
        
        self.couponStatusLabel.textColor = [GUIConfig mainColor];
        self.couponStatusLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.couponStatusLabel];
        
    }
    
    return self;
    
}


-(void)updateTime{
    
    
    
    
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
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
//        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
    }];
    
    
    [self.couponStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@20);
        make.left.equalTo(self.contentView.mas_right).with.offset(-80);
        make.width.equalTo(@50);
        make.top.equalTo(self.titleLabel);
      //  make.centerY.equalTo(self.contentView);
        
    }];
    
    

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.width.equalTo(@70);
        make.top.equalTo(self.contentView).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-30);
        
    }];
    
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    
    
    [self.recommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@25);
        make.width.equalTo(@60);
        make.bottom.equalTo(self.logoView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
    }];
    
    self.recommentButton.backgroundColor = UIColorFromRGB(40, 162, 123);
    
    self.recommentButton.layer.cornerRadius = 4;
    self.recommentButton.clipsToBounds = YES;
    self.recommentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.recommentButton setTitle:@"提醒" forState:UIControlStateNormal];
    [self.recommentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (self.couponActionType == CouponTypeNormal) {
        self.recommentButton.hidden = YES;
 
    }
    else if (self.couponActionType == CouponTypeLimited) {
            self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"提醒" forState:UIControlStateNormal];

    }
    else if (self.couponActionType == CouponTypeUnLimited) {
        self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"取消提醒" forState:UIControlStateNormal];
    
    }
    else if (self.couponActionType == CouponTypeToPay) {
        self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"支付" forState:UIControlStateNormal];
        
        
     
    }
    else if (self.couponActionType == CouponTypeToUse) {
        self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"退款" forState:UIControlStateNormal];
    
    }
    else if (self.couponActionType == CouponTypeToComment) {
        self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"去评论" forState:UIControlStateNormal];
        
       
            
    }
    else if (self.couponActionType == CouponTypeToUnPay) {
        self.recommentButton.hidden = NO;
        
        [self.recommentButton setTitle:@"退款" forState:UIControlStateNormal];
        
        

        
    }
    else{
        self.recommentButton.hidden = NO;
    }
    
    
    if (self.couponActionType == CouponTypeLimited || self.couponActionType == CouponTypeUnLimited) {
        
        self.timeLabel.hidden = NO;
    }else{
        
        self.timeLabel.hidden = YES;
    }
    
}



+(UIView*)headerView:(NSString*)title clickBlock:(void(^)())touchBlock{
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [uv addSubview:touchButton];
    
    [touchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uv.mas_top).offset(20);
        make.left.equalTo(uv.mas_left);
        make.right.equalTo(uv.mas_right);
        make.bottom.equalTo(uv.mas_bottom);
        
    }];
    
    [touchButton bk_addEventHandler:^(id sender) {
        if (touchBlock) {
            touchBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    touchButton.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLabel  = [UILabel new];
    [touchButton addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(touchButton.mas_top);
        make.left.equalTo(touchButton.mas_left).offset(15);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
        
    }];
    nameLabel.text=title;
    nameLabel.textColor = [GUIConfig grayFontColor];
    nameLabel.font = [UIFont systemFontOfSize:14];
    
    
    UILabel *moreLabel = [UILabel new];
    [touchButton addSubview:moreLabel];
    [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(touchButton);
        make.top.equalTo(touchButton.mas_top);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        
    }];
    
    moreLabel.text = @"更多>>";
    moreLabel.font = [UIFont systemFontOfSize:14];
    moreLabel.textColor = [GUIConfig grayFontColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 60, SCREEN_WIDTH, 1)];
    line.backgroundColor = [GUIConfig mainBackgroundColor];
    
    [uv addSubview:line];
    
    return uv;
    
}


+(CGFloat)height{
    
    return 100.0f;
    
}




-(void)updateData{
    
    
    
    
    
    NSURL *url =SafeUrl(self.data[@"smallPhotoUrl"]);
    
    
    [self.logoView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [self setNeedsLayout];
        
    }];
    
    self.titleLabel.text=SafeString(self.data[@"name"]);
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
