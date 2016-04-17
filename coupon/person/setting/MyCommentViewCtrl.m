//
//  MyCommentViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "MyCommentViewCtrl.h"
#import "CommentService.h"

@interface MyCommentViewCtrl ()

@property(nonatomic,strong)NSArray *data;

@end

@implementation MyCommentViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"我的评论";
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    
    CommentService *service = [CommentService new];
    
    
    [service requestCommentWithCustomer:@"" page:1 per_page:10 sort:@"" success:^(NSInteger code, NSString *message, id data) {
        
        
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


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *uv = [UIView new];
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    
    uv.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    
    return  uv;
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }
    
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    NSDictionary *d = self.data [indexPath.section];
    
    for (UIView *uv in [cell.contentView subviews]) {
        [uv removeFromSuperview];
    }
    
    
    
   // cell.textLabel.text =[NSString stringWithFormat:@"%@",d];
    
    
    UILabel *shopNameLabel = [UILabel new];
    shopNameLabel.font = [UIFont systemFontOfSize:14];
    shopNameLabel.textColor = [UIColor darkGrayColor];
    
    [cell.contentView addSubview:shopNameLabel];
    
    shopNameLabel.frame = CGRectMake(20, 0, SCREEN_WIDTH-20, 30);
    
    shopNameLabel.text =SafeString(d[@"shopName"]);
    
    
    
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, 30, SCREEN_WIDTH, 1);
    line.backgroundColor = [GUIConfig mainBackgroundColor];
    
    [cell.contentView addSubview:line];
    
    UILabel *commentLabel = [UILabel new];
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.textColor = [UIColor blackColor];
    
    commentLabel.frame = CGRectMake(20, 30, SCREEN_WIDTH-20, 50);
    
    commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    commentLabel.numberOfLines=0;
    
    [cell.contentView addSubview:commentLabel];
    
    commentLabel.text = SafeString(d[@"comment"]);
    

    UILabel *dateLabel = [UILabel new];
    dateLabel.font = [UIFont systemFontOfSize:12];
    dateLabel.textColor = [UIColor lightGrayColor];
    
    dateLabel.frame = CGRectMake(20, 80, SCREEN_WIDTH-20, 20);
    
    dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    dateLabel.numberOfLines=0;
    
    [cell.contentView addSubview:dateLabel];
    
    dateLabel.text = SafeString(d[@"time"]);

    
    
    
    
    
    
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
