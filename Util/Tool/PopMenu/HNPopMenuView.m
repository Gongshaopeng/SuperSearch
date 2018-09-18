//
//  HNQQDropMenuView.m
//  HNPopMenu
//
//  Created by ZakariyyaSv on 16/4/2.
//  Copyright © 2016年 ZakariyyaSv. All rights reserved.
//

#import "HNPopMenuView.h"
#import "HNPopMenuTableViewCell.h"
#import "HNPopMenuManager.h"
#import "HNPopMenuModel.h"

static const CGFloat triangleHeight = 16.0f;
static const CGFloat margin = 14.0f;
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface HNPopMenuView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,assign) CGPoint startPoint;

@end

@implementation HNPopMenuView

- (instancetype)initWithView:(UIView *)view items:(NSArray *)itemArr{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        _menuWidth = screenWidth/2-8;
        _cellHeight = 44.0f;
        _limitMargin = 40.0f;
        _dismissed = YES;
        CGRect convertFrame = [view.superview convertRect:view.frame toView:self];
        CGFloat viewCenterX = convertFrame.origin.x + convertFrame.size.width * 0.5;
        CGFloat tableViewY = CGRectGetMaxY(convertFrame) + margin;
        CGFloat tableViewX = viewCenterX - _menuWidth * 0.5 + _menuWidth * 0.5;
        CGFloat orginTableViewH = _cellHeight * itemArr.count;
        CGFloat tableViewH = (orginTableViewH + tableViewY + _limitMargin) <= screenHeight ? orginTableViewH : (screenHeight - tableViewY - _limitMargin);
        tableViewY = tableViewY - 0.5 * tableViewH;
        if (tableViewX < margin + _menuWidth * 0.5) {
            tableViewX = margin - _menuWidth * 0.5;
        }
        else if (tableViewX + _menuWidth > [UIScreen mainScreen].bounds.size.width - margin){
            tableViewX = [UIScreen mainScreen].bounds.size.width - margin - _menuWidth * 0.5;
        }
        _startPoint = CGPointMake(viewCenterX, tableViewY - triangleHeight + 0.5 * tableViewH);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, _menuWidth, tableViewH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
        _tableView.layer.cornerRadius = 4.0f;
        _tableView.layer.masksToBounds = YES;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.layer.anchorPoint = viewCenterX > [UIScreen mainScreen].bounds.size.width * 0.5 ? CGPointMake(1.0f, 0.0f) :CGPointMake(0.0f, 0.0f);
        _tableView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _tableView.rowHeight = _cellHeight;
        _dataArr = itemArr;
        [self addSubview:_tableView];
        [self drawTriangleLayer];
    }
    return self;
}

- (void)drawTriangleLayer {
    CGFloat triangleLength = triangleHeight * 2.0 / 1.732;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_startPoint];
    [path addLineToPoint:CGPointMake(_startPoint.x - triangleLength * 0.5, _startPoint.y + triangleHeight)];
    [path addLineToPoint:CGPointMake(_startPoint.x + triangleLength * 0.5, _startPoint.y + triangleHeight)];
    CAShapeLayer *triangleLayer = [CAShapeLayer layer];
    triangleLayer.path = path.CGPath;
    triangleLayer.fillColor = self.tableView.backgroundColor.CGColor;
    triangleLayer.strokeColor = self.tableView.backgroundColor.CGColor;
    self.triangleLayer = triangleLayer;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.layer addSublayer:triangleLayer];
    });
}

- (void)setTableViewBackgroundColor:(UIColor *)backgroundColor{
    [self.triangleLayer removeFromSuperlayer];
    [self drawTriangleLayer];
}

- (void)setMenuWidth:(CGFloat)menuWidth{
    _menuWidth = menuWidth;
    CGRect tableViewFrame = _tableView.frame;
    CGPoint tableViewCenter = _tableView.center;
    tableViewFrame.size.width = _menuWidth;
    tableViewFrame.origin.x = tableViewCenter.x - _menuWidth * 0.5;
    if (tableViewFrame.origin.x < margin + _menuWidth * 0.5) {
        tableViewFrame.origin.x = margin - _menuWidth * 0.5;
    }
    else if (tableViewFrame.origin.x > [UIScreen mainScreen].bounds.size.width - margin){
        tableViewFrame.origin.x = [UIScreen mainScreen].bounds.size.width - margin - _menuWidth * 0.5;
    }
    _tableView.frame = tableViewFrame;
}

- (void)setCellHeight:(CGFloat)cellHeight{
    _cellHeight = cellHeight;
    _tableView.rowHeight = _cellHeight;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [HNPopMenuManager dismiss];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNPopMenuTableViewCell *cell = [[HNPopMenuTableViewCell alloc] initWithTableView:tableView];
    HNPopMenuModel *model = self.dataArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:model.imageName];
    cell.textLabel.text = model.title;
    cell.backgroundColor = tableView.backgroundColor;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(QQPopMenuView:didSelectRow:)]) {
        [self.delegate QQPopMenuView:self didSelectRow:indexPath.row];
        self.dismissed == YES ? [HNPopMenuManager dismiss] : nil;
    }
    if (self.clickAction) {
        self.clickAction(indexPath.row);
        self.dismissed == YES ? [HNPopMenuManager dismiss] : nil;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
