//
//  MyInformationViewController.m
//  coupon
//
//  Created by ZZL on 16/4/5.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "MyInformationViewController.h"
#import "AppShareData.h"
@interface MyInformationViewController ()

@property(nonatomic,strong)AppShareData *appShareData;
@property(nonatomic,strong)NSDictionary *dic;

@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self layoutView];
    [self.navigationItem setTitle:@"我的信息"];
    [self.tabBarController.tabBar setHidden:YES];
//    self.automaticallyAdjustsScrollViewInsets=NO;
}

-(void)loadData{

    self.appShareData = [AppShareData new];
    
    self.dic = [self.appShareData getMyInfromationData];
    

}

-(void)layoutView{

    UIImageView *backgroundView = [UIImageView new];
    backgroundView.backgroundColor = UIColorFromRGB(242, 242, 242);
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(63);
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        
    }];
    
    UIImageView *titleBackground = [UIImageView new];
    titleBackground.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:titleBackground];
    [titleBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(63);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@100);
        
    }];
    
    UILabel *headPortraitLabel = [UILabel new];
    headPortraitLabel.text = @"头像";
    headPortraitLabel.font = [UIFont systemFontOfSize:15];
    [titleBackground addSubview:headPortraitLabel];
    [headPortraitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleBackground).offset(35);
        make.left.equalTo(titleBackground).offset(25);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        
    }];
    
    UIImageView *headportraitView = [UIImageView new];
    [headportraitView sd_setImageWithURL:_dic[@"smallPhotoUrl"] placeholderImage:nil];
    headportraitView.layer.masksToBounds = YES;
    headportraitView.layer.cornerRadius = 80/2;
    headportraitView.backgroundColor = [UIColor orangeColor];
    [titleBackground addSubview:headportraitView];
    [headportraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleBackground).offset(10);
        make.right.equalTo(titleBackground).offset(-25);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        
    }];
    
    
    
   //------------------------>
    
    
    
    UIImageView *useBackground = [UIImageView new];
    useBackground.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:useBackground];
    [useBackground mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.equalTo(self.view).offset(164);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@50);
        
    }];
    
    UILabel *useLabel = [UILabel new];
    useLabel.text = @"用户名";
    useLabel.font = [UIFont systemFontOfSize:15];
    [useBackground addSubview:useLabel];
    [useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(useBackground).offset(10);
        make.left.equalTo(useBackground).offset(25);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        
    }];
    
    UILabel *useNameLabel = [UILabel new];
    useNameLabel.text = _dic[@"phoneMsisdn"];
    useNameLabel.textColor = UIColorFromRGB(200, 200, 200);
    useNameLabel.font = [UIFont systemFontOfSize:15];
    [useBackground addSubview:useNameLabel];
    [useNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(useBackground).offset(10);
        make.right.equalTo(useBackground).offset(-25);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        
    }];
    
    
    
    
    //------------------------->
    
    
    
    UIImageView *sexBackground = [UIImageView new];
    sexBackground.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:sexBackground];
    [sexBackground mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(215);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@50);
        
    }];
    
    
    UILabel *sexLabel = [UILabel new];
    sexLabel.text = @"性别";
    sexLabel.font = [UIFont systemFontOfSize:15];
    [sexBackground addSubview:sexLabel];
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(sexBackground).offset(10);
        make.left.equalTo(sexBackground).offset(25);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        
    }];
    
    UILabel *sexNameLabel = [UILabel new];
    sexNameLabel.text = _dic[@"gender"];
    sexNameLabel.textColor = UIColorFromRGB(200, 200, 200);
    sexNameLabel.font = [UIFont systemFontOfSize:15];
    [sexBackground addSubview:sexNameLabel];
    [sexNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(sexBackground).offset(10);
        make.right.equalTo(sexBackground).offset(-25);
        make.width.equalTo(@25);
        make.height.equalTo(@30);
        
    }];
    
    
    
    
    
    //------------------------>
    
    
    UIImageView *phoneBackground = [UIImageView new];
    phoneBackground.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:phoneBackground];
    [phoneBackground mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(266);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@50);
        
    }];
    
    
    UILabel *phoneLabel = [UILabel new];
    phoneLabel.text = @"手机号";
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [phoneBackground addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(phoneBackground).offset(10);
        make.left.equalTo(phoneBackground).offset(25);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        
    }];
    
    UILabel *phoneNumberLabel = [UILabel new];
    phoneNumberLabel.text = _dic[@"phoneMsisdn"];
    phoneNumberLabel.textColor = UIColorFromRGB(200, 200, 200);
    phoneNumberLabel.font = [UIFont systemFontOfSize:15];
    [phoneBackground addSubview:phoneNumberLabel];
    [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneBackground).offset(10);
        make.right.equalTo(phoneBackground).offset(-33);
        make.width.equalTo(@99);
        make.height.equalTo(@30);
        
    }];
    
    
    
    //------------------------>
    
    
    UIImageView *cityBackground = [UIImageView new];
    cityBackground.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:cityBackground];
    [cityBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(317);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@50);
        
    }];
    
    UILabel *cityLabel = [UILabel new];
    cityLabel.text = @"现居城市";
    cityLabel.font = [UIFont systemFontOfSize:15];
    [cityBackground addSubview:cityLabel];
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(cityBackground).offset(10);
        make.left.equalTo(phoneBackground).offset(25);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        
    }];
    
    UILabel *cityNameLabel = [UILabel new];
    cityNameLabel.text = _dic[@"cityName"];
    cityNameLabel.font = [UIFont systemFontOfSize:15];
    cityNameLabel.textColor = UIColorFromRGB(200, 200, 200);
    [cityBackground addSubview:cityNameLabel];
    [cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(cityBackground).offset(10);
        make.right.equalTo(cityBackground).offset(-25);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        
        
    }];



}

-(void)viewWillAppear:(BOOL)animated{

    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.automaticallyAdjustsScrollViewInsets=NO;


}

-(void)viewWillDisappear:(BOOL)animated{


    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.automaticallyAdjustsScrollViewInsets=YES;


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
