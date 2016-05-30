//
//  SelectCityTableViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/12.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "SelectCityTableViewCtrl.h"

@interface SelectCityTableViewCtrl ()<UISearchBarDelegate,UISearchResultsUpdating>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UISearchController *searchController;

@property(nonatomic,strong)NSArray *cityList;
@property(nonatomic,strong)NSArray *filterList;
@property(nonatomic,strong)NSDictionary *cityMap;

@property(nonatomic,strong)NSArray *mapKeyList;

@end

@implementation SelectCityTableViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // self.tableView registerClass:[UITableViewCell class] forHeaderFooterViewReuseIdentifier:<#(NSString *)#>
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self loadData];
    
    
  
    
    [self makeSearchBar];
    self.navigationItem.title=@"选择城市";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"关闭" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            
        }];
        
    }];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    
    
    
    
    
}



-(void)makeMapData{
    
    NSMutableDictionary *dict=[@{} mutableCopy];
    
    
    //将列表变成 字典 ，结构如下 @{"a":@[@{"cccc"},@{"bbbbbb"}]};
    for (NSDictionary *d in self.filterList) {
        NSString *name = d[@"name"];
        
        NSString *letter = [Utils firstLet:name];
        
        NSMutableArray *ary = dict[letter];
        
        if (ary==nil) {
            ary = [@[] mutableCopy];
            dict[letter]=ary;
        }
        
        [ary addObject:d];
        
    }
    
    
    
    
    
    self.cityMap = dict;
    
    self.mapKeyList = [self.cityMap allKeys];
    
    
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    self.mapKeyList = [self.mapKeyList sortedArrayUsingDescriptors:@[sd]];
    
    
    
    
    
    
    
    
    
}

-(void)loadData{
    
    
    self.cityList = @[@{@"name":@"广州市"},
                      @{@"name":@"北京市"},
                      @{@"name":@"深圳市"},
                      @{@"name":@"上海市"}
                      ];
    
    NSMutableArray *cityPyList = [@[] mutableCopy];
    
    for (NSDictionary *d in self.cityList) {
        
        NSString *name = d[@"name"];
        
        NSString *py = [Utils firstLetAllWord:name];
        
        
        NSString *allString = [py stringByAppendingString:name];
        
        NSDictionary *dd = @{@"name":name,@"py":allString};
        
        [cityPyList addObject:dd];
    
        
        
        
    }
    
    self.cityList = cityPyList;
    
    
    self.filterList = self.cityList;
    
    
    [self makeMapData];
    
    
    
     
    
}



-(void)doSearchFilter:(NSString*)searchString{
    
    
    //年龄小于30
    //定义谓词对象，谓词对象中包含了过滤条件
    
    
    NSString *condition = [NSString stringWithFormat:@"py like[c] '*%@*'",searchString];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:condition];
    //使用谓词条件过滤数组中的元素，过滤之后返回查询的结果
    NSArray *array = [self.cityList filteredArrayUsingPredicate:predicate];
    
    
    self.filterList = array;
    
    [self makeMapData];
    
    [self.tableView reloadData];
    
    
    //查询name=1的并且age大于40
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
   
    
    UIView *uv = [UIView new];
    uv.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    UILabel *lab = [UILabel new];
    
    [uv addSubview:lab];
    
    lab.backgroundColor = [GUIConfig mainBackgroundColor];
    
    NSString *name = self.mapKeyList[section];
    lab.frame = CGRectMake(15, 0, SCREEN_WIDTH-15, 20);
    
    lab.text = [[NSString stringWithFormat:@"%@",name] uppercaseString];
    
    lab.font  = [UIFont systemFontOfSize:14];
    lab.textColor = [GUIConfig grayFontColor];
    
    return uv;
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.mapKeyList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    
   NSString *key =  self.mapKeyList[section];
    
   return [self.cityMap[key] count];
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    NSString *section = self.mapKeyList[[indexPath section]];
    
    
    
    NSArray * currentCityList  = self.cityMap[section];
    
    
    
    cell.textLabel.text = currentCityList[[indexPath row]][@"name"];
    
    
    
    // Configure the cell...
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (self.selectBlock) {
            
            
            NSString *section = self.mapKeyList[[indexPath section]];
            
            
            
            NSArray * currentCityList  = self.cityMap[section];
            
            
            
            NSString *city = currentCityList[[indexPath row]][@"name"];
            
            
            if (self.selectBlock) {
                self.selectBlock(city);
                
            }
            
        }
        
    }];
    
    
    
    
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    
    NSLog(@"search...");
    
    
    [self doSearchFilter:searchController.searchBar.text];
    
    
    
  //  [self.tableView reloadData];
    
    
    
    
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
