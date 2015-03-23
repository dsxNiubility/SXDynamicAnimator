//
//  ViewController.m
//  110 - 物理仿真器
//
//  Created by 董 尚先 on 15/3/21.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *sxView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bigBlock;
@property (weak, nonatomic) IBOutlet UIStepper *smallBlock;

@end

@implementation ViewController

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        // 创建一个物理仿真器
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获得手指对应的触摸对象
    UITouch *touch = [touches anyObject];
    
    // 获得触摸点
    CGPoint point = [touch locationInView:self.view];
    
    // 捕捉行为
    [self testSnap:point];
    
//    [self testGravityAndCollision3];
}

- (void)testSnap:(CGPoint)point
{
    // 1.创建捕捉行为
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.sxView snapToPoint:point];
    // 防震系数，damping越大，振幅越小
    snap.damping = 1;
    
    // 2.开始
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:snap];
}

/**
 * 重力行为 + 碰撞行为
 */
- (void)testGravityAndCollision3
{
    // 1.创建重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.sxView];
    
    // 2.创建碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.sxView];
    [collision addItem:self.smallBlock];
    // 添加边界
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,150, self.view.frame.size.width, self.view.frame.size.width)];
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    
    // 3.开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 * 重力行为 + 碰撞行为
 */
- (void)testGravityAndCollision2
{
    // 1.创建重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    // magnitude越大，速度增长越快
    gravity.magnitude = 10;
    [gravity addItem:self.sxView];
    
    // 2.创建碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.sxView];
    [collision addItem:self.bigBlock];
    [collision addItem:self.smallBlock];
    // 设置碰撞的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 3.开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 * 重力行为 + 碰撞行为
 */
- (void)testGravityAndCollision
{
    // 1.创建重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.sxView];
    
    // 2.创建碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.sxView];
    [collision addItem:self.bigBlock];
    [collision addItem:self.smallBlock];
    // 设置碰撞的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 3.开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 * 重力行为
 */
- (void)testGravity
{
    // 1.创建仿真行为 - 重力行为
    UIGravityBehavior *behavior = [[UIGravityBehavior alloc] init];
    behavior.magnitude = 1;
    [behavior addItem:self.sxView];
    
    // 2.添加到物理仿真器中
    [self.animator addBehavior:behavior];
}

@end