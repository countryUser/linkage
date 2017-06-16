//
//  ViewPager.m
//  Linkage
//
//  Created by adminuser on 17/6/8.
//  Copyright © 2017年 adminuser. All rights reserved.
//

#import "ViewPager.h"

@interface ViewPager ()

@property(nonatomic, strong) UIScrollView *topScrollView;
@property(nonatomic, strong) UIScrollView *bottomScrollView;

@property(nonatomic, strong) NSMutableArray *titlesArr; //标题数组
@property(nonatomic, strong) NSMutableArray *viewsArr;  //view数组

@property(nonatomic, strong) NSMutableArray *buttonsArr;//按钮数组

@end

@implementation ViewPager


-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViews:(NSArray *)views{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topScrollView];
        [self addSubview:self.bottomScrollView];
        
        self.topScrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height*0.1);
        self.bottomScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), frame.size.width, frame.size.height*0.9);
        
        [self.titlesArr addObjectsFromArray:titles];
        [self.viewsArr addObjectsFromArray:views];
        
        [self addTitles:titles withViews:views];
    }
    return self;
}
#pragma mark - 懒加载
-(UIScrollView *)topScrollView{
    if (_topScrollView == nil){
        _topScrollView = [[UIScrollView alloc] init];
        
    }
    return _topScrollView;
}
-(UIScrollView *)bottomScrollView{
    if(_bottomScrollView == nil){
        _bottomScrollView = [[UIScrollView alloc] init];
        
    }
    return _bottomScrollView;
}

-(NSMutableArray *)titlesArr{
    if (_titlesArr == nil) {
        _titlesArr = [NSMutableArray array];
    }
    return _titlesArr;
}
-(NSMutableArray *)viewsArr{
    if (_viewsArr == nil) {
        _viewsArr = [NSMutableArray array];
    }
    return _viewsArr;
}

-(NSMutableArray *)buttonsArr{
    if (_buttonsArr == nil) {
        _buttonsArr = [NSMutableArray array];
    }
    return _buttonsArr;
}


#pragma mark - 公开方法
-(void)addTitle:(NSString *)title withView:(UIView *)view{
    
    CGSize topSize = self.topScrollView.contentSize;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(topSize.width, 0, 50, CGRectGetHeight(self.topScrollView.frame))];
    [btn setTitle:title forState:UIControlStateNormal];
    [self.topScrollView addSubview:btn];
    topSize.width += 50;
    self.topScrollView.contentSize = topSize;
    
    
    CGSize size = self.bottomScrollView.contentSize;
    view.frame = CGRectMake(size.width, 0, CGRectGetWidth(self.bottomScrollView.frame), CGRectGetHeight(self.bottomScrollView.frame));
    size.width += CGRectGetWidth(self.bottomScrollView.frame);
    self.bottomScrollView.contentSize = size;
    [self.bottomScrollView addSubview:view];
    
    [self.titlesArr addObject:title];
    [self.viewsArr addObject:view];
    
}

-(void)addTitles:(NSArray *)array withViews:(NSArray *)views{
    CGSize topSize = self.topScrollView.contentSize;
    for (int i=0; i<array.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(topSize.width, 0, 50, CGRectGetHeight(self.topScrollView.frame))];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [self.topScrollView addSubview:btn];
        topSize.width += 50;
    }
    self.topScrollView.contentSize = topSize;
    
    CGSize size = self.bottomScrollView.contentSize;
    for (int i=0; i<views.count; i++) {
        UIView *view = views[i];
        view.frame = CGRectMake(size.width, 0, CGRectGetWidth(self.bottomScrollView.frame), CGRectGetHeight(self.bottomScrollView.frame));
        size.width += CGRectGetWidth(self.bottomScrollView.frame);
        [self.bottomScrollView addSubview:view];
    }
    self.bottomScrollView.contentSize = size;
   
    
    
    [self.titlesArr addObjectsFromArray:array];
    [self.viewsArr addObjectsFromArray:views];
}

#pragma mark - 私有方法


@end
