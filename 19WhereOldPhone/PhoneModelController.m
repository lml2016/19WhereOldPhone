//
//  PhoneModelController.m
//  Ershouji
//
//  Created by GL on 14-10-9.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "PhoneModelController.h"
#import "BrandCell.h"
#import "ArrayDataSource.h"
#import "PhoneModel.h"
#import "NetUtils.h"
#import "PhoneUrlManager.h"
#import "SVProgressHUD.h"
#import "QuestionController.h"

//#import "QuestionController.h"

#define CellIdentifier @"brandcell"

@interface PhoneModelController ()<UITableViewDelegate>

{
    UIStoryboard *mainBoard;
}

@property (nonatomic,strong) ArrayDataSource *dataSource;
@property (nonatomic,strong)  NSMutableArray  *modelArray;

@end

@implementation PhoneModelController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    mainBoard = [UIStoryboard storyboardWithName:@"oldPhone" bundle:nil];
    self.navigationItem.title = @"选择型号";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"型号"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    [self setupTableView];
    [self loadData:self.phoneBrand.brand_id];
}

#pragma mark - tableview

- (void) setupTableView
{
    TableViewCellConfigureBlock configureCell = ^(id cell, id entity, NSIndexPath *indexPath){
        [cell configCellPhoneModel:entity withIndexPath:indexPath];
    };
    [self.tableview registerNib:[BrandCell nib] forCellReuseIdentifier:CellIdentifier];

    self.dataSource = [[ArrayDataSource alloc] initWithItems:nil cellIdentifier:CellIdentifier configureCellBlock:configureCell];

    self.tableview.dataSource = self.dataSource;
    self.tableview.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) loadData : (NSInteger) brandID
{
    [SVProgressHUD showWithStatus:@"加载中..."];
   
    [NetUtils doGet2:[NSURL URLWithString:URL_PHONE_TYPE_LIST(brandID)] withResultBlock:^(NSString *result) {
        if (result && result.length) {
            self.modelArray = [[NSMutableArray alloc] init];
            NSError *error = nil;
            NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
           
            NSArray *dataArray = [[jsonDic objectForKey:@"Data"] objectForKey:@"List"];
            
            for (NSDictionary *dic in dataArray) {
                
                PhoneModel *model = [[PhoneModel alloc] initWithDictionary:dic];
                [self.modelArray addObject:model];
            }
            self.dataSource.items = self.modelArray;
            [self.tableview reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}


- (void) fliterData : (NSString *)keyword
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (keyword && keyword.length) {
        for (PhoneModel *model in self.modelArray) {
            if ([[model.product_name lowercaseString] containsString:[keyword lowercaseString]]) {
                [tempArray addObject:model];
            }
        }
    }else{
        tempArray = self.modelArray;
    }
    self.dataSource.items = tempArray;
    [self.tableview reloadData];
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
//    QuestionController *modelController = [mainBoard instantiateViewControllerWithIdentifier:@"QuestionController"];
    QuestionController *modelController = [[QuestionController alloc ] initWithNibName:@"QuestionController" bundle:nil];
    modelController.phoneModel = [self.dataSource.items objectAtIndex:indexPath.row];
    modelController.phoneModel.phoneBrand = self.phoneBrand;
    [self.navigationController pushViewController:modelController animated:YES];
}


#pragma UISearchDisplayDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.modelSearchBar resignFirstResponder];
    self.modelSearchBar.text = @"";
    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    [self fliterData:searchText];
}


@end
