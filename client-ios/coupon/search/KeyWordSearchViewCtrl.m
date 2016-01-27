//
//  UISearchViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/17.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "KeyWordSearchViewCtrl.h"

@interface KeyWordSearchViewCtrl ()

@property(nonatomic,strong)NSArray *hotWordList;


@property(nonatomic,strong)NSArray *searchWordList;

@end

@implementation KeyWordSearchViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title=@"关键字搜索";
    
    [self loadData];
    
    [self makeHeaderView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)loadData{
    
    
    self.hotWordList = @[@"小吃",@"麦当劳",@"咖啡",@"电影",@"贡茶",@"奶茶",@"西餐",@"蛋糕"];
    
    self.searchWordList = @[@"贡茶",@"星巴克",@"都城",@"快餐"];
    
    
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
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
        
        btn.layer.borderWidth=1;
        btn.layer.borderColor = [[GUIConfig mainBackgroundColor] CGColor];
        
        
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
        [bgView addSubview:btn];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        pos++;
        
        
        
    }
    
    
    self.tableView.tableHeaderView = bgView;
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.hotWordList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = self.hotWordList[[indexPath row]];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    cell.imageView.image = [UIImage imageNamed:@"history.png"];
    
    
    
   // cell.textLabel.text=@"搜索";
    
    
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
