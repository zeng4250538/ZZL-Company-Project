//
//  MallShopCommentViewController.m
//  coupon
//
//  Created by ZZL on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "MallShopCommentViewController.h"
#import "ShopCommentSevice.h"
#import "MallShopCommentTableViewCell.h"
@interface MallShopCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableViews;
@property(nonatomic,strong)MallShopCommentTableViewCell *cells;
@property (nonatomic,strong) ShopCommentSevice *shopSevices;
@property (nonatomic,strong) NSArray *dataArrays;

@end

@implementation MallShopCommentViewController

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"---我的商店数据---%@",_shopId);
    [SVProgressHUD show];
    
    [self loadData];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [SVProgressHUD dismiss];
    
}

- (void)viewDidLoad {
    _shopSevices = [ShopCommentSevice new];
    [super viewDidLoad];
    self.navigationItem.title=@"商店评价";
    [self layouView];
    // Do any additional setup after loading the view.
    
}

-(void)loadData{
    //http://183.6.190.75:9780/diamond-sis-web/v1/shop/14/review?page=1&per_page=10&sort=-time
    NSDictionary *parma = @{@"page":@"1",@"per_page":@"10",@"sort":@"-time"};
    [_shopSevices ShopCommentRequestDictionary:parma shopID:_shopId success:^(id data) {
        [SVProgressHUD dismiss];
        NSLog(@"-----------商店评价数据------------%@",data);
        _dataArrays = data;
        [_tableViews reloadData];
    } failure:^(id coad) {
        
        [SVProgressHUD dismiss];
        
    }];
    
    
    
    
}

-(void)layouView{
    
    
    _tableViews = [UITableView new];
    [self.view addSubview:_tableViews];
    _tableViews.dataSource = self;
    _tableViews.delegate = self;
    [_tableViews mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        
    }];
    _tableViews.separatorStyle = UITableViewCellSelectionStyleNone;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArrays.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    _cells = [tableView dequeueReusableCellWithIdentifier:identify];
    if (_cells == nil) {
        _cells = [[MallShopCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [_cells data:_dataArrays[indexPath.row]];
    return _cells;
    
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
