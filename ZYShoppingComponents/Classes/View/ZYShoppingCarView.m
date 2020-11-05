//
//  ZYShoppingCarView.m
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import "ZYShoppingCarView.h"
#import "ZYShoppingCarModel.h"
#import "ZYShoppingCarCell.h"
#import "ZYShoppingCartHeaderView.h"
#import "ZYShoppingCarViewModel.h"
#import "ZYShoppingHeader.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ZYUnderlyingComponents/UIColor+ZYHex.h>
@interface ZYShoppingCarView ()<UITableViewDelegate,UITableViewDataSource,ZYShoppingCartEndViewDelegate,ZYShoppingCarCellDelegate>
@property(nonatomic,strong)ZYShoppingCarViewModel *viewModel;
@property(nonatomic, weak) UIViewController *controlller;
@end
@implementation ZYShoppingCarView

-(instancetype)initWithController:(UIViewController *)controller frame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.controlller = controller;
        [self addSubviews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews {
    [self addSubview:self.tableView];
    [self addSubview:self.endView];
}

-(void)setControlller:(UIViewController *)controlller {
    _controlller = controlller;
    
    [self finshBarView];
   [self loadNotificationCell];
   
   self.controlller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edits:)];
}

-(void)finshBarView
{
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, APPScreenHeight, APPScreenWidth, 44)];
    [_toolbar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.previousBarButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(previousButtonIsClicked:)];
    NSArray *barButtonItems = @[flexBarButton,self.previousBarButton];
    _toolbar.items = barButtonItems;
    [self addSubview:_toolbar];
}
-(void)loadNotificationCell
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

}



#pragma mark TableViewDelegate,TableViewDataSource
// 交给ViewModel去实现

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.viewModel numberOfSections];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return [self.viewModel heightForHeaderInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self.viewModel heightForFooterInSection:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    __weak typeof(ZYShoppingCarViewModel ) *vm = self.viewModel;
    __weak typeof (NSMutableArray ) *carDataArrList = self.viewModel.carDataArrList;
    __weak typeof (UITableView ) *tableViews = _tableView;
    ZYShoppingCartHeaderView * heardView =[[ZYShoppingCartHeaderView  alloc]initWithFrame:CGRectMake(0, 0, APPScreenWidth, 40) section:section carDataArrList:self.viewModel.carDataArrList block:^(UIButton *bt) {
        [vm clickAllBT:carDataArrList bt:bt];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:bt.tag-100];
        [tableViews reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }];
    heardView.tag = 1999+section;
    heardView.backgroundColor=[UIColor whiteColor];
    return heardView;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *shoppingCaridentis = @"ZYShoppingCarCell";
    ZYShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingCaridentis];
    if (!cell) {
        cell = [[ZYShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shoppingCaridentis tableView:tableView];
        cell.delegate=self;
    }
    if (self.viewModel.carDataArrList.count>0) {
        cell.isEdit = self.isEdit;
        NSArray *list = [self.viewModel.carDataArrList objectAtIndex:indexPath.section];
        cell.row = indexPath.row+1;
        [cell setModel:[list objectAtIndex:indexPath.row]];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        if (list.count-2 !=indexPath.row) {
            UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(45, [ZYShoppingCarCell getHeight]-0.5, APPScreenWidth-45, 0.5)];
            line.backgroundColor=[UIColor colorWithHexString:@"e2e2e2"];
            [cell addSubview:line];
        }
    }
    return cell;
    
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.userInteractionEnabled=YES;
        _tableView.dataSource = self;
        _tableView.scrollsToTop=YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    }
    return _tableView;
}
-(ZYShoppingCartEndView *)endView
{
    if (!_endView) {
        _endView = [[ZYShoppingCartEndView alloc]initWithFrame:CGRectMake(0, APPScreenHeight-[ZYShoppingCartEndView getViewHeight], APPScreenWidth, [ZYShoppingCartEndView getViewHeight])];
        _endView.delegate=self;
        _endView.isEdit = _isEdit;
    }
    return _endView;
}

