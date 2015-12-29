//
//  TYShufflingView.m
//  pictureDy
//
//  Created by 汤义 on 15/12/29.
//  Copyright © 2015年 汤义. All rights reserved.
//

#import "TYShufflingView.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface TYShufflingView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *lbi;
@property (nonatomic, strong) NSArray *accordingArray;
@property (nonatomic, strong) UIImageView *cycleImageView;
@property (nonatomic, assign) BOOL slidingTag;//标记做个完整的转动标记
@property (nonatomic, assign) CGPoint last;//储存上一个点
@property (nonatomic, assign) BOOL movements;//是向什么位置移动
@property (nonatomic, strong) NSString *str;
@property (nonatomic, assign) BOOL whether;//用来判断刚开始滑动不翻页，去掉上次滑动的最后数据
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) int cumulative;
@end

@implementation TYShufflingView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
    }
    [self addControls];
    return self;
}

+ (instancetype)initView {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, Width, Height - 150)];
}

- (void)addControls {
    _accordingArray = [NSArray arrayWithObjects:@"第一组",@"第二组",@"第三组",@"第四组", nil];
    
    _lbi = [[UILabel alloc] initWithFrame:CGRectMake(100, Height - 150, 70, 50)];
    _lbi.text = _accordingArray[0];
    [self addSubview:_lbi];
    
    _cycleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - 150)];
     _cycleImageView.image = [UIImage imageNamed:@"picture0"];
    [self addSubview:_cycleImageView];
   
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pans:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
}

- (void)pans:(UIPanGestureRecognizer *)gestureRecognizer {
    _point = [gestureRecognizer translationInView:self];
  
    if (_whether == YES) {
        if (_point.y > _last.y ) {
            _movements = NO;
            _str = kCATransitionFromBottom;
            NSLog(@"向下走");
        }else if(_point.y < _last.y ){
            _movements = YES;
            _str = kCATransitionFromTop;
            NSLog(@"向上周");
        }
        if (_slidingTag == NO) {
            [self scrollTimer];
        }
    }
    
    
    _last = _point;
    _whether = YES;
}
- (void)scrollTimer {
    
    _slidingTag = YES;
    if (_movements == NO) {
        if (_cumulative == 3) {
            _cumulative = 0;
        }else{
            _cumulative = _cumulative + 1;
        }
    }else if(_movements == YES){
        if (_cumulative == 0) {
            _cumulative = 3;
        }else{
            _cumulative = _cumulative - 1;
        }
    }
    
    CATransition *transition = [CATransition animation];
    transition.delegate = self;
    transition.duration = 2.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = @"cube"  ;//另一种设置动画效果方法
    transition.subtype = _str;
    
    [self exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [self.layer addAnimation:transition forKey:@"animation"];
    
}

//执行前的代理方法
- (void)animationDidStart:(CAAnimation *)anim {
    
    _lbi.text = _accordingArray[_cumulative];
    NSLog(@"accordingArray:%@",_accordingArray[_cumulative]);
    NSString *image = [NSString stringWithFormat:@"picture%d",_cumulative];
    _cycleImageView.image = [UIImage imageNamed:image];

}
//执行后的代理方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _slidingTag = NO;
    _whether = NO;
}

@end
