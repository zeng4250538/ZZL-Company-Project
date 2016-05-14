//
//  MySubViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/13.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "MySubViewCtrl.h"
#import "SubTableViewCell.h"
#import "ShopInfoTableViewCell.h"
#import "ShopService.h"
#import "FavShopCell.h"
#import "ShopInfoViewCtrl.h"

@interface MySubViewCtrl ()

@property(nonatomic,strong)NSArray *dataList;


@end

@implementation MySubViewCtrl

-(void)viewWillDisappear:(BOOL)animated{

    [SVProgressHUD dismiss];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self optionsTypeViewLayout];
    
    self.tableView = [GUIHelper zzl_makeTableView:self.view dalegate:self];
    
    
    [self.tableView registerClass:[FavShopCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title=@"消息订阅";
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
     
    
    [self loadData];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)optionsTypeViewLayout{

    UIImageView *headBGView = [[UIImageView alloc]init];
    headBGView.backgroundColor = UIColorFromRGB(238,238,238);
    [self.view addSubview:headBGView];
    [headBGView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@50);
        
    }];
    [headBGView setUserInteractionEnabled:YES];
    
    /**
     左边button（类型）
     */
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.backgroundColor = [UIColor whiteColor];
    [leftButton setTitle:@"类型" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 50);
    [headBGView addSubview:leftButton];
    
    [leftButton bk_addEventHandler:^(id sender) {
        
        UIActionSheet *as = [[UIActionSheet alloc]bk_initWithTitle:@""];
        
        [as bk_addButtonWithTitle:@"类型" handler:^{
            [leftButton setTitle:@"类型" forState:UIControlStateNormal];
        }];
        
        [as bk_addButtonWithTitle:@"美食" handler:^{
            [leftButton setTitle:@"美食" forState:UIControlStateNormal];
        }];
        
        [as bk_addButtonWithTitle:@"电影" handler:^{
            [leftButton setTitle:@"电影" forState:UIControlStateNormal];
        }];
        
        [as bk_addButtonWithTitle:@"休闲娱乐" handler:^{
            [leftButton setTitle:@"休闲娱乐" forState:UIControlStateNormal];
        }];
        
        [as bk_setDestructiveButtonWithTitle:@"取消" handler:^{
            
        }];
        
        [as showInView:[UIApplication sharedApplication].keyWindow];
    } forControlEvents:UIControlEventTouchUpInside];
    
   

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    
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
-(void)doLoad:(void(^)(BOOL ret))completion{
    
    ShopService *service = [ShopService new];
    
    [service requestMyFavList:^(NSInteger code, NSString *message, id data) {
        
        
        self.dataList = data;
        
        
        [self.tableView reloadData];
        
        completion(YES);
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
 
        completion(NO);
        
    }];
    
}




    
    
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [ShopInfoTableViewCell height];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    NSDictionary *data = self.dataList[indexPath.row];
    
    
    
    cell.data = data;
    
    NSString *shopId = SafeString(data[@"shopId"]);
    
    cell.unFavBlock = ^(){
        
        
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        
        ShopService *service = [ShopService new];
        
        [service doUnFav:shopId success:^(NSInteger code, NSString *message, id data) {
            
            
            [SVProgressHUD dismiss];
            
            
            NSMutableArray *ary = [self.dataList mutableCopy];
            
            
            
            [ary removeObjectAtIndex:indexPath.row];
            
            self.dataList = ary;
            
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [self.tableView reloadData];
            
            
            
            
            
            
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            [SVProgressHUD showErrorWithStatus:@"取消订阅失败"];
            
        }];
        
        
        
        
        
    };
    
    
    
    [cell updateData];
    // Configure the cell...
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ShopInfoViewCtrl *vc = [ShopInfoViewCtrl new];
    
    NSDictionary *d = self.dataList[indexPath.row];
    
    vc.shopMode = ShopViewModeNetwork;
    vc.shopId  = SafeString(d[@"shopId"]);
    
    vc.data = d;
    
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
    
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