-(void)dealloc
{
    _tableView = nil;
    _tableView.dataSource=nil;
    _tableView.delegate=nil;
    self.viewModel = nil;
    self.endView = nil;
    //移除该响应者的全部通知
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
    NSLog(@"ZYShoppingCarView释放了。。。。。");
}
#pragma mark ZYShoppingCartEndViewDelegate

-(void)clickALLEnd:(UIButton *)bt {
    //全选 也可以在 VM里面 写  这次在Controller里面写了
    
    
    bt.selected = !bt.selected;
    
    BOOL btselected = bt.selected;
    
    NSString *checked = @"";
    if (btselected) {
        checked = @"YES";
    }
    else
    {
        checked = @"NO";
    }
    
    [self.viewModel seletAll:checked select:btselected edit:self.isEdit];
    [_tableView reloadData];
}

-(void)clickRightBT:(UIButton *)bt{
    if(bt.tag==19)
    {
        //删除
        [_viewModel delectSelet];
        [_tableView reloadData];
    }
    else if (bt.tag==18)
    {
        //结算
        [_viewModel settlement];
        [_tableView reloadData];
    }
}
#pragma mark ZYShoppingCarCellDelegate
-(void)singleClick:(ZYShoppingCarModel *)models row:(NSInteger )row {
    [_viewModel pitchOn];
    if (models.type==1) {
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
    else if(models.type==2)
    {
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)edits:(UIBarButtonItem *)item
{
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        item.title = @"取消";
    }
    else{
        item.title = @"编辑";
    }
    [self.viewModel edits:self.isEdit];
    self.endView.isEdit = self.isEdit;
    [self.viewModel pitchOn];
    [self.tableView reloadData];
}
- (void) previousButtonIsClicked:(id)sender
{
    [self endEditing:YES];
}



- (void)keyboardWillShow:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.origin.y;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    NSArray *subviews = [self subviews];
    for (UIView *sub in subviews) {
        CGFloat maxY = CGRectGetMaxY(sub.frame);
        if ([sub isKindOfClass:[UITableView class]]) {

                sub.frame = CGRectMake(0, 0, sub.frame.size.width, APPScreenHeight-_toolbar.frame.size.height-rect.size.height);
                sub.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, sub.frame.size.height/2);

        }else{
            if (maxY > y - 2) {
                sub.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, sub.center.y - maxY + y );
            }
        }
    }
    [UIView commitAnimations];
}

- (void)keyboardShow:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
}

- (void)keyboardWillHide:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    NSArray *subviews = [self subviews];
    for (UIView *sub in subviews) {
        if (sub.center.y < CGRectGetHeight(self.frame)/2.0) {
            sub.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0);
        }
    }
      _toolbar.frame=CGRectMake(0, APPScreenHeight, APPScreenWidth, _toolbar.frame.size.height);
    _endView.frame = CGRectMake(0, self.frame.size.height-_endView.frame.size.height, APPScreenWidth, _endView.frame.size.height);

    self.tableView.frame=CGRectMake(0, 0, self.tableView.frame.size.width, APPScreenHeight-[ZYShoppingCartEndView getViewHeight]);
    [UIView commitAnimations];
}

- (void)keyboardHide:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
}


//绑定viewModel
- (void)bindViewModel:(id)viewModel {
    self.viewModel = viewModel;
    @weakify(self);
    //监听价格变化
    [[RACObserve(self.viewModel,price) ignore:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSArray *lists = [self.endView.Lab.text componentsSeparatedByString:@"￥"];
        self.endView.Lab.text = [NSString stringWithFormat:@"%@%@",lists[0],x];
    }];
}

/**
 请求网络数据 绑定数据
 */
- (void)setupBinding {
    @weakify(self);
    [self.viewModel getShopData:^(NSArray * _Nonnull commonArry, NSArray * _Nonnull kuajingArry) {
            @strongify(self);
            [self.tableView reloadData];
    }];
    
}

/**
 设置数据回调，点击事件处理
 */
- (void)setupData{
    
}
@end
