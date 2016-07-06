//
//  SearchResultViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/29.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "SearchResultViewCtrl.h"
#import "CouponInfoTableViewCell.h"
#import "CouponDetailViewCtrl.h"
#import "ShopService.h"
#import "ReloadHud.h"
#import "ShopInfoTableViewCell.h"
#import "ShopInfoViewCtrl.h"




@interface SearchResultViewCtrl ()<UISearchResultsUpdating>
@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)NSArray *keyWordList;

@property(nonatomic,strong)NSArray *dataList;

@property(nonatomic,strong)UISearchController *searchController;


@end

@implementation SearchResultViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self makeSearchBar];
    
    self.navigationItem.title=@"商家搜索";
    
    
    [self.tableView registerClass:[ShopInfoTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    
    
    
    
    [self loadData];
    
}



-(void)doLoad:(void(^)(BOOL ret))completion{
    
    
    
    ShopService *service = [ShopService new];
    
    NSString *mallId = [AppShareData instance].mallId;
    
    
    
    
    
    [service requestKeyword:mallId
                          keyWord:self.keyWord
                          success:^(NSInteger code, NSString *message, id data) {
                              
                              
                              
                              self.dataList = data;
                              
                              [self.tableView reloadData];
                              
                              
                              completion(YES);
                              
                              
                              
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        completion(NO);
        
        
    }];
    
    
    
    
}


-(void)makeSearchBar{
    
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
    self.searchController.searchBar.backgroundImage =[Utils imageWithColor:[GUIConfig mainBackgroundColor]];
    
    self.searchController.searchBar.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    
    self.searchController.hidesBottomBarWhenPushed = NO;
    
    
    self.searchController.searchBar.delegate = self;
    
    
    
    
    
    
}




-(void)loadData{
    
    
    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.tableView animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self.tableView];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.tableView animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self.tableView];
        }
        
        
    }];
    
    
    
}





//-(void)makeDisplayCtrl{
//    
//    self.displayCtrl = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
//    
//    self.displayCtrl.delegate = self;
//    self.displayCtrl.searchResultsDataSource = self;
//    
//    self.displayCtrl.searchResultsDelegate = self;
//    
//    self.displayCtrl.displaysSearchBarInNavigationBar = YES;
//    
//    //displaysSearchBarInNavigationBar
//    
//    
//    
//    
//    
//    [GUIConfig tableViewGUIFormat:self.tableView];
//    
//    [GUIConfig tableViewGUIFormat:self.displayCtrl.searchResultsTableView];
//    
//    
//    
//    
//}


//- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
//    
//    controller.searchBar.placeholder=@"";
//    
//    
//    
//    
//}
//
//- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
//    
//    controller.searchBar.placeholder=self.keyWord;
//    
//}




//- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
//    
//    
//    
//}



//-(void)makeSearchBar{
//    
//    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 44)];
//    //self.searchBar.searchBarStyle = UISearchBarStyleProminent;
//    self.searchBar.barTintColor = [GUIConfig mainBackgroundColor];
//    
//    self.searchBar.backgroundImage =[UIImage new];
//    
//    self.searchBar.delegate= self;
//    
//    self.searchBar.placeholder=self.keyWord;
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
//    
//   // self.navigationItem.titleView = self.searchBar;
//    
//    
//    
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [self.dataList count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [ShopInfoTableViewCell height];
       
        
    
    
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
     ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
    
    
    NSDictionary *d = self.dataList[indexPath.row];
    
    cell.data=d;
    
    [cell updateData];
    
    
    
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShopInfoViewCtrl *vc = [ShopInfoViewCtrl new];
        
        
    NSDictionary *currentData = self.dataList[indexPath.row];
        
        
    vc.shopId = currentData[@"id"];
        
        
    
    [self.navigationController pushViewController:vc animated:YES];

    
    
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    
    NSLog(@"search...");
    
    
    
    
    
    
    
    
    
    
    
    //  [self.tableView reloadData];
    
    
    
    
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{                    // called when keyboard search


    NSLog(@"searchBar %@",searchBar.text);
    
    
    [searchBar endEditing:YES];
    
    
    
    self.keyWord = searchBar.text;
    
    
    [self doLoad:^(BOOL ret) {
        
        [self.tableView reloadData];
        
        self.searchController.active = NO;

        
    }];
    
    
    

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
