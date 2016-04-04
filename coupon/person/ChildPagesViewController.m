//
//  ChildPagesViewController.m
//  coupon
//
//  Created by ZZL on 16/3/27.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ChildPagesViewController.h"

@interface ChildPagesViewController ()

@end

@implementation ChildPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutView];
    
}

-(void)layoutView{
    
    

    UIImageView *backgroundView = [[UIImageView alloc]init];
    backgroundView.backgroundColor = UIColorFromRGB(242, 242, 242);
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(63);
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        
    }];
    
    UIImageView *titleBackgroundView = [[UIImageView alloc]init];
    titleBackgroundView.backgroundColor = UIColorFromRGB(255, 255, 255);
    [backgroundView addSubview:titleBackgroundView];
    [titleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(0);
        make.left.equalTo(backgroundView).offset(0);
        make.right.equalTo(backgroundView).offset(0);
        make.height.equalTo(@100);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [titleBackgroundView addGestureRecognizer:tap];
    
    UIImageView *titelImageView = [[UIImageView alloc]init];
    [titelImageView sd_setImageWithURL:self.data[@"couponPhotoUrl"] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self reloadInputViews];
    }];
    titelImageView.backgroundColor = [UIColor whiteColor];
    [titleBackgroundView addSubview:titelImageView];
    [titelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBackgroundView).offset(20);
        make.left.equalTo(titleBackgroundView).offset(20);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    UILabel *titelLabelView = [[UILabel alloc]init];
    titelLabelView.text = self.data[@"shopName"];
    [titelLabelView setFont:[UIFont systemFontOfSize:12]];
    [titleBackgroundView addSubview:titelLabelView];
    [titelLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBackgroundView).offset(20);
        make.left.equalTo(titleBackgroundView).offset(90);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    UILabel *subTibleLabel = [[UILabel alloc]init];
    subTibleLabel.text = self.data[@"couponName"];
    [subTibleLabel setFont:[UIFont systemFontOfSize:9]];
    subTibleLabel.textColor = UIColorFromRGB(176, 176, 176);
    [titleBackgroundView addSubview:subTibleLabel];
    [subTibleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBackgroundView).offset(40);
        make.left.equalTo(titleBackgroundView).offset(90);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    UILabel *statementLabel = [[UILabel alloc]init];
    statementLabel.text = @"消费明细";
    [statementLabel setFont:[UIFont systemFontOfSize:12]];
    statementLabel.textColor = UIColorFromRGB(179, 179, 179);
    [backgroundView addSubview:statementLabel];
    [statementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(100);
        make.left.equalTo(titleBackgroundView).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    UIImageView *towBackgroundView = [[UIImageView alloc]init];
    towBackgroundView.backgroundColor = UIColorFromRGB(255, 255, 255);
    [backgroundView addSubview:towBackgroundView];
    [towBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(130);
        make.left.equalTo(backgroundView).offset(0);
        make.right.equalTo(backgroundView).offset(0);
        make.height.equalTo(@200);
    }];
    
    UILabel *consumptionAmountLabel = [[UILabel alloc]init];
    consumptionAmountLabel.text  = @"消费金额：100元";
    [consumptionAmountLabel setFont:[UIFont systemFontOfSize:11]];
    [towBackgroundView addSubview:consumptionAmountLabel];
    [consumptionAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(towBackgroundView).offset(10);
        make.left.equalTo(towBackgroundView).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
    UILabel *amountOfRealPayLabel = [[UILabel alloc]init];
    amountOfRealPayLabel.text = @"实付金额：50元";
    [amountOfRealPayLabel setFont:[UIFont systemFontOfSize:11]];
    [towBackgroundView addSubview:amountOfRealPayLabel];
    [amountOfRealPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(towBackgroundView).offset(40);
        make.left.equalTo(towBackgroundView).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
    UILabel *methodOfPaymentLable = [[UILabel alloc]init];
    methodOfPaymentLable.text = @"支付方式：支付宝";
    [methodOfPaymentLable setFont:[UIFont systemFontOfSize:11]];
    [towBackgroundView addSubview:methodOfPaymentLable];
    [methodOfPaymentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(towBackgroundView).offset(70);
        make.left.equalTo(towBackgroundView).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"时间：2016-3-11 16：02";
    [timeLabel setFont:[UIFont systemFontOfSize:11]];
    [towBackgroundView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(towBackgroundView).offset(100);
        make.left.equalTo(towBackgroundView).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
    UIButton *toEvaluateButtonView = [[UIButton alloc]init];
    toEvaluateButtonView.backgroundColor = [UIColor orangeColor];
    [toEvaluateButtonView setTitle:@"去评价" forState:UIControlStateNormal];
    [backgroundView addSubview:toEvaluateButtonView];
    [toEvaluateButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(20);
        make.right.equalTo(backgroundView).offset(-20);
        make.bottom.equalTo(backgroundView).offset(-50);
        make.height.equalTo(@40);
    }];
    
    
    
    

}

-(void)lodeData:(NSDictionary *)data{



}

-(void)cilck{

    [self presentViewController:nil animated:NO completion:nil];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
