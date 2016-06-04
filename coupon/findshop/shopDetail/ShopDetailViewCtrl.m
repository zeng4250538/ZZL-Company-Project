//
//  ShopDetailViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/28.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ShopDetailViewCtrl.h"
#import "ShopService.h"

@interface ShopDetailViewCtrl ()

@property(nonatomic,strong)NSDictionary *data;


@end

@implementation ShopDetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [GUIHelper makeTableView:self.view delegate:self];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    
    [self loadData];
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    self.navigationItem.title=@"商店详情";
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;

    
    
}

-(void)makeHeaderView{
    
    
    UIView *uv = [UIView new];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    imageView.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = SafeUrl(self.data[@"photoUrl"]);
    
    
    
    
    SafeLoadUrlImage(imageView, url, ^{
        
        [self.tableView setNeedsLayout];
        
        
    });
    
    uv.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    
    self.tableView.tableHeaderView = imageView;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [service requestShopInfo:self.shopId success:^(NSInteger code, NSString *message, id data) {
        
        self.data = data;
        
        [self.tableView reloadData];
        
        [self makeHeaderView];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        completion(NO);
        
        
    }];
    
    
    
    
    
    
    
    
    
}






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
//    for(UIView *uv in [cell.contentView subviews]){
//        [uv removeFromSuperview];
//    }
//    
//    UILabel *nameLabel = [UILabel new];
    
    
    
//    
    
    if (indexPath.row==0) {
        
        cell.textLabel.text =[NSString stringWithFormat:@"店名：%@",SafeString(self.data[@"name"])];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];

        
    }
    
    if (indexPath.row==1) {
        
        cell.textLabel.text =[NSString stringWithFormat:@"电话：%@",SafeString(self.data[@"phone"])];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        
        
    }
    
    if (indexPath.row==2) {
        
        cell.textLabel.text =[NSString stringWithFormat:@"地址：%@",SafeString(self.data[@"address"])];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        
        
    }
  
    if (indexPath.row==3) {
        
        cell.textLabel.text =[NSString stringWithFormat:@"描述：%@",SafeString(self.data[@"description"])];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        
        
    }
    
    
    
    
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
