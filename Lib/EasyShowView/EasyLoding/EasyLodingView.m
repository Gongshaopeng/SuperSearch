//
//  EasyLodingView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyLodingView.h"
#import "UIView+EasyShowExt.h"
#import "EasyShowLabel.h"

#import "EasyLodingGlobalConfig.h"

@interface EasyLodingView()<CAAnimationDelegate>

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)NSString *showImageName ;//展示的图片
@property (nonatomic,strong)EasyLodingConfig *showConfig ;//展示的配置信息


@property (nonatomic,strong)UIView *lodingBgView ;//上面放着 textlabel 和 imageview
@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *imageView ;

@property (nonatomic,strong)UIActivityIndicatorView *imageViewIndeicator ;

@end

@implementation EasyLodingView

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame showText:(NSString *)showText iamgeName:(NSString *)imageName config:(EasyLodingConfig *)config
{
    if (self = [super initWithFrame:frame]) {
        self.showText = showText ;
        self.showImageName = imageName ;
        self.showConfig = config ;
        [self bluidUI];
    }
    return self ;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  [UIColor clearColor]; // [UIColor greenColor] ;//
    }
    return self ;
}

- (void)bluidUI
{
    //展示视图的frame
    CGSize imageSize = CGSizeZero ;
    switch (self.showConfig.lodingType) {
        case LodingShowTypeTurnAround:
        case LodingShowTypeTurnAroundLeft:
        case LodingShowTypeIndicator:
        case LodingShowTypeIndicatorLeft:
            imageSize = CGSizeMake(EasyShowLodingImageWH, EasyShowLodingImageWH);
            break;
        case LodingShowTypePlayImages:
        case LodingShowTypePlayImagesLeft:
        {
            NSAssert(self.showConfig.playImagesArray, @"you should set a image array!") ;
            UIImage *image = self.showConfig.playImagesArray.firstObject ;
            CGSize tempSize = image.size ;
            if (tempSize.height > EasyShowLodingImageMaxWH) {
                tempSize.height = EasyShowLodingImageMaxWH ;
            }
            if (tempSize.width > EasyShowLodingImageMaxWH) {
                tempSize.width = EasyShowLodingImageMaxWH ;
            }
            imageSize = tempSize ;
        }break ;
        case LodingShowTypeImageUpturn:
        case LodingShowTypeImageUpturnLeft:
        case LodingShowTypeImageAround:
        case LodingShowTypeImageAroundLeft:
        {
            UIImage *image = [[UIImage imageNamed:self.showImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//            UIImage *image = [UIImage imageNamed:self.showImageName];

            CGSize tempSize = image.size ;
            if (tempSize.height > EasyShowLodingImageMaxWH) {
                tempSize.height = EasyShowLodingImageMaxWH ;
            }
            if (tempSize.width > EasyShowLodingImageMaxWH) {
                tempSize.width = EasyShowLodingImageMaxWH ;
            }
            imageSize = tempSize ;
        }break ;
        default:
            break;
    }
    
    
    if (!ISEMPTY_S(self.showText)) {
        self.textLabel.text = self.showText ;
    }
    
    CGFloat textMaxWidth = EasyShowLodingMaxWidth ;
    if (self.showConfig.lodingType%2 == 0) {//当为左右形式的时候减去图片的宽度
        textMaxWidth -= EasyShowLodingImageWH+EasyShowLodingImageEdge*2 ;
    }
    
    CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(textMaxWidth, MAXFLOAT)];
    if (ISEMPTY_S(self.showText)) {
        textSize = CGSizeZero ;
    }
    
    //显示区域的宽高
    CGSize displayAreaSize = CGSizeZero ;
    if (self.showConfig.lodingType%2 == 0) {
        //左右形式
        displayAreaSize.width = imageSize.width + EasyShowLodingImageEdge*2 + textSize.width ;
        displayAreaSize.height = MAX(imageSize.height+ EasyShowLodingImageEdge*2, textSize.height) ;
    }
    else{
        //上下形式
        displayAreaSize.width = MAX(imageSize.width+2*EasyShowLodingImageEdge, textSize.width);
        displayAreaSize.height = imageSize.height+2*EasyShowLodingImageEdge + textSize.height ;
    }
    
    
    if (self.showConfig.superReceiveEvent) {
        //父视图能够接受事件 。 显示区域的大小=self的大小=displayAreaSize
        
        [self setFrame:CGRectMake((self.showConfig.superView.easyS_width-displayAreaSize.width)/2, (self.showConfig.superView.easyS_height-displayAreaSize.height)/2, displayAreaSize.width, displayAreaSize.height)];
    }
    else{
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        
        [self setFrame: CGRectMake(0, 0, self.showConfig.superView.easyS_width, self.showConfig.superView.easyS_height)] ;
        
        self.lodingBgView.center = self.center ;
        
    }
    
    self.lodingBgView.frame = CGRectMake(0,0, displayAreaSize.width,displayAreaSize.height) ;
    if (!self.showConfig.superReceiveEvent ) {
        self.lodingBgView.center = self.center ;
    }
    

    self.imageView.frame = CGRectMake(EasyShowLodingImageEdge, EasyShowLodingImageEdge, imageSize.width, imageSize.height) ;
    if (self.showConfig.lodingType%2 != 0) {//上下形式
        self.imageView.easyS_centerX = self.lodingBgView.easyS_width/2 ;
    }else{
        self.imageView.easyS_centerY = self.lodingBgView.easyS_height/2;
    }
    
    CGFloat textLabelX = 0 ;
    CGFloat textLabelY = 0 ;
    if (self.showConfig.lodingType%2 == 0 ) {//左右形式
        textLabelX = self.imageView.easyS_right  ;
        textLabelY =  (self.lodingBgView.easyS_height-textSize.height)/2 ;
    }
    else{
        textLabelX = 0 ;
        textLabelY = self.imageView.easyS_bottom + EasyShowLodingImageEdge ;
    }
    self.textLabel.frame = CGRectMake(textLabelX, textLabelY, textSize.width, textSize.height );
    
    if ((self.showConfig.lodingType%2 !=0) && !ISEMPTY_S(self.showText)) {
        self.imageView.easyS_y += 8 ;
    }
    
//    [superView addSubview:self];
    if (self.showConfig.cycleCornerWidth > 0) {
        [_lodingBgView setRoundedCorners:self.showConfig.cycleCornerWidth];
    }
    
    switch (self.showConfig.lodingType) {
        case LodingShowTypeTurnAround:
        case LodingShowTypeTurnAroundLeft:
            [self drawAnimationImageViewLoding];
            break;
        case LodingShowTypeIndicator:
        case LodingShowTypeIndicatorLeft:
            [self.imageView addSubview:self.imageViewIndeicator];
            break ;
        case LodingShowTypePlayImages:
        case LodingShowTypePlayImagesLeft:
        {
            UIImage *tempImage  = self.showConfig.playImagesArray.firstObject ;
            if (tempImage) {
                self.imageView.image = tempImage ;
            }
        }
            break ;
        case LodingShowTypeImageUpturn:
        case LodingShowTypeImageUpturnLeft:
            
        case LodingShowTypeImageAround:
        case LodingShowTypeImageAroundLeft:
        {
            UIImage *image = [[UIImage imageNamed:self.showImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            if (image) {
                self.imageView.image = image ;
            }
            else{
                NSAssert(NO, @"iamgeName is illgal ");
            }
        } break ;
        default:
            break;
    }
    
    
    void (^completion)(void) = ^{
        switch (self.showConfig.lodingType) {
            case LodingShowTypeTurnAround:
            case LodingShowTypeTurnAroundLeft:
                [self drawAnimiationImageView:NO];
                break;
            case LodingShowTypeIndicator:
            case LodingShowTypeIndicatorLeft:
                [self.imageViewIndeicator startAnimating];
                break ;
            case LodingShowTypePlayImages:
            case LodingShowTypePlayImagesLeft:
            {
                NSMutableArray *tempArray= [NSMutableArray arrayWithCapacity:20];
                for (int i = 0 ; i < self.showConfig.playImagesArray.count; i++) {
                    UIImage *img = self.showConfig.playImagesArray[i] ;
                    if ([img isKindOfClass:[UIImage class]]) {
                        [tempArray addObject:img];
                    }
                }
                self.imageView.animationImages = tempArray ;
                self.imageView.animationDuration = EasyShowAnimationTime ;
                //                self.imageView.animationRepeatCount = NSIntegerMax ;
                [self.imageView startAnimating];
                
            }break ;
            case LodingShowTypeImageUpturn:
            case LodingShowTypeImageUpturnLeft:
                [self drawAnimiationImageView:YES];
                break ;
            case LodingShowTypeImageAround:
            case LodingShowTypeImageAroundLeft:
                [self drawGradientaLayerAmination];
                break ;
            default:
                break;
        }
    };
    
    
    switch (self.showConfig.animationType) {
        case LodingAnimationTypeNone:
            completion() ;
            break;
        case LodingAnimationTypeBounce:
            [self showBounceAnimationStart:YES completion:completion];
            break ;
        case LodingAnimationTypeFade:
            [self showFadeAnimationStart:YES completion:completion ] ;
            break ;
        default:
            break;
    }
    
}

- (void)drawGradientaLayerAmination
{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    
    CGFloat layerRadius = self.imageView.easyS_width/2*1.0f ;
    shapeLayer.frame = CGRectMake(.0f, .0f,  layerRadius*2.f+3,  layerRadius*2.f+3) ;
    
    CGFloat cp = layerRadius+3/2.f;
    UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(cp, cp) radius:layerRadius startAngle:.0f endAngle:.75f*M_PI clockwise:YES];
    shapeLayer.path = p.CGPath;
    
    shapeLayer.strokeColor = self.showConfig.tintColor.CGColor;
    shapeLayer.lineWidth=2.0f;
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(.0f, .5f);
    gradientLayer.endPoint = CGPointMake(1.f, .5f);
    gradientLayer.frame = shapeLayer.frame ;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:6];
    for(int i=10;i>=0;i-=2) {
        [tempArray addObject:(__bridge id)[self.showConfig.tintColor colorWithAlphaComponent:i*.1f].CGColor];
    }
    gradientLayer.colors = tempArray;
    gradientLayer.mask = shapeLayer;
    [self.imageView.layer addSublayer:gradientLayer];
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue = @(2.f*M_PI);
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [gradientLayer addAnimation:animation forKey:@"GradientLayerAnimation"];
}
- (void)removeSelfFromSuperView
{
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    
    void (^completion)(void) = ^{
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    };
    switch (self.showConfig.animationType) {
        case LodingAnimationTypeNone:
            completion() ;
            break;
        case LodingAnimationTypeBounce:
            [self showBounceAnimationStart:NO completion:completion];
            break ;
        case LodingAnimationTypeFade:
            [self showFadeAnimationStart:NO completion:completion ] ;
            break ;
        default:
            break;
    }
}


#pragma mark - animation
// 转圈动画
- (void)drawAnimiationImageView:(BOOL)isImageView
{
    NSString *keyPath = isImageView ? @"transform.rotation.y" : @"transform.rotation.z" ;
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue=@(0);
    animation.toValue=@(M_PI*2);
    animation.duration=isImageView ? 1.3 : .8;
    animation.repeatCount=HUGE;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.imageView.layer addAnimation:animation forKey:@"animation"];
}


