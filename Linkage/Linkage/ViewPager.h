//
//  ViewPager.h
//  Linkage
//
//  Created by adminuser on 17/6/8.
//  Copyright © 2017年 adminuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPager : UIView



@property(nonatomic, strong) NSDictionary *contentValues;

@property(nonatomic, assign) NSInteger currentIndex; //当前显示第几项

-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViews:(NSArray *)views;

//设置显示第几页
-(void)makeCurrentIndex:(NSInteger)curentIndex;

/** 添加 标题 和 view **/
-(void)addTitle:(NSString *)title withView:(UIView *)view;
-(void)addTitles:(NSArray *)array withViews:(NSArray *)views;

@end
