//
//  ShowNumberView.h
//  Mirror
//
//  Created by  GaoGao on 2020/5/24.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowNumberView : UIView
@property (weak, nonatomic) IBOutlet UILabel *NumberL;

/// type 1白色  2黄色
-(void)setText:(NSString *)text andColor:(NSInteger )type;


@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic, assign)BOOL isMirror;

/// 显示结束 block
@property (nonatomic, copy)void (^showEndBlock) (void);


-(void)showText:(NSString *)text;


/// 开始显示  设置时间
- (void)showWithSpace:(float)space andAnmintTime:(float)time;


@end

NS_ASSUME_NONNULL_END