- (void)showFadeAnimationStart:(BOOL)isStart completion:(void(^)(void))completion
{
    self.alpha = isStart ? 0.1f : 1.0f;
    [UIView animateWithDuration:EasyShowAnimationTime animations:^{
        self.alpha = isStart ? 1.0 : 0.1f ;
    } completion:^(BOOL finished) {
        if (completion) {
            completion() ;
        }
    }];
}
- (void)showBounceAnimationStart:(BOOL)isStart completion:(void(^)(void))completion
{
    if (isStart) {
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = EasyShowAnimationTime ;
        popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        popAnimation.delegate = self ;
        [popAnimation setValue:completion forKey:@"handler"];
        [self.lodingBgView.layer addAnimation:popAnimation forKey:nil];
        return ;
    }
    CABasicAnimation *bacAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    bacAnimation.duration = EasyShowAnimationTime ;
    bacAnimation.beginTime = .0;
    bacAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.3f :0.5f :-0.5f];
    bacAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    bacAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[bacAnimation];
    animationGroup.duration =  bacAnimation.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    //    animationGroup.delegate = self ;
    //    [animationGroup setValue:completion forKey:@"handler"];
    [self.lodingBgView.layer addAnimation:animationGroup forKey:nil];
    
    [self performSelector:@selector(ddd) withObject:nil afterDelay:bacAnimation.duration];
}
- (void)ddd
{
    [self removeFromSuperview];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}
