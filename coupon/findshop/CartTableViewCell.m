//
//  ShopCouponTableViewCell.m
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CartTableViewCell.h"
#import "NumSpanView.h"

@interface CartTableViewCell()
@property(nonatomic,strong)UIImageView *logoView;  //商店图片
@property(nonatomic,strong)UILabel *titleLabel;    //优惠券标题
@property(nonatomic,strong)UILabel *addtionLabel;    //额外说明
@property(nonatomic,strong)UILabel *detailLabel;    //明细
@property(nonatomic,strong)UILabel *priceLabel;    //价格
@property(nonatomic,strong)UIButton *checkButton;









@end


@implementation CartTableViewCell

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
        self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.detailLabel.numberOfLines = 0;
        
        [self.contentView addSubview:self.detailLabel];
        
        self.priceLabel = [UILabel new];
        self.priceLabel.textColor = [GUIConfig mainColor];
        self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
        
        [self.contentView addSubview:self.priceLabel];
        
        self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.checkButton.selected = YES;
        
       // self.checkButton setImage:[] forState:<#(UIControlState)#>
        
        
        [self.checkButton setImage:[UIImage imageNamed:@"CellNotSelected@2x.png"] forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"CellRedSelected@2x.png"] forState:UIControlStateSelected];
        
        
        [self.checkButton bk_addEventHandler:^(id sender) {
            
            self.checkButton.selected = !self.checkButton.selected;
            
            if (self.checkButton.selected) {
                self.data[@"isSelected"] =@1;
                
            }else{
                
                self.data[@"isSelected"]=@0;
            }
            
            //
            if (self.dataUpdateBlock) {
                
                self.dataUpdateBlock();
            }
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView addSubview:self.checkButton];
        
        
        self.spanButton = [[NumSpanView alloc] initWithFrame:CGRectMake(0, 0, 90, 25)];
        
        [self.contentView addSubview:self.spanButton];
        self.spanButton.num=1;
        self.data[@"num"]=@1;
        
        
        
        __weak CartTableViewCell *weakSelf= self;
        
        self.spanButton.block = ^(NSInteger num){
            
            weakSelf.data[@"num"]=@(num);
            
            [weakSelf updatePrice];
            
            if (weakSelf.dataUpdateBlock) {
                
                weakSelf.dataUpdateBlock();
            }
            
            
            
        };
        
        
        
       

        
        
        
        
    }
    
    
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.checkButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(5);
//        make.width.equalTo(@30);
//        make.height.equalTo(@30);
//        
        
    }];
    
    
    
    [self.logoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(40);
        make.size.mas_equalTo(CGSizeMake(100, 80));
        
        
    }];
    
    
    
    
    

    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
    }];
    
    

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(2);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
    }];
    
    
    
    [self.spanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.width.equalTo(@90);
        
        make.left.equalTo(self.logoView.mas_right).with.offset(10);
        make.bottom.equalTo(self.logoView.mas_bottom);
        
    }];
    
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.left.equalTo(self.spanButton.mas_right).with.offset(20);
        make.bottom.equalTo(self.logoView.mas_bottom);
        
    }];
    
    [self.priceLabel sizeToFit];
    
    
    
    
    
    
    
}





+(CGFloat)height{
    
    return 100.0f;
    
}






-(void)updateData{
    
    
    
    
    self.logoView.image = [UIImage imageNamed:self.data[@"icon"]];
    self.titleLabel.text=self.data[@"name"];
    
    
   self.detailLabel.text=self.data[@"prompt"];
    
    [self updatePrice];
    
    
    
}

-(void)setData:(NSMutableDictionary *)data{
    
    if (data[@"num"]==nil) {
        
        data[@"num"]=@1;
    }
    
    if (data[@"isSelected"]==nil) {
        
        data[@"isSelected"]=@1;
    }
    
    
    
    _data = data;
    
}


-(void)updatePrice{
    
    NSInteger num = [self.data[@"num"] integerValue];
    
    
    
    CGFloat price = [self.data[@"price"] floatValue];
    
    
    
    self.priceLabel.text=[NSString stringWithFormat:@"￥%.2f",num*price];
    
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
