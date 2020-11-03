//
//  ZYViewController.m
//  ZYShoppingComponents
//
//  Created by xiaoyang521style on 11/03/2020.
//  Copyright (c) 2020 xiaoyang521style. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYShoppingCarViewController.h"
#import <ZYMediator+ZYShoppingCartModule.h>
@interface ZYViewController ()

@end

@implementation ZYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)goShoppingCar:(id)sender {
    
    UIViewController *VC = [[ZYMediator sharedInstance]ShoppingCartModule_viewControllerWithParam:@{} callback:^(NSString * _Nonnull result) {
        NSLog(@"resultA: --- %@", result);
    }];
    [self.navigationController pushViewController:VC animated:YES];
    
//    ZYShoppingCarViewController *car = [[ZYShoppingCarViewController alloc]init];
//    [self.navigationController pushViewController:car animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