//加载loding的动画
- (void)drawAnimationImageViewLoding
{
    CGPoint centerPoint= CGPointMake(self.imageView.easyS_width/2.0f, self.imageView.easyS_height/2.0f) ;
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithArcCenter:centerPoint radius:centerPoint.x startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer *centerLayer=[CAShapeLayer layer];
    centerLayer.path=beizPath.CGPath;
    centerLayer.fillColor=[UIColor clearColor].CGColor;//填充色
    centerLayer.strokeColor=self.showConfig.tintColor.CGColor;//边框颜色
    centerLayer.lineWidth=2.0f;
    centerLayer.lineCap=kCALineCapRound;//线框类型
    
    [self.imageView.layer addSublayer:centerLayer];
    
}


#pragma mark - getter

- (UIView *)lodingBgView
{
    if (nil == _lodingBgView) {
        _lodingBgView = [[UIView alloc]init] ;
        _lodingBgView.backgroundColor = [self.showConfig.bgColor colorWithAlphaComponent:self.showConfig.bgAlpha];
        [self addSubview:_lodingBgView];
    }
    return _lodingBgView ;
}
- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.tintColor = self.showConfig.tintColor ;
        [self.lodingBgView addSubview:_imageView];
    }
    return _imageView ;
}
- (UILabel *)textLabel
{
    if (nil == _textLabel) {
        CGFloat margX = self.showConfig.lodingType%2 ? 20 : 8 ;
        _textLabel = [[EasyShowLabel alloc]initWithContentInset:UIEdgeInsetsMake(10, margX, 10, margX)];
        _textLabel.textColor = self.showConfig.tintColor;
        _textLabel.font = self.showConfig.textFont ;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter ;
        _textLabel.numberOfLines = 0 ;
        [self.lodingBgView addSubview:_textLabel];
    }
    return _textLabel ;
}

