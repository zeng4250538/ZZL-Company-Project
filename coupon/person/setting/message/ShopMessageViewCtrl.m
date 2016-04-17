//
//  ShopMessageViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ShopMessageViewCtrl.h"

#import "ShopMessageService.h"

@interface ShopMessageViewCtrl ()

@property(nonatomic,strong)NSArray *data;

@end

@implementation ShopMessageViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self loadData];
    
    self.navigationItem.title=@"商店消息";
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    
    ShopMessageService *service = [ShopMessageService new];
    
    [service requestShopMessageWithPage:1 per_page:10 success:^(NSInteger code, NSString *message, id data) {
        
        self.data = data;
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
    
    return 100;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *uv in [cell.contentView subviews]) {
        [uv removeFromSuperview];
    }
    
    UIImageView *logoView = [UIImageView new];
    
    [cell.contentView addSubview:logoView];
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(10);
        make.top.equalTo(cell.contentView).offset(10);
        make.bottom.equalTo(cell.contentView).offset(-10);
        make.width.equalTo(@100);
    }];
    
    NSDictionary *d =self.data[indexPath.row];
    
    
    NSURL *url = SafeUrl(d[@"shop"][@"smallPhotoUrl"]);
    
    
    [logoView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [cell setNeedsLayout];
    }];
    
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont boldSystemFontOfSize:14];
    nameLabel.textColor = [GUIConfig grayFontColorDeep];
    
    [cell.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoView.mas_right).offset(10);
        make.top.equalTo(logoView);
        make.height.equalTo(@20);
        make.right.equalTo(cell.contentView).offset(-10);
        
    }];
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.textColor = [GUIConfig grayFontColorLight];
    
    [cell.contentView addSubview:detailLabel];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoView.mas_right).offset(10);
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.height.equalTo(@20);
        make.right.equalTo(cell.contentView).offset(-10);
        
    }];
    
    
     
    nameLabel.text = SafeString(d[@"title"]);
    
    detailLabel.text = SafeString(d[@"messageContent"]);
    
    
    
    
    
    
    

    
    // Configure the cell...
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        ShopMessageService *service = [ShopMessageService new];
        
        NSDictionary *d  = self.data[indexPath.row];
        
        NSString *messageId = SafeString(d[@"id"]);
        
        [service deleteShopMessage:messageId
        success:^(NSInteger code, NSString *message, id data) {
            
            
            NSMutableArray *ary = [self.data mutableCopy];
            
            [ary removeObjectAtIndex:indexPath.row];
            
            self.data = ary;
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            
            
            
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            
        }];
        
        
        
        
        // Delete the row from the data source
       //`  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
