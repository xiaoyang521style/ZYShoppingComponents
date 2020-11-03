//
//  ZYShoppingCarController.m
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import "ZYShoppingCarViewController.h"
#import "ZYShoppingCarView.h"
@interface ZYShoppingCarViewController ()
@property(nonatomic, copy)NSDictionary *params;
@property(nonatomic, copy)void(^callBackBlock) (NSString *);
@end

@implementation ZYShoppingCarViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if ([super init]) {
        self.callBackBlock = params[@"callback"];
        self.params = params[@"params"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"购物车";
    ZYShoppingCarView *shoppingCarView =  [[ZYShoppingCarView alloc]initWithController:self frame:self.view.bounds];
    
    [self.view addSubview:shoppingCarView];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