- (UIActivityIndicatorView *)imageViewIndeicator
{
    if (nil == _imageViewIndeicator) {
        UIActivityIndicatorViewStyle style = self.showConfig.lodingType%2 ?UIActivityIndicatorViewStyleWhiteLarge : UIActivityIndicatorViewStyleWhite ;
        _imageViewIndeicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        _imageViewIndeicator.tintColor = self.showConfig.tintColor ;
        _imageViewIndeicator.color = self.showConfig.tintColor ;
        _imageViewIndeicator.backgroundColor = [UIColor clearColor];
        _imageViewIndeicator.frame = self.imageView.bounds ;
    }
    return _imageViewIndeicator ;
}


#pragma mark - 类方法
+ (EasyLodingView *)showLoding
{
    return [self showLodingText:@""];
}
+ (EasyLodingView *)showLodingText:(NSString *)text
{
    return [self showLodingText:text imageName:nil];
}
+ (EasyLodingView *)showLodingText:(NSString *)text imageName:(NSString *)imageName
{
    EasyLodingConfig *(^configTemp)(void) = ^EasyLodingConfig *{
        return [EasyLodingConfig shared] ;
    };
    return [self showLodingText:text imageName:imageName config:configTemp];
    
}
+ (EasyLodingView *)showLodingText:(NSString *)text
                config:(EasyLodingConfig *(^)(void))config
{
    return [self showLodingText:text imageName:nil config:config];
}

