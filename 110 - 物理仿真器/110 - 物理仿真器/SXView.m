//
//  SXView.m
//  110 - 物理仿真器
//
//  Created by 董 尚先 on 15/3/21.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXView.h"

@implementation SXView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 150, rect.size.width, rect.size.width)];
    [[UIColor whiteColor] setStroke];
//    [path stroke];
}


@end
