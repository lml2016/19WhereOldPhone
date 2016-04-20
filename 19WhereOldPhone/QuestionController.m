//
//  QuestionController.m
//  Ershouji
//
//  Created by GL on 14-10-10.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "QuestionController.h"
#import "QuestionModel.h"
#import "QuestionCell.h"
#import "HeadView.h"
#import "QCellModel.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
#import "PhoneUrlManager.h"
#import "NetUtils.h"
#import "OrderModel.h"
#import "ConfirmOrderCongroller.h"
#import "AppDelegate.h"
#import "RevaluationViewController.h"
#define CellIdentifier @"questioncell"

@interface QuestionController ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
{
    int *selectIds;
}
@property (nonatomic,strong) NSArray *questionArray;
@property (nonatomic,strong)  NSString *tempIds ;
@property (nonatomic,strong)  NSString *tempNames ;

@end

@implementation QuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备评估";
    [self setupTableView];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setupTableView
{
    self.tableview.sectionHeaderHeight = 35;
    [self.tableview registerNib:[QuestionCell nib] forCellReuseIdentifier:CellIdentifier];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
}

- (void) loadData
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableArray __block *modelArray = nil;
    [NetUtils doGet2:[NSURL URLWithString:URL_PHONE_EVALUATED((long)self.phoneModel.product_id)] withResultBlock:^(NSString *result) {
        if (result && result.length) {
            modelArray = [[NSMutableArray alloc] init];
            NSError *error = nil;
            NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            
            NSArray *dataArray = [[jsonDic objectForKey:@"Data"] objectForKey:@"SchemeAttributes"];
            
            NSMutableDictionary *parentQuestionsDic = [[NSMutableDictionary alloc] init];
            NSMutableArray *questionCellArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in dataArray) {
                QuestionModel *questionModel = [[QuestionModel alloc] initWithDictionary:dic];
                if (questionModel.parent_id == 0) {
                    [parentQuestionsDic setObject:questionModel forKey:[NSNumber numberWithInteger:questionModel.attribute_id]];
                }else{
                    [questionCellArray addObject:questionModel];
                }
            }
            
            for (QuestionModel *quesitonCell in questionCellArray) {
                QuestionModel *parentQuestion = [parentQuestionsDic objectForKey:[NSNumber numberWithInteger:quesitonCell.parent_id]];
              
                if (parentQuestion) {
                    QCellModel *qcell = [[QCellModel alloc] initWithQuestionModel:quesitonCell];
                    [parentQuestion.values addObject:qcell];
                }
            }
            
            [SVProgressHUD dismiss];
            self.questionArray = [parentQuestionsDic allValues];
            [self.tableview reloadData];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
    

}

- (QCellModel *) getQuestionModel : (NSIndexPath *)index
{
    QuestionModel *questionModel =[self.questionArray objectAtIndex:index.section];
    return questionModel.values[index.row];
}


#pragma mark - tableview deletage


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.questionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.questionArray.count > 0) {
        QuestionModel *question = [self.questionArray objectAtIndex:section];
        return question.isOpened ? question.values.count : 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    QuestionModel *ques =[self.questionArray objectAtIndex:indexPath.section];
    QCellModel *questionValue =[ques.values objectAtIndex:indexPath.row];
    [cell configCell:questionValue withCurrentQuestionSelectId:ques.selectIds withIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    
    headView.delegate = self;
    [headView setQuestion:[self.questionArray objectAtIndex:section]];
    [headView setQuestion:[self.questionArray objectAtIndex:section] withSection:section];
    headView.question = self.questionArray[section];
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QCellModel *value = [self getQuestionModel:indexPath];
    QuestionModel *q = [self.questionArray objectAtIndex:indexPath.section];
    if (!q.isMultiSelect) {
        [q.selectIds removeAllObjects];
    }
    if ([q.selectIds containsObject:[NSNumber numberWithInt:value.value_id]]) {
        [q.selectIds removeObject:[NSNumber numberWithInt:value.value_id]];
    }else{
        [q.selectIds addObject:[NSNumber numberWithInt:value.value_id ]];
    }
    
    [q.selectNames addObject:value.value_name];
    [self.tableview reloadData];
    
    if (!q.isMultiSelect && indexPath.section + 1 < self.tableview.numberOfSections) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:indexPath.section + 1];
        
        [self.tableview scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
       
    }
   
}

- (void)clickHeadView
{
    [self.tableview reloadData];
}

#pragma mark - commit


- (IBAction)CommitQuestionAction:(id)sender {
    for (int i = 0 ; i < self.questionArray.count; i++) {
        QuestionModel *question = self.questionArray[i];
        if (question.selectIds.count <= 0) {
            [self.view makeToast:@"您还有未填写的问题"];
            return;
        }
        self.tempIds = nil;
        self.tempNames = nil;
        for (NSNumber *num in  question.selectIds) {
                NSInteger i = [num integerValue];
            if (self.tempIds) {
                self.tempIds = [NSString stringWithFormat:@"%@,%d",self.tempIds,i];
            }else{
                self.tempIds = [NSString stringWithFormat:@"%d",i];
            }
        }
        for (NSString *name in question.selectNames) {
            if (self.tempNames) {
                self.tempNames = [NSString stringWithFormat:@"%@,%@",self.tempNames,name];
            }else{
                self.tempNames = [NSString stringWithFormat:@"%@",name];
            }
        }
    }
    if (self.tempIds) {
        NSString *postData = [NSString stringWithFormat:@"{'Attributes':[%@],'EquipmentID':%ld}",self.tempIds,self.phoneModel.product_id];
        NSURL *url =[NSURL URLWithString:[URL_PHONE_CREATE_ORDER(postData) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
       [NetUtils doPost2:nil withUrl:url withResultBlock:^(NSString *result) {
           NSError *error;
               NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
           OrderModel *order = [[OrderModel alloc] initWithDictionary:[jsonDic objectForKey:@"Data"]];
           if (order) {
               order.phoneModel = self.phoneModel;
//               ConfirmOrderCongroller *confirmOrderController = [appDelegate.phoneStoryBoard instantiateViewControllerWithIdentifier:@"ConfirmOrderCongroller"];
//               confirmOrderController.orderModel = order;
//               confirmOrderController.productAttributeValues = self.tempNames;
//               confirmOrderController.productAttributeValuesIds = self.tempIds;
//               [self.navigationController pushViewController:confirmOrderController animated:YES];
               RevaluationViewController *revaluation = [[RevaluationViewController alloc] initWithNibName:@"RevaluationViewController" bundle:nil];
               revaluation.price =  order.price;
               [self.navigationController pushViewController:revaluation animated:YES];
            
           }else{
               [SVProgressHUD showErrorWithStatus:@"订单生成错误"];
           }
        }];
        
    }
}



@end
