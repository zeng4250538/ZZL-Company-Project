//
//  UISearchViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/17.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "KeyWordSearchViewCtrl.h"
#import "SearchResultViewCtrl.h"
#import "ShopService.h"
#import "SearchShopService.h"
#import "ShopInfoViewCtrl.h"
#import "HotSaerchSevice.h"
@interface KeyWordSearchViewCtrl ()<UISearchDisplayDelegate>

@property(nonatomic,strong)NSArray *hotWordList;

@property(nonatomic,strong)NSArray *searchWordList;

@property(nonatomic,strong)UISearchDisplayController *displayCtrl;

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,assign)BOOL isLoading;

@property(nonatomic,assign)BOOL historyBool;

@end

@implementation KeyWordSearchViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _historyBool = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
   // self.navigationItem.title=@"关键字搜索";
    
    [self loadData];
    
    [self makeHeaderView];
    
    
    self.navigationItem.hidesBackButton = YES;
    
    [self.navigationItem setLeftBarButtonItem:nil];
    
    
    
    [self makeSearchBar];
    
    [self makeDisplayCtrl];
    
    
    [self.displayCtrl.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}





-(void)loadData{
    HotSaerchSevice *HSS = [HotSaerchSevice new];
     NSMutableArray *dataArray = [[NSMutableArray alloc]init];;
//    NSLog(@"asdasdasdasdasdasd>>>>>>>>>>>>>>%@>>>",[AppShareData instance].mallCityName);
    [HSS hotSearchRequest:SafeString([AppShareData instance].mallId) withPage:@"1" withPageCount:@"9" withCityName:SafeString([AppShareData instance].mallCityName) success:^(id data) {
        
        NSMutableArray *muData = [data mutableCopy];
       
        for (int i = 0; i<muData.count; i++) {
            [dataArray addObject:muData[i][@"keyword"]];
        }
        [self hotDataLoadData:dataArray];
    } failure:^(id data) {
        
    }];
   

    
}

-(void)hotDataLoadData:(id)data{

    self.hotWordList = data;
    [self makeHeaderView];
    [self.tableView reloadData];
//    NSLog(@"哈哈哈哈哈asdasdasdasdasdasd>>>>>>>>>>>>>>%@>>>",self.hotWordList);

}

-(void)makeDisplayCtrl{
    
    self.displayCtrl = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.displayCtrl.delegate = self;
    
    self.displayCtrl.searchResultsDataSource = self;
    
    self.displayCtrl.searchResultsDelegate = self;
    
    self.displayCtrl.displaysSearchBarInNavigationBar = YES;
    
    [GUIConfig tableViewGUIFormat:self.tableView];
    
    [GUIConfig tableViewGUIFormat:self.displayCtrl.searchResultsTableView];
    
}


-(void)makeSearchBar{
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-160, 44)];
    
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleProminent;
    
    searchBar.showsCancelButton = YES;

    self.searchBar = searchBar;
 
    searchBar.placeholder=@"搜索优惠券";
    
    NSLog(@"qweqwe%@",searchBar.text);
    
    
}

