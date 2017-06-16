//
//  ViewPager.h
//  Linkage
//
//  Created by adminuser on 17/6/8.
//  Copyright © 2017年 adminuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPager : UIView

@property(nonatomic, strong) NSMutableArray *titlesArr; //标题数组
@property(nonatomic, strong) NSMutableArray *viewsArr; //view数组

@property(nonatomic, assign) NSInteger *currentIndex; //当前显示第几项



@end
