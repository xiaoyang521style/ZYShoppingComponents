//
//  ZYShoppingCarCell.h
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZYShoppingCarModel;
@protocol  ZYShoppingCarCellDelegate  ;
@interface ZYShoppingCarCell : UITableViewCell

@property(nonatomic,strong)ZYShoppingCarModel *model;
@property(nonatomic,assign)NSInteger choosedCount;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)BOOL isEdit;

@property(nonatomic,weak)id<ZYShoppingCarCellDelegate> delegate;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;

+(CGFloat)getHeight;

@end

@protocol ZYShoppingCarCellDelegate <NSObject>

-(void)singleClick:(ZYShoppingCarModel *)models row:(NSInteger )row;

@end


NS_ASSUME_NONNULL_END
