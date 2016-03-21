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




@interface SearchResultViewCtrl ()
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UISearchDisplayController *displayCtrl;

@property(nonatomic,strong)NSArray *keyWordList;

@property(nonatomic,strong)NSArray *dataList;




@end

@implementation SearchResultViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self makeSearchBar];
    
    [self makeDisplayCtrl];
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    
    [self.displayCtrl.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    
    
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



-(void)doLoad:(void(^)(BOOL ret))completion{
    
    self.keyWordList = @[@"麦当劳",@"咖啡",@"美甲",@"蛋糕"];
     
    
    ShopService *service = [ShopService new];
    
    
    [service requestKeyword:@"mallid"
                          keyWord:@"xxx"
                          success:^(NSInteger code, NSString *message, id data) {
                              
                              
                              
                              self.keyWordList = data;
                              
                              [self.tableView reloadData];
                              
                              
                              completion(YES);
                              
                              
                              
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        completion(NO);
        
        
    }];
    
    
    
    
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





-(void)makeDisplayCtrl{
    
    self.displayCtrl = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.displayCtrl.delegate = self;
    self.displayCtrl.searchResultsDataSource = self;
    
    self.displayCtrl.searchResultsDelegate = self;
    
    self.displayCtrl.displaysSearchBarInNavigationBar = YES;
    
    //displaysSearchBarInNavigationBar
    
    
    
    
    
    [GUIConfig tableViewGUIFormat:self.tableView];
    
    [GUIConfig tableViewGUIFormat:self.displayCtrl.searchResultsTableView];
    
    
    
    
}


- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    
    controller.searchBar.placeholder=@"";
    
    
    
    
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    
    controller.searchBar.placeholder=self.keyWord;
    
}




- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    
    
    
}



-(void)makeSearchBar{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 44)];
    //self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.searchBar.barTintColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.backgroundImage =[UIImage new];
    
    self.searchBar.delegate= self;
    
    self.searchBar.placeholder=self.keyWord;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    
   // self.navigationItem.titleView = self.searchBar;
    
    
    
}




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
    
    if (self.displayCtrl.searchResultsTableView == tableView) {
        
        return [self.keyWordList count];
    }else{
        
        return [self.dataList count];
    }
    
    return 7;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.displayCtrl.searchResultsTableView == tableView) {
        
        
        return 50;
 
    }else{
        
        return [ShopInfoTableViewCell height];
       
        
    }
    
    
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.displayCtrl.searchResultsTableView == tableView) {
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        // Configure the cell...
        
        
        cell.textLabel.text=self.keyWordList[[indexPath row]];

        
        
        return cell;
    }
    
    
     ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    NSDictionary *d = self.dataList[indexPath.row];
    
    cell.data=d;
    
    [cell updateData];
    
    
    
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //搜索点击
    if (self.displayCtrl.searchResultsTableView == tableView) {
        
        [self.displayCtrl setActive:NO animated:YES];
        
        [self.tableView reloadData];
        
    }else{
        
        
        
        
        
        ShopInfoViewCtrl *vc = [ShopInfoViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];

        
        
        
        
        
        
        
        
    }
    
    
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
