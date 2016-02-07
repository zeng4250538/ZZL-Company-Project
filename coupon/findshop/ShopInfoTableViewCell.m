//
//  PortalShopTableViewCell.m
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopInfoTableViewCell.h"


@interface ShopInfoTableViewCell()

@property(nonatomic,strong)UIImageView *logoView;  //商店图片
@property(nonatomic,strong)UILabel *titleLabel;    //商店标题
@property(nonatomic,strong)UILabel *goodLabel ;   //顶
@property(nonatomic,strong)UIImageView *goodImageView ;
@property(nonatomic,strong)UIImageView *badImageView ;

@property(nonatomic,strong)UILabel *badLabel ;
@property(nonatomic,strong)UILabel *commentLabel ;  //备注







@end


@implementation ShopInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
 }


+(CGFloat)height{
    
   
    return 100;
    
    
}

+(UIView*)headerView:(NSString*)title clickBlock:(void(^)())clickBlock{
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH/2, 30)];
    lab.textColor = [GUIConfig grayFontColorDeep];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = title;
    
    [uv addSubview:lab];
    
    
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreButton setTitle:@"更多 >>" forState:UIControlStateNormal];
    
    moreButton.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 30);
    moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [moreButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    [uv addSubview:moreButton];
    
    [moreButton bk_addEventHandler:^(id sender) {
        
        if (clickBlock) {
            clickBlock();

            
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    return uv;
    
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.logoView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.logoView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [GUIConfig grayFontColorDeep];
        
        [self.contentView addSubview:self.titleLabel];
        
        self.goodLabel = [[UILabel alloc] init];
        self.goodLabel.textColor = [GUIConfig grayFontColor];
        self.goodLabel.font = [UIFont systemFontOfSize:12];
        
        
        [self.contentView addSubview:self.goodLabel];
        
        self.goodImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good_icon"]];
        
        [self.contentView addSubview:self.goodImageView];
        
    
        self.badImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bad_icon"]];
        
        [self.contentView addSubview:self.badImageView];
        
        
        self.badLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.badLabel];
        self.badLabel.font = [UIFont systemFontOfSize:12];
        
        self.badLabel.textColor = [GUIConfig grayFontColor];
        
        
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.font = [UIFont systemFontOfSize:12];
        self.commentLabel.numberOfLines = 0;
        self.commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.commentLabel.textColor = [GUIConfig grayFontColor];
        
        
        [self.contentView addSubview:self.commentLabel];
        
        
        
        
        
        
        
        
    }
    return self;
}




-(void)layoutSubviews{
    
    [super layoutSubviews];
    
  //  self.logoView.frame = CGRectMake(10, 10, 120, 80);
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 80));
        

    }];
    
    
//self.titleLabel.frame= CGRectMake(140, 10, SCREEN_WIDTH-260-10, 20);
 
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
    }];
    
   // self.goodLabel.frame = CGRectMake(140, 30, 60, 20);
    
    [self.goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
        
    }];

    
    [self.goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@20);
        make.width.equalTo(@60);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.goodImageView.mas_right).with.offset(10);
        
        
    }];
    
    
    [self.badImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodLabel.mas_right).with.offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
        
    }];

    [self.badLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@20);
        make.width.equalTo(@60);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.badImageView.mas_right).with.offset(10);
        
        
    }];
    
    
     
    //self.commentLabel.frame = CGRectMake(140, 50, 60, 20);
    
   // self.commentLabel.backgroundColor=[UIColor yellowColor];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.top.equalTo(self.badLabel.mas_bottom).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
    }];
    
    [self.commentLabel sizeToFit];
    
}


-(void)updateData{
    
   // NSString *urlString = self.data[@"imgurl"];
    
    
    self.titleLabel.text = self.data[@"name"];
    
    self.goodLabel.text =[NSString stringWithFormat:@"%ld",[self.data[@"goodcount"] integerValue]];
    
    self.badLabel.text =[NSString stringWithFormat:@"%ld",[self.data[@"badcount"] integerValue]];
    
    self.commentLabel.text = self.data[@"prompt"];
    
    NSString *urlString = self.data[@"icon"];
    
    
    
    
    self.logoView.image = [UIImage imageNamed:urlString];
    
    
    
    
    
   // [Utils getImagePath:@"商家图片"];
    
    
    
    
    
//    NSURL *url = [NSURL fileURLWithPath:@""];
//    
//    
//    [self.logoView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
