//
//  ShowNumberView.m
//  Mirror
//
//  Created by  GaoGao on 2020/5/24.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "ShowNumberView.h"
#import "UILabel+WordSpacing.h"
#import "SNTimer.h"
#import "UILabel+WordSpacing.h"
#import "ConfigHeader.h"
#import "NSArray+ErrorHandle.h"
@interface ShowNumberView ()
/// 这个label 翻转会有问题


@property (nonatomic, strong)UILabel *mirrorLabel;

@property (nonatomic,strong) SNTimer *gcdTimer;

@property (nonatomic, strong)NSMutableArray *labeArr;

@property (nonatomic, assign)NSInteger currentIndex;

@end

@implementation ShowNumberView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
//    [self.NumberL setText:@"123" withWordSpacing:50.0];
    

}


-(void)setIsMirror:(BOOL)isMirror {
    
    _isMirror = isMirror;
}



-(void)showText:(NSString *)text {
    
    
    self.NumberL.text = text;
    
    
    
    return;
    
    
    
    for (UIView *sub in self.NumberL.subviews) {
        [sub removeFromSuperview];
    }
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:self.NumberL.bounds];
    
    label.font = [UIFont systemFontOfSize:110];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.text = text;
//    [label setText:text withWordSpacing:20.0];
    
    [self.NumberL addSubview:label];
    
    [self ceshi:self.isMirror withView:label];
    
    
}


-(void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    
    self.labeArr = [[NSMutableArray alloc]init];
    
    for (UIView *sub in self.NumberL.subviews) {
        [sub removeFromSuperview];
    }
    
    
    for (int i=0; i<_dataArr.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:self.NumberL.bounds];
        
        
        [label setText:[_dataArr objectAtIndexVerify:i] withWordSpacing:20.0];
        [self.NumberL addSubview:label];
        
        
        if (self.isMirror) {
            
            [self ceshi:YES withView:label];
        }
        
        if (i==0) {
            label.hidden = NO;
            
        }else{
            
            label.hidden = YES;
        }
        [self.labeArr addObject:label];
    }
    

}


/// 开始显示  设置时间
- (void)showWithSpace:(float)space andAnmintTime:(float)time {
    
//    self.labeArr = [[NSMutableArray alloc]init];
//
//    for (UIView *sub in self.NumberL.subviews) {
//        [sub removeFromSuperview];
//    }
//
//
//    for (int i=0; i<20; i++) {
//
//        UILabel *label = [[UILabel alloc]initWithFrame:self.NumberL.bounds];
//        label.tag = 1000+(i%2);
//
//        [label setText:[NSString stringWithFormat:@"123%d",i] withWordSpacing:30.0];
//        [self.NumberL addSubview:label];
//
//
//
//        if (i==0) {
//            label.hidden = NO;
//            [self ceshi:YES withView:label];
//        }else{
//
//            label.hidden = YES;
//        }
//        [self.labeArr addObject:label];
//    }
    
    
    
    [NSThread sleepForTimeInterval:space];
    
 
    [_gcdTimer invalidate];
    
    @weakify(self)
    _gcdTimer = [SNTimer repeatingTimerWithTimeInterval:space block:^{
        @strongify(self)
        [self updateUI];
    }];
    
    self.currentIndex = 0;
    [_gcdTimer fire];
    
    
    
}


-(void)updateUI {
    
    
    
    
    UILabel *oldLabel = [self.labeArr objectAtIndexVerify:self.currentIndex];
    oldLabel.hidden = YES;
    [oldLabel removeFromSuperview];
    
    self.currentIndex++;
    
    UILabel *label = [self.labeArr objectAtIndexVerify:self.currentIndex];
    label.hidden = NO;
//    [self ceshi:label.tag ==1000 withView:label];
    
    
    
    
    if(_currentIndex == self.labeArr.count ){
        [_gcdTimer invalidate];
        self.showEndBlock ? self.showEndBlock() : nil;
    }
    
    
  
    
    
    
    
}




/// type 1白色  2黄色
-(void)setText:(NSString *)text andColor:(NSInteger )type {
    
    
    if(type == 2){
        [self.mirrorLabel setTextColor:UIColor.yellowColor];
        
    }else{
        [self.mirrorLabel setTextColor:UIColor.whiteColor];
    }
    
    
     [self.mirrorLabel setText:text withWordSpacing:50.0];
//    [self ceshi: type == 2 withView:self.mirrorLabel];
   
}


-(void)ceshi:(BOOL)state withView:(UIView *)view {
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.duration = 0.0001;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat: state ? 3.1415926 : 0.0];
    [view.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
    
}



-(UILabel *)mirrorLabel {
    
    if (!_mirrorLabel) {
        _mirrorLabel = [[UILabel alloc]initWithFrame:self.NumberL.bounds];
        [self.NumberL addSubview:self.mirrorLabel];
//        self.mirrorLabel.backgroundColor = UIColor.redColor;

            }
    
    return _mirrorLabel;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
