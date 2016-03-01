//
//  BasketNoPayViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/30.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "BasketNoPayViewCtrl.h"
#import "CouponInfoTableViewCell.h"
#import "CouponDetailViewCtrl.h"
#import "CartTableViewCell.h"
#import "ToPayTableViewCtrl.h"

@interface BasketNoPayViewCtrl ()

@property(nonatomic,strong)UILabel *totalPriceLabel;

@end

@implementation BasketNoPayViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [UITableView new];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.view);
        
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    [self.tableView registerClass:[CartTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    [self makeToolBar];
    
    
    
     
    
    
   // automaticallyAdjustsScrollViewInsets = NO;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)makeToolBar{
    
    UIView *barView = [UIView new];
    barView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:barView];
    
    
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@50);
    
        
    }];
    
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeSystem];

    [barView addSubview:payButton];
    
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.equalTo(barView);
        make.width.equalTo(@100);
        
    }];
    
    payButton.backgroundColor = [GUIConfig mainColor];
    
    [payButton setTitle:@"去支付" forState:UIControlStateNormal];
    
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [payButton bk_addEventHandler:^(id sender) {
        
        ToPayTableViewCtrl *vc = [ToPayTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectAllButton setImage:[UIImage imageNamed:@"CellNotSelected@2x.png"] forState:UIControlStateNormal];
    [selectAllButton setImage:[UIImage imageNamed:@"CellRedSelected@2x.png"] forState:UIControlStateSelected];
    
    
    [barView addSubview:selectAllButton];
    
    
    //选择按钮位置设置
    [selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(barView).offset(15);
        make.centerY.equalTo(barView);
        
        
        
    }];
    
    selectAllButton.selected = YES;
    
    //点击切换选择状态
    
    [selectAllButton bk_addEventHandler:^(id sender) {
        
        selectAllButton.selected  = !selectAllButton.selected;
        
        
        [self checkAll:selectAllButton.selected];
        
        [self computeTotalPrice];
    } forControlEvents:UIControlEventTouchUpInside ];
  
    
    UILabel *selectAllLabel = [UILabel new];
    selectAllLabel.font = [UIFont systemFontOfSize:12];
    selectAllLabel.text=@"全选";
    selectAllLabel.textColor = [UIColor lightGrayColor];
    [barView addSubview:selectAllLabel];
    
    [selectAllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(selectAllButton.mas_right);
        make.top.bottom.equalTo(barView);
    }];
    
    [selectAllLabel sizeToFit];
    
    
    UILabel *totalPriceLabel = [UILabel new];
    
    [barView addSubview:totalPriceLabel];
    
    totalPriceLabel.textColor = [UIColor darkGrayColor];
    
    totalPriceLabel.font = [UIFont boldSystemFontOfSize:16];
    
    [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
       // make.left.equalTo(selectAllLabel.mas_right).offset(5);
        make.right.equalTo(payButton.mas_left).offset(-10);
        make.centerY.equalTo(barView);
        
    }];
    
    self.totalPriceLabel = totalPriceLabel;
    
    
    [self computeTotalPrice];
    
    
  //  totalPriceLabel.text=@"总计：14.0元";
    
    
    
    
    
    

    
    
    
    
    
}


#pragma mark - 控制所有的选项



-(void)checkAll:(BOOL)isSelected{
    
    
    for(NSMutableDictionary *d in [AppShareData instance].getCartList){
        
            if (isSelected) {
                d[@"isSelected"] = @1;
                
            }else{
                
                d[@"isSelected"] = @0;
                
                
            }
        
        
        
    }
    
    
    [self.tableView reloadData];
    

    
    
    
    
}

#pragma  mark  计算购物车金额

-(void)computeTotalPrice{
    
    
    NSInteger isSelected=1;
    NSInteger num=1;
    
    CGFloat totalPrice = 0.0;
    
    for(NSDictionary *d in [AppShareData instance].getCartList){
        
        if (d[@"isSelected"]==nil) {
            isSelected = 1;
        }else{
            
            isSelected = [d[@"isSelected"] integerValue];
        }
        
        
        if (d[@"num"]==nil) {
            num=1;
        }else{
            
            num = [d[@"num"] integerValue];
            
        }
        
        totalPrice = totalPrice+ isSelected*num*[d[@"price"] floatValue];
        
        
        
    }
    
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"总计：￥%.2f",totalPrice];
    
    
    
   // NSMutableDictionary *d = [AppShareData instance].getCartList[ [indexPath row]];
    
    
    
    
    
//    CartTableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:]
//    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CouponInfoTableViewCell height];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[AppShareData instance] getCartCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
    
    longPressed.minimumPressDuration = 1.0;
    
    [cell.contentView addGestureRecognizer:longPressed];

    
    
    NSMutableDictionary *d = [AppShareData instance].getCartList[ [indexPath row]];
    
    
    cell.data = d;
    
    [cell updateData];
    
    
  
    
    

    
    
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    deleteButton.backgroundColor = [GUIConfig mainColor];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
  //  cell.rightUtilityButtons = @[deleteButton];
    

    
//    [deleteButton bk_addEventHandler:^(id sender) {
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        NSMutableArray *ary = [AppShareData instance].getCartList;
//        
//        
//        [ary removeObjectAtIndex:[indexPath row]];
//        
//        
//        //[self.tableView reloadData];
//        
//        
//        
//        
//        
//    
//        
//        
//    } forControlEvents:UIControlEventTouchUpInside];
//    
    
    
    
    
    
    cell.dataUpdateBlock=^(){
        
        
        
        [self computeTotalPrice];
        
        
        
    
    
    };
    
    
    
    
 
    
    
    
    // Configure the cell...
    
    return cell;
}


-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.tableView];
        
        
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        
        
        if(indexPath == nil) return ;
        
        
        UIActionSheet *act = [UIActionSheet bk_actionSheetWithTitle:@"操作"];
        
        [act bk_addButtonWithTitle:@"删除" handler:^{
            
            NSMutableArray *ary = [AppShareData instance].getCartList;
            
            [ary removeObjectAtIndex:indexPath.row];
            
            
            
            
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [self computeTotalPrice];
            
            
           // [self.tableView reloadData];
            
            
            
            
            
            
            
            
        }];
        
        [act bk_setDestructiveButtonWithTitle:@"关闭" handler:^{
            
            
            
            
        }];
        
        
        [act showInView:self.view];
        
        //add your code here
        
        
        
    }
}



- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    
    
            NSMutableArray *ary = [AppShareData instance].getCartList;
    
    
            [ary removeObjectAtIndex:index];
    
    
            //[self.tableView reloadData];
            

    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    
    
    CouponDetailViewCtrl *vc = [CouponDetailViewCtrl new];
    
    vc.couponDetailType = CouponDetailTypeNotHaveCart;
    
    NSMutableDictionary *d = [AppShareData instance].getCartList[ [indexPath row]];
    
    
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