+ (EasyLodingView *)showLodingText:(NSString *)text imageName:(NSString *)imageName config:(EasyLodingConfig *(^)(void))config
{
    NSAssert(config, @"there shoud have a superview!") ;
    
    if (nil == config) {
        EasyLodingConfig *(^configTemp)(void) = ^EasyLodingConfig *{
            return  [EasyLodingConfig shared];
        };
        config = configTemp ;
    }
    
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    EasyLodingConfig *tempConfig = [self changeConfigWithConfig:config] ;
    if (!tempConfig.superView) {
        if (tempConfig.showOnWindow) {
            tempConfig.superView = [UIApplication sharedApplication].keyWindow ;
        }else{
            tempConfig.superView = [EasyShowUtils easyShowViewTopViewController].view ;
        }
    }
    
    //显示之前---->隐藏还在显示的视图
    [self hidenLoingInView:tempConfig.superView];
    
    //创建显示的view
    EasyLodingView *lodingView = [[EasyLodingView alloc]initWithFrame:CGRectZero
                                                             showText:text
                                                            iamgeName:imageName
                                                               config:tempConfig];
    //lodingview加到父视图上面
    [tempConfig.superView addSubview:lodingView];
    return lodingView ;
}


+ (void)hidenLoding
{
    UIView *showView = nil ;
    if ([EasyLodingGlobalConfig shared].showOnWindow == YES) {
        showView = [UIApplication sharedApplication].keyWindow ;
    }else{
        showView = [EasyShowUtils easyShowViewTopViewController].view ;
    }
    [self hidenLoingInView:showView];
}
+ (void)hidenLoingInView:(UIView *)superView
{
    NSEnumerator *subviewsEnum = [superView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyLodingView *showView = (EasyLodingView *)subview ;
            [self hidenLoding:showView];
        }
    }
}
+ (void)hidenLoding:(EasyLodingView *)lodingView
{
    [lodingView removeSelfFromSuperView];
}

#pragma mark - 工具方法
//+ (UIView *)showLodingEmptyView
//{
//    UIView *showView = [UIApplication sharedApplication].keyWindow ;
//    if ([EasyLodingGlobalConfig isUseLoeingGlobalConfig]) {
//        if (![EasyLodingGlobalConfig sharedEasyLodingGlobalConfig].showOnWindow) {
//            showView = [EasyShowUtils easyShowViewTopViewController].view ;
//        }
//    }
//    else{
////        if (![EasyShowOptions sharedEasyShowOptions].lodingShowOnWindow) {
////            showView = [EasyShowUtils easyShowViewTopViewController].view ;
////        }
//    }
//    return showView ;
//}

+ (EasyLodingConfig *)changeConfigWithConfig:(EasyLodingConfig *(^)(void))config
{
    EasyLodingConfig *tempConfig = config ? config() : nil ;
    if (!tempConfig) {
        tempConfig = [EasyLodingConfig shared] ;
    }
    
    EasyLodingGlobalConfig *globalConfig = [EasyLodingGlobalConfig shared];
    
    if (tempConfig.lodingType == LodingShowTypeUnDefine) {
        tempConfig.lodingType =  globalConfig.lodingType  ;
    }
    if (tempConfig.animationType == LodingAnimationTypeUndefine) {
        tempConfig.animationType = globalConfig.animationType  ;
    }
    if (!tempConfig.cycleCornerWidth) {
        tempConfig.cycleCornerWidth =globalConfig.cycleCornerWidth;
    }
    if (!tempConfig.tintColor) {
        tempConfig.tintColor =  globalConfig.tintColor ;
    }
    if (!tempConfig.textFont) {
        tempConfig.textFont = globalConfig.textFont;
    }
    if (!tempConfig.bgColor) {
        tempConfig.bgColor = globalConfig.bgColor ;
    }
    if (!tempConfig.playImagesArray) {
        tempConfig.playImagesArray = globalConfig.playImagesArray ;
    }
    return tempConfig ;
}



@end

