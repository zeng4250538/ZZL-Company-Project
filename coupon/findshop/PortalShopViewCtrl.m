//
//  PortalShopViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "PortalShopViewCtrl.h"
#import "PortalShopTableViewCell.h"
#import "ShopCouponViewCtrl.h"
#import "KeyWordSearchViewCtrl.h"
#import "SelectMallTableCtrl.h"
#import "SelectCityTableViewCtrl.h"

@interface PortalShopViewCtrl ()

@property(nonatomic,strong)UISearchBar *searchBar;

@end

@implementation PortalShopViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"找商家";
    
    [self.tableView registerClass:[PortalShopTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self makeSearchBar];
    
    
    [self loadData];
    
    [self makeBarItem];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)loadData{
    
    self.hotData = @[
                     @{@"imgurl":@"shoplogo.png",
                       @"title":@"赛百味",
                       @"goodcount":@100,
                       @"badcount":@2,
                       @"comment":@"全场8折，满足100送20"
                       },
                     @{@"imgurl":@"shoplogo2.png",
                       @"title":@"点都得",
                       @"goodcount":@100,
                       @"badcount":@2,
                       @"comment":@"全场8折，满足100送20"
                       },
                     @{@"imgurl":@"shoplogo3.png",
                       @"title":@"贡茶",
                       @"goodcount":@100,
                       @"badcount":@2,
                       @"comment":@"全场8折，满足100送20"
                       },
                     
                     @{@"imgurl":@"shoplogo.png",
                       @"title":@"绿茵阁",
                       @"goodcount":@100,
                       @"badcount":@2,
                       @"comment":@"全场8折，满足100送20"
                       }
                     
                     
                     ];
    
    
    
}

#pragma mark- 导航栏按钮

-(void)makeBarItem{
    
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    UIBarButtonItem *addressBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"location_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    
    
    UIBarButtonItem *addressNameBarItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"广州" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }];
    
    
    UIBarButtonItem *roomMapBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"roommap"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        
    }];
    
    self.navigationItem.rightBarButtonItem = roomMapBarItem;
    
    
    

    
    
//    UIBarButtonItem *scanerBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"scanner_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
//        
//    }];
//    
//    
    
    self.navigationItem.leftBarButtonItems = @[addressBarItem,addressNameBarItem];
    
 //   self.navigationItem.rightBarButtonItem = scanerBarItem;
    
    
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeSystem];
    headButton.frame = CGRectMake(0, 0, 200, 44);
    [headButton setTitle:@"正佳广场(1km)" forState:UIControlStateNormal];
    headButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    self.navigationItem.titleView = headButton;
    
    
    [headButton bk_addEventHandler:^(id sender) {
        
        SelectMallTableCtrl *vc = [SelectMallTableCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



-(void)makeHeaderSearchBar{
    
    
    
    //  UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(-30, 0, SCREEN_WIDTH-100, 35)];//allocate titleView
    //  UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    //  [titleView setBackgroundColor:color];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(-30, 4, SCREEN_WIDTH-100, 28);
 
  //  searchBar.placeholder=@"搜索品牌，商家，优惠券";
    searchBar.backgroundImage =[UIImage new];
    
    
    searchBar.placeholder = self.navigationItem.title;
    // [titleView addSubview:searchBar];
    
    //Set to titleView
    //[self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = searchBar;
    
    
    
    
    
    
    
    
    // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    
    
    
}



-(void)makeSearchBar{
    
    
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    //self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.searchBar.barTintColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.backgroundImage =[UIImage new];
    
    self.searchBar.delegate= self;
    
    //self.searchBar.barStyle = UIBarStyleDefault;
    self.searchBar.backgroundColor = [UIColor whiteColor];
    
    self.searchBar.backgroundColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.placeholder=@"搜索品牌，商家，优惠券";

    
    
    
    UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    [bgView addSubview:self.searchBar];
    
    
    //  [self.searchBar becomeFirstResponder];
    
    
    self.tableView.tableHeaderView = bgView;
    
    

    
    
    
    
    
   
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UISearBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    

    
    KeyWordSearchViewCtrl *vc = [KeyWordSearchViewCtrl new];
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [self presentViewController:nav animated:vc completion:^{
        
    }];
    
    
    
    
    
    return NO;


}

#pragma  mark - Table view config


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [PortalShopTableViewCell height];
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section ==0) {
        
       return  [PortalShopTableViewCell headerView:@"优选商家" clickBlock:^{
           
           NSLog(@"xxxx");
            
        }];
        
    }else if (section ==1) {
        
        return  [PortalShopTableViewCell headerView:@"优选品牌" clickBlock:^{
            
        }];
        
        
    }else{
        return  [PortalShopTableViewCell headerView:@"优选品牌" clickBlock:^{
            
        }];
        
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ShopCouponViewCtrl *vc =[[ShopCouponViewCtrl alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section ==0 ) {
        return [self.hotData count];
    }
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PortalShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.data = self.hotData[[indexPath row]];
    
    [cell updateData];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