-(void)makeHeaderView{
    
    NSInteger column = 3;
    
    CGFloat buttonWidth = 80;
  
    CGFloat buttonHeight = 35;
    
    CGFloat columnHeight = 50;
    
    UIView *bgView = [[UIView alloc] init];
    
    bgView.backgroundColor = [UIColor whiteColor];
    
    NSInteger row = ceil([self.hotWordList count]*1.0f / column*1.0f);
    
    CGFloat height = row*columnHeight+40;
    
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH,height);
    
    CGFloat space = (SCREEN_WIDTH - column*buttonWidth)/(column+1);
    
    int pos = 0;
    
    for (NSString *title in self.hotWordList) {
        
        CGFloat x = (space*(pos%column+1)+(pos%column)*buttonWidth);
        
        CGFloat y =20+columnHeight* (pos/column);
        
        UIButton *hotWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        hotWordButton.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
        
        hotWordButton.layer.borderWidth=1;
        
        hotWordButton.layer.borderColor = [[GUIConfig mainBackgroundColor] CGColor];
        
        [hotWordButton setTitle:title forState:UIControlStateNormal];
        
        [hotWordButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
        
        [hotWordButton bk_addEventHandler:^(id sender) {
            
            
            UIButton *button = (UIButton*)sender;
            
            SearchResultViewCtrl *vc =[SearchResultViewCtrl new];
            vc.keyWord = button.titleLabel.text;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [bgView addSubview:hotWordButton];
        
        hotWordButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        pos++;
        
        
    }
    
    self.tableView.tableHeaderView = bgView;
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (self.isLoading) {
        return ;
    }
    NSLog(@"搜索关键字：%@",searchText);
    self.isLoading = YES;
    
    ShopService *service = [ShopService new];
    
   AppShareData *app = [AppShareData instance];
    
    [service requestKeyword:app.mallId
                    keyWord:searchText
                    success:^(NSInteger code, NSString *message, id data) {
                        
                        self.searchWordList = data;
                        
                        self.isLoading = NO;
                        
//                        NSLog(@"%@",data);
                        [self.displayCtrl.searchResultsTableView reloadData];
                        
                    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                        
                        
                        self.isLoading = NO;
                        
                    }];
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SearchResultViewCtrl *vc =[SearchResultViewCtrl new];
    vc.keyWord = searchBar.text;
    [[AppShareData instance]searchShopName:searchBar.text];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{                     // called when cancel

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.displayCtrl.searchResultsTableView) {
        return 0;
    }
    return 30;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab = [UILabel new];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [GUIConfig grayFontColor];
    lab.text = @"   历史记录";
    lab.backgroundColor = [GUIConfig mainBackgroundColor];
    lab.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    
    return  lab;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.displayCtrl.searchResultsTableView) {
        return 0;
    }
    if ([[AppShareData instance].searchShopNameData count]==0) {
        return 0;
    }
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIButton *cleanButton = [[UIButton alloc]init];
    cleanButton.titleLabel.textColor = UIColorFromRGB(180, 180, 180);
    cleanButton.frame = CGRectMake(0, 0, self.view.bounds.size.width,30);
    [cleanButton bk_addEventHandler:^(id sender) {
        [[AppShareData instance] removeShopNameData];
        [self.tableView reloadData];
        NSLog(@"点击了清除按钮");
    } forControlEvents:UIControlEventTouchUpInside];
    UILabel *asd = [[UILabel alloc]init];
    asd.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    asd.text = @"清除历史记录";
    asd.textColor = UIColorFromRGB(180, 180, 180);
    asd.textAlignment = NSTextAlignmentCenter;
    [cleanButton addSubview:asd];
    
    return cleanButton;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (tableView == self.displayCtrl.searchResultsTableView) {
        
        return [self.searchWordList count];
    }
    
    if ([[AppShareData instance].searchShopNameData count]==0) {
        return 1;
    }
    
    return [[AppShareData instance].searchShopNameData count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.displayCtrl.searchResultsTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        
        NSDictionary *d = self.searchWordList[indexPath.row];
        
        NSString *name = d[@"name"];
        
        cell.textLabel.text=name;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [GUIConfig grayFontColorDeep];
        
        return cell;
        
    }else{
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        if ([[[AppShareData instance]searchShopNameData]count]>0) {
           cell.textLabel.text = [NSString stringWithFormat:@"%@",[AppShareData instance].searchShopNameData[indexPath.row]];;
       }
        else{
           cell.textLabel.text = @"暂无搜索历史记录";
           cell.textLabel.textColor = UIColorFromRGB(180, 180, 180);
       }
        return cell;
        
    }
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.displayCtrl.searchResultsTableView) {
        
        NSDictionary *d = self.searchWordList[indexPath.row];
        
        [[AppShareData instance] searchShopName:self.searchWordList[indexPath.row][@"name"]];
        
        ShopInfoViewCtrl *vc = [ShopInfoViewCtrl new];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.shopId = SafeString(d[@"id"]);
        
        [self.navigationController pushViewController:vc animated:YES];
        
        NSLog(@"keyword %@",d);
        
        return;
    }
    
    if ([[AppShareData instance].searchShopNameData count]>0) {
    
    SearchResultViewCtrl *vc =[SearchResultViewCtrl new];
    
    vc.keyWord = [AppShareData instance].searchShopNameData[[indexPath row]];
    
    [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    else{
    
        [[AppShareData instance] removeShopNameData];
        
        [self.tableView reloadData];
    
    }
    
    
    
}



@end
