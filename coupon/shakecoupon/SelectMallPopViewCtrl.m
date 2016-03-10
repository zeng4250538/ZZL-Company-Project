//
//  SelectCityPopViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/1.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "SelectMallPopViewCtrl.h"
#import "SelectMallTableCtrl.h"
#import "ReloadHud.h"
#import "MallService.h"

@interface SelectMallPopViewCtrl ()

@end

@implementation SelectMallPopViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.view.backgroundColor =[UIColor colorWithWhite:0.1f alpha:0.7f];
    
    
    UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    touchButton.frame = self.view.frame;
    
    [self.view addSubview:touchButton];
    
    
    [touchButton bk_addEventHandler:^(id sender) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    [self makeTableView];
    
    
    
    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
        
        
        [self loadData];
        
        
        
    }];
    
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [GUIConfig tableViewGUIFormat:self.tableView];

    
    
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)loadData{
    
    
    
    MallService *service = [[MallService alloc] init];
    
    [service queryMallByNear:@"广州" lon:113.1234 lat:23.1234 success:^(NSInteger code, NSString *message, id data) {
        
        
       // [ReloadHud re:self.tableView];
        
  //      [ReloadHud showReloadMode:self.tableView];
        
        [ReloadHud removeHud:self.tableView animated:YES];
        
        self.mallList = data;
        
        [self.tableView reloadData];
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        [ReloadHud showReloadMode:self.tableView];
        
        
        
        
        
    }];
    
    
//    
//    self.mallList = @[@{@"mall":@"天河城",
//                        @"distance":@"100米"
//                        },
//                      @{@"mall":@"正佳",
//                        @"distance":@"200米"
//                        },
//                      @{@"mall":@"高德置地",
//                        @"distance":@"2000米"
//                        },
//                      @{@"mall":@"全城",
//                        @"distance":@""
//                        }
//                      
//                      
//                      ];
//    
//    
//    
//    [ReloadHud showReloadMode:self.tableView];
//    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    //隐藏导航栏
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    
    [self loadData];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.translucent = YES;
    
    
    
    
    
    
}




-(void)makeTableView{
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.layer.cornerRadius = 6;
    self.tableView.clipsToBounds = YES;
    
    
    
    
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@(40*4+60));
        make.width.equalTo(@(SCREEN_WIDTH-100));
        
        
    }];
    
    
    
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 40)];
        headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *headLabel = [UILabel new];
        [headView addSubview:headLabel];
        
        headLabel.text=@"选择商城";
        
        headLabel.font = [UIFont systemFontOfSize:16];
        headLabel.textColor = [GUIConfig mainColor];
        
        [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(headView).offset(15);
            make.height.equalTo(headView);
            make.width.equalTo(headView);
            
            
        }];
        
        
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreButton setTitle:@"更多" forState:UIControlStateNormal];
        moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [moreButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
        
        [headView addSubview:moreButton];
        
        [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headView);
            make.width.equalTo(@60);
            make.height.equalTo(headView);
            
        }];
        
        
        [moreButton bk_addEventHandler:^(id sender) {
            
            
            SelectMallTableCtrl *vc = [SelectMallTableCtrl new];
            
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
            
            
            
    
            
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [headView addSubview:lineView];
        lineView.backgroundColor = [GUIConfig mainColor];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(headView);
            make.height.equalTo(@2);
            make.bottom.equalTo(headView).offset(-2);
        }];
        
        
        self.tableView.tableHeaderView = headView;
    }

    
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    
    
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.mallList count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *uv in [cell.contentView subviews]) {
        [uv removeFromSuperview];
    }
    
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(15);
        make.width.equalTo(@200);
        
    }];
    
    NSDictionary *mallDict = self.mallList[[indexPath row]];
    
    
    nameLabel.text=mallDict[@"name"];
    

    UILabel *distanceLabel = [UILabel new];
    distanceLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView);
        make.height.equalTo(cell.contentView);
        make.width.equalTo(@100);
        
    }];
    distanceLabel.textColor = [GUIConfig grayFontColor];
    
    distanceLabel.text=[NSString stringWithFormat:@"%@",mallDict[@"distance"]];
    
   // mallDict[@"distance"];

    

   // cell.textLabel.text=@"选择城市";
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSDictionary *mallDict = self.mallList[[indexPath row]];
    
    [AppShareData instance].currentMall = mallDict;

    
    [self dismissViewControllerAnimated:NO completion:^{
        
        if (self.selectMallBlock) {
            self.selectMallBlock(YES,mallDict);
        
        }
        
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
