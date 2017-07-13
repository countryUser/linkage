//
//  ViewPager.m
//  Linkage
//
//  Created by adminuser on 17/6/8.
//  Copyright © 2017年 adminuser. All rights reserved.
//

#import "ViewPager.h"

static const CGFloat indexViewHeigh = 5.0; //指示标view的高度

@interface ViewPager ()<UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *topScrollView;
@property(nonatomic, strong) UIScrollView *bottomScrollView;

@property(nonatomic, strong) NSMutableArray *titlesArr; //标题数组
@property(nonatomic, strong) NSMutableArray *viewsArr;  //view数组

@property(nonatomic, strong) NSMutableArray *buttonsArr;//按钮数组

@property(nonatomic, strong) UIView *indexView; //指示标view

@end

@implementation ViewPager


-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViews:(NSArray *)views{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topScrollView];
        [self addSubview:self.bottomScrollView];
        
        self.topScrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height*0.06);
        [self.topScrollView addSubview:self.indexView];
        
        self.bottomScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame)+5, frame.size.width, frame.size.height*0.9);
        
        
//        [self.titlesArr addObjectsFromArray:titles];
//        [self.viewsArr addObjectsFromArray:views];
        
        [self addTitles:titles withViews:views];
        
        [self makeCurrentIndex:0];
    }
    return self;
}
#pragma mark - 懒加载
-(UIScrollView *)topScrollView{
    if (_topScrollView == nil){
        _topScrollView = [[UIScrollView alloc] init];
        _topScrollView.delegate = self;
    }
    return _topScrollView;
}
-(UIScrollView *)bottomScrollView{
    if(_bottomScrollView == nil){
        _bottomScrollView = [[UIScrollView alloc] init];
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        
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
-(UIView *)indexView{
    if (_indexView == nil) {
        _indexView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.topScrollView.frame)-indexViewHeigh, 0, indexViewHeigh)];
        _indexView.backgroundColor = [UIColor blackColor];
    }
    return _indexView;
}


#pragma mark - 公开方法
-(void)addTitle:(NSString *)title withView:(UIView *)view{
    
    CGSize topSize = self.topScrollView.contentSize;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(topSize.width, 0, 50, CGRectGetHeight(self.topScrollView.frame)-indexViewHeigh)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    
    btn.tag = self.buttonsArr.count;
    [self.buttonsArr addObject:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(topSize.width, 0, 50, CGRectGetHeight(self.topScrollView.frame)-indexViewHeigh)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        [self.topScrollView addSubview:btn];
        topSize.width += 50;
        
        btn.tag = self.buttonsArr.count;
        [self.buttonsArr addObject:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)makeCurrentIndex:(NSInteger)curentIndex{
//    if(_currentIndex == curentIndex){
//        return ;
//    }
    
    UIButton *btn = [self.buttonsArr objectAtIndex:self.currentIndex];
    btn.selected = NO;
    _currentIndex = curentIndex;
    btn = [self.buttonsArr objectAtIndex:self.currentIndex];
    btn.selected = YES;
    
    self.bottomScrollView.contentOffset = CGPointMake(self.currentIndex*self.frame.size.width, 0);
    [self makeIndexView:_currentIndex];
}

#pragma mark - 私有方法
-(void)makeIndexView:(NSInteger)index{
    UIButton *btn = [self.buttonsArr objectAtIndex:index];
    
    CGRect rect = self.indexView.frame;
    rect.origin.x = btn.frame.origin.x;
    rect.size.width = btn.titleLabel.frame.size.width;
    self.indexView.frame = rect;
}


#pragma mark - button Action
-(void)btnAction:(UIButton *)sender{
    int tag = (int)sender.tag;
    
    UIButton *btn = [self.buttonsArr objectAtIndex:self.currentIndex];
    btn.selected = NO;
    sender.selected = YES;
    _currentIndex = tag;
    self.bottomScrollView.contentOffset = CGPointMake(tag*self.frame.size.width, 0);
    
    [self makeIndexView:self.currentIndex];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.bottomScrollView) {
        float offSet = scrollView.contentOffset.x / self.frame.size.width;
//        int index1 = floor(offSet); //向下取整，不大于浮点数的最大整数
//        int index2 = ceil(offSet);  //向上取整， 取不小于浮点数的最小整数
        int index = (int)(offSet + 0.5);
        
        UIButton *btn = [self.buttonsArr objectAtIndex:self.currentIndex];
        btn.selected = NO;
        _currentIndex = index;
        btn = [self.buttonsArr objectAtIndex:self.currentIndex];
        btn.selected = YES;
        
        [self makeIndexView:self.currentIndex];
    }
}

@end
