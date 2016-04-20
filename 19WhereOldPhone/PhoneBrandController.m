//
//  PhoneBrandController.m
//  Ershouji
//
//  Created by GL on 14-10-9.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "PhoneBrandController.h"
#import "UIView+XHCustomHUD.h"
#import "ArrayDataSource.h"
#import "BrandCell.h"
#import "PhoneBrand.h"
#import "PhoneUrlManager.h"
#import "NetUtils.h"
#import "PingyinUtil.h"
#import "SVProgressHUD.h"
#import "PhoneModelController.h"

#define BrandCellIdentifier @"brandcell"

@interface PhoneBrandController () <UITableViewDelegate,UITableViewDataSource>
{
    UIStoryboard *mainBoard ;
}
@property (nonatomic, strong) NSMutableArray *allBrandArray;
@property (nonatomic, strong) NSMutableArray *brandArray;

@end

@implementation PhoneBrandController

- (void)viewDidLoad {
    [super viewDidLoad];
//    mainBoard = [UIStoryboard storyboardWithName:@"oldPhone" bundle:nil];
    self.brandArray = [[NSMutableArray alloc] init];
    [self setupTableView];
    [self loadData];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"品牌"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setupTableView
{
    [self.brandTableView registerNib:[BrandCell nib] forCellReuseIdentifier:BrandCellIdentifier];
    self.brandTableView.dataSource = self;
    self.brandTableView.delegate = self;
}


- (void) loadData
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableArray __block *dataArray = nil;
    [NetUtils doGet2:[NSURL URLWithString:URL_PHONE_BAEND_LIST] withResultBlock:^(NSString *result) {
        if (result && result.length) {
            dataArray = [[NSMutableArray alloc] init];
            NSError *error = nil;
            NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            
            NSArray *dataArray = [jsonDic objectForKey:@"Data"];
            NSMutableArray *brandTempArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in dataArray) {
                PhoneBrand *brand = [[PhoneBrand alloc] initWithDictionary:dic];
                brand.sortLetters = [PingyinUtil getFirstLetter:brand.brand_name];
                [brandTempArray addObject:brand];
            }
            self.allBrandArray = [[NSMutableArray alloc] init];
            [self.allBrandArray addObjectsFromArray:brandTempArray];
            [self sort:brandTempArray];
            [self.brandTableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}

- (NSMutableArray *) sort : (NSArray *) dataArray
{
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];//这个是建立索引的核心
    //名字分section
    for (PhoneBrand *item in dataArray) {
        //getUserName是实现中文拼音检索的核心，见NameIndex类
        NSInteger sect = [theCollation sectionForObject:item collationStringSelector:@selector(sortLetters)];
        //设定姓的索引编号
        item.sectionNumber = sect;
    }
    //创建存储所有section的array，以及为每个section分配它的存储空间，初始空间为1。
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i=0; i<=highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    //利用数据源来填充每个section ，根据对象的section id 把每个对象放入其对应的section array里
    for (PhoneBrand *item in dataArray) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:item.sectionNumber] addObject:item];
    }
    
    for (NSMutableArray *sectionArray in sectionArrays) {
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(sortLetters)];
        [self.brandArray addObject:sortedSection];
    }
    return self.brandArray;
}

- (void) fliterData : (NSString *)keyword
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (keyword && keyword.length) {
        for (PhoneBrand *brand in self.allBrandArray) {
            DLog(@"name = %@ ,  key = %@",[brand.brand_name lowercaseString],[keyword lowercaseString]);
            if ([[brand.brand_name lowercaseString] containsString:[keyword lowercaseString]]) {
                [tempArray addObject:brand];
            }
        }
    }else{
        tempArray = self.allBrandArray;
    }

    [self.brandArray removeAllObjects];
    if (tempArray.count) {
        [self sort:tempArray];
    }
    [self.brandTableView reloadData];
}

# pragma mark tableviewDataSource

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([[self.brandArray objectAtIndex:section] count] > 0) {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray * existTitles = [NSMutableArray array];
    NSArray * allTitles = [[UILocalizedIndexedCollation currentCollation] sectionTitles];
    //section数组为空的title过滤掉，不显示
    
    for (int i=0; i<self.brandArray.count; i++) {
        if ([[self.brandArray objectAtIndex:i] count] > 0) {
            [existTitles addObject:[allTitles objectAtIndex:i]];
        }
    }
    return existTitles;
    
    //    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}
//返回section index对应的section
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}


- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.brandArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.brandArray.count;
}


//
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.brandArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandCell *cell= [tableView dequeueReusableCellWithIdentifier:BrandCellIdentifier forIndexPath:indexPath];
    PhoneBrand *brand = [self itemAtIndexPath:indexPath];
    [cell configCell:brand withIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.brandTableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    PhoneModelController *modelController = [mainBoard instantiateViewControllerWithIdentifier:@"PhoneModelController"];
    PhoneModelController *modelController = [[PhoneModelController alloc ] initWithNibName:@"PhoneModelController" bundle:nil];
    modelController.phoneBrand = [self itemAtIndexPath:indexPath];
    [self.navigationController pushViewController:modelController animated:YES];
}


#pragma UISearchDisplayDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.brandSearchBar resignFirstResponder];
    self.brandSearchBar.text = @"";
    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    [self fliterData:searchText];
}



@end
