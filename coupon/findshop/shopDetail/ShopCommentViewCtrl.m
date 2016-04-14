//
//  ShopCommentViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopCommentViewCtrl.h"
#import "ShopCommentTableViewCell.h"
#import "ShopCommentSevice.h"
#import "BasketService.h"
@interface ShopCommentViewCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) ShopCommentSevice *shopSevice;
@property (nonatomic,strong) ShopCommentTableViewCell *cell;
@property (nonatomic,strong) UITableView *tableViewView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ShopCommentViewCtrl

-(void)viewWillAppear:(BOOL)animated{

    [SVProgressHUD show];

    [self loadData];
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [SVProgressHUD dismiss];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shopSevice = [ShopCommentSevice new];
    
    self.navigationItem.title=@"商店评论";
    
    
    
    [self tableView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
//http://183.6.190.75:9780/diamond-sis-web/v1/customer/15818865756/review?page=1&per_page=10&sort=-time
//page=1&per_page=10&sort=-time
    NSDictionary *parma = @{@"page":@"1",@"per_page":@"10",@"sort":@"-time"};
    [_shopSevice requestParam:parma success:^(id data) {
        [SVProgressHUD dismiss];
       NSLog(@"-----------我的评价数据------------%@",data);
        _dataArray = data;
        [_tableViewView reloadData];
    } failure:^(id coad) {
        
    }];

}

-(void)tableView{

    _tableViewView = [UITableView new];
    _tableViewView.dataSource = self;
    _tableViewView.delegate = self;
    [self.view addSubview:_tableViewView];
    [_tableViewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.and.right.and.bottom.equalTo(self.view).offset(0);
    }];
    
    _tableViewView.separatorStyle = UITableViewCellSelectionStyleNone;

    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    _cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    
    if (_cell == nil) {
        _cell = [[ShopCommentTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];}
//    [self loadData];
    [_cell data:_dataArray[indexPath.row]];
    
//    [tableView reloadData];
    //ShopCommentTableViewCell
    // Configure the cell...
    
    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
    
    longPressed.minimumPressDuration = 1.0;
    
    [_cell.contentView addGestureRecognizer:longPressed];
    
    return _cell;
}


#pragma mark - 长按删除

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture{
    
    
    
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:self.tableViewView];
        
        
        NSIndexPath * indexPath = [self.tableViewView indexPathForRowAtPoint:point];
        
        
        if(indexPath == nil) return ;
        
        
        UIActionSheet *act = [UIActionSheet bk_actionSheetWithTitle:@"操作"];
        
        [act bk_addButtonWithTitle:@"删除" handler:^{
            
            
            BasketService *service =[BasketService new];
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            
            
            NSString *itemId = self.dataArray[indexPath.row][@"id"];
            
            [service requestDeleteBasket:itemId success:^(NSInteger code, NSString *message, id data) {
                
                
                [SVProgressHUD dismiss];
                
                NSMutableArray *ary = [self.dataArray mutableCopy];
                
                [ary removeObjectAtIndex:indexPath.row];
                
                self.dataArray = ary;
                
                
                
                [self.tableViewView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                
                
                
                
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
                
                [SVProgressHUD showErrorWithStatus:@"删除出错！"];
                
                [SVProgressHUD dismiss];
                
                
            }];
            
            
            
            
            // [self.tableView reloadData];
            
            
            
            
            
            
            
            
        }];
        
        [act bk_setDestructiveButtonWithTitle:@"关闭" handler:^{
            
            
            
            
        }];
        
        
        [act showInView:self.view];
        
        //add your code here
        
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [_tableViewView deselectRowAtIndexPath:indexPath animated:YES];


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
