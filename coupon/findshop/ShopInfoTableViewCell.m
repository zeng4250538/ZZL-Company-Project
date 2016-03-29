//
//  PortalShopTableViewCell.m
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopInfoTableViewCell.h"
#import "HistoryOfConsumptionService.h"


@interface ShopInfoTableViewCell()

@property(nonatomic,strong)UIImageView *logoView;  //商店图片
@property(nonatomic,strong)UILabel *titleLabel;    //商店标题
@property(nonatomic,strong)UILabel *goodLabel ;   //顶
@property(nonatomic,strong)UIImageView *goodImageView ;
@property(nonatomic,strong)UIImageView *badImageView ;
@property(nonatomic,strong)UILabel *badLabel ;
@property(nonatomic,strong)UILabel *commentLabel ;  //备注
@property(nonatomic,strong)UIButton *subscribeButton ;  //订阅按钮

@end


@implementation ShopInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
 }


+(CGFloat)height{
    
   
    return 100;
    
    
}

+(UIView*)headerViewWithSort:(NSString*)title clickBlock:(void(^)())clickBlock{
    
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30+50)];
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
    
    
    
    UIView *sortBarView = [UIView new];
    sortBarView.backgroundColor = [UIColor whiteColor];
    
    sortBarView.frame = CGRectMake(0, 30, SCREEN_WIDTH, 50);
    [uv addSubview:sortBarView];
    
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, 79, SCREEN_WIDTH, 1);
    
    line.backgroundColor = [GUIConfig mainBackgroundColor];
    
    [uv addSubview:line];
    
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    filterButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 50);
    [filterButton setTitle:@"全部" forState:UIControlStateNormal];
    [sortBarView addSubview:filterButton];
    
    [filterButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
    
    
 
    UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sortButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 50);
    [sortButton setTitle:@"排序" forState:UIControlStateNormal];
    [sortBarView addSubview:sortButton];
    
    [sortButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = [GUIConfig mainBackgroundColor];

    line2.frame = CGRectMake(SCREEN_WIDTH/2, 10, 1, 30);
    
    [sortBarView addSubview:line2];
    
    
    [filterButton bk_addEventHandler:^(id sender) {
        
        UIActionSheet *as = [[UIActionSheet alloc] bk_initWithTitle:@""];
        
        [as bk_addButtonWithTitle:@"全部" handler:^{
            
            [filterButton setTitle:@"全部" forState:UIControlStateNormal];
            
        }];
  
        [as bk_addButtonWithTitle:@"美食" handler:^{
            
            [filterButton setTitle:@"美食" forState:UIControlStateNormal];
            
            
        }];
        
        [as bk_addButtonWithTitle:@"电影" handler:^{
            
            [filterButton setTitle:@"电影" forState:UIControlStateNormal];
            
            
        }];
        
        [as bk_addButtonWithTitle:@"美容" handler:^{
            
            [filterButton setTitle:@"美容" forState:UIControlStateNormal];
            
            
        }];
        
        [as bk_addButtonWithTitle:@"服饰" handler:^{
            
            [filterButton setTitle:@"服饰" forState:UIControlStateNormal];
            
            
        }];
        
     
      
        [as bk_setDestructiveButtonWithTitle:@"取消" handler:^{
            
        }];
        
        
        [as showInView:[UIApplication sharedApplication].keyWindow];
        
        
        UITapGestureRecognizer *tap =[UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            
            
            [as dismissWithClickedButtonIndex:0 animated:YES];
            
            
            
            
        }];
       
        
        [as.window addGestureRecognizer:tap];
       
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
   // [tap release];
    
    
    
    [sortButton bk_addEventHandler:^(id sender) {
        
        
        UIActionSheet *as = [[UIActionSheet alloc] bk_initWithTitle:@""];
        
        
        
        
        [as bk_addButtonWithTitle:@"默认排序" handler:^{
            
            
            [sortButton setTitle:@"默认排序" forState:UIControlStateNormal];
            
        }];
        
        
        [as bk_addButtonWithTitle:@"价格排序" handler:^{
            
            [sortButton setTitle:@"价格排序" forState:UIControlStateNormal];
            
            
        }];
        
        [as bk_addButtonWithTitle:@"金额排序" handler:^{
            
            [sortButton setTitle:@"金额排序" forState:UIControlStateNormal];
            
            
        }];
        
        [as bk_addButtonWithTitle:@"时间排序" handler:^{
            
            [sortButton setTitle:@"时间排序" forState:UIControlStateNormal];
            
            
        }];
        
        [as bk_setDestructiveButtonWithTitle:@"取消" handler:^{
            
        }];
        
        
        
         [as showInView:[UIApplication sharedApplication].keyWindow];
        

        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    return uv;
    
    
    
    
    
    
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
        self.titleLabel.font = [UIFont systemFontOfSize:12];
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
        
        
        self.subscribeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        self.subscribeButton.backgroundColor = [GUIConfig greenBackgroundColor];
        
        [self.subscribeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.subscribeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:self.subscribeButton];
        
        
        
        
        
        
        
        
        
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
        make.right.equalTo(self.contentView).with.offset(-10);
        make.bottom.equalTo(self.contentView).with.offset(-10);
    }];
    
    [self.commentLabel sizeToFit];
    
    
    
    
    [self.subscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.contentView).offset(-10);
        make.right.equalTo(self.contentView).offset(-10);
        
        
        
        
        
        
    }];
    
    [self.subscribeButton setTitle:@"取消订阅" forState:UIControlStateNormal];
    
    self.subscribeButton.hidden = YES;
    if (self.subscribeType == SubscribeTypeHave) {
        
        self.subscribeButton.hidden = NO;
        
        
    
    }
    
    
}


-(void)updateData{
    
    
   
    self.titleLabel.text = self.data[@"name"];
    self.goodLabel.text =[NSString stringWithFormat:@"%ld",[self.data[@"good"] integerValue]];
    self.badLabel.text =[NSString stringWithFormat:@"%ld",[self.data[@"bad"] integerValue]];
    self.commentLabel.text = self.data[@"prompt"];
    
    NSString *urlString = @"";
    
    if (self.data[@"couponSmallPhotoUrl"] != NULL) {
        urlString = self.data[@"couponSmallPhotoUrl"];
    }
    
    else if (self.data[@"smallPhotoUrl"] != NULL){
        urlString = self.data[@"smallPhotoUrl"];
    }
    
    else{
        urlString = self.data[@"smallPhotoUrl"];
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    urlString = [urlString stringByReplacingOccurrencesOfString:@"http://192.168.6.97:8080" withString:@"http://183.6.190.75:9780"];

    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self.logoView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self setNeedsLayout];
    }];
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
