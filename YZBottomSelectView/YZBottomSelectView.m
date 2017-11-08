/************************************************************
 Class    : YZBottomSelectView.m
 Describe : 底部弹出选择视图
 Company  : Prient
 Author   : Yanzheng
 Date     : 2017-11-01
 Declare  : Copyright © 2017 Yanzheng. All rights reserved.
 URL      : https://github.com/micyo202/YZBottomSelectView
 ************************************************************/

#import "YZBottomSelectView.h"

#define IS_IPHONE_X (812 == [UIScreen mainScreen].bounds.size.height && 375 == [UIScreen mainScreen].bounds.size.width)

static const CGFloat kRowHeight = 46.0f;
static const CGFloat kRowLineHeight = 0.5f;
static const CGFloat kSeparatorHeight = 6.0f;
static const CGFloat kTitleFontSize = 13.0f;
static const CGFloat kButtonTitleFontSize = 16.0f;
static const NSTimeInterval kAnimateDuration = 0.5f;

@interface YZBottomSelectView ()

/** block回调 */
@property (copy, nonatomic) YZBottomSelectViewBlock bottomSelectViewBlock;
/** 背景图片 */
@property (strong, nonatomic) UIView *backgroundView;
/** 弹出视图 */
@property (strong, nonatomic) UIView *bottomSelectView;

@end

@implementation YZBottomSelectView

#pragma mark - 初始化创建选择视图
- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(YZBottomSelectViewBlock)bottomSelectViewBlock {
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _bottomSelectViewBlock = bottomSelectViewBlock;
        
        CGFloat bootomSelectViewHeight = 0;
        
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.4f];
        _backgroundView.alpha = 0;
        [self addSubview:_backgroundView];
        
        _bottomSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];
        _bottomSelectView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _bottomSelectView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
        [self addSubview:_bottomSelectView];
        
        UIImage *normalImage = [self imageWithColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1]];
        UIImage *highlightedImage = [self imageWithColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1]];
        
        if (title && title.length > 0) {
            bootomSelectViewHeight += kRowLineHeight;
            
            CGFloat titleHeight = ceilf((CGFloat)[title boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kTitleFontSize]} context:nil].size.height) + 15*2;
            UILabel *titleLabel = [[UILabel alloc] init];
            // 此处进行判断设备是否为iPhoneX
            if(IS_IPHONE_X) {
                // 设置 iPhoneX 中安全区域（底部危险区域高为：34）
                titleLabel.frame = CGRectMake(0, bootomSelectViewHeight-34.0f, self.frame.size.width, titleHeight);
            } else {
                titleLabel.frame = CGRectMake(0, bootomSelectViewHeight, self.frame.size.width, titleHeight);
            }
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            titleLabel.text = title;
            titleLabel.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
            titleLabel.textColor = [UIColor colorWithRed:135/255.0f green:135/255.0f blue:135/255.0f alpha:1];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            titleLabel.numberOfLines = 0;
            [_bottomSelectView addSubview:titleLabel];
            
            bootomSelectViewHeight += titleHeight;
        }
        
        if (destructiveButtonTitle && destructiveButtonTitle.length > 0) {
            bootomSelectViewHeight += kRowLineHeight;
            
            UIButton *destructiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
            // 此处进行判断设备是否为iPhoneX
            if(IS_IPHONE_X) {
                // 设置 iPhoneX 中安全区域（底部危险区域高为：34）
                destructiveButton.frame = CGRectMake(0, bootomSelectViewHeight-34.0f, self.frame.size.width, kRowHeight);
            } else {
                destructiveButton.frame = CGRectMake(0, bootomSelectViewHeight, self.frame.size.width, kRowHeight);
            }
            destructiveButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            destructiveButton.tag = -1;
            destructiveButton.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
            [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
            [destructiveButton setTitleColor:[UIColor colorWithRed:230/255.0f green:66/255.0f blue:66/255.0f alpha:1] forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:normalImage forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [destructiveButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomSelectView addSubview:destructiveButton];
            
            bootomSelectViewHeight += kRowHeight;
        }
        
        if (otherButtonTitles && [otherButtonTitles count] > 0) {
            for (int i = 0; i < otherButtonTitles.count; i++) {
                bootomSelectViewHeight += kRowLineHeight;
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                // 此处进行判断设备是否为iPhoneX
                if(IS_IPHONE_X) {
                    // 设置 iPhoneX 中安全区域（底部危险区域高为：34）
                    button.frame = CGRectMake(0, bootomSelectViewHeight-34.0f, self.frame.size.width, kRowHeight);
                } else {
                    button.frame = CGRectMake(0, bootomSelectViewHeight, self.frame.size.width, kRowHeight);
                }
                button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                button.tag = i+1;
                button.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
                [button setTitle:otherButtonTitles[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:64/255.0f green:64/255.0f blue:64/255.0f alpha:1] forState:UIControlStateNormal];
                [button setBackgroundImage:normalImage forState:UIControlStateNormal];
                [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_bottomSelectView addSubview:button];
                
                bootomSelectViewHeight += kRowHeight;
            }
        }
        
        if (cancelButtonTitle && cancelButtonTitle.length > 0) {
            bootomSelectViewHeight += kSeparatorHeight;
            
            UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            // 此处进行判断设备是否为iPhoneX
            if(IS_IPHONE_X) {
                // 设置 iPhoneX 中安全区域（底部危险区域高为：34）
                cancelButton.frame = CGRectMake(0, bootomSelectViewHeight-34.0f, self.frame.size.width, kRowHeight);
            } else {
                cancelButton.frame = CGRectMake(0, bootomSelectViewHeight, self.frame.size.width, kRowHeight);
            }
            cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            cancelButton.tag = 0;
            cancelButton.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
            [cancelButton setTitle:cancelButtonTitle ?: @"取消" forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor colorWithRed:64/255.0f green:64/255.0f blue:64/255.0f alpha:1] forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:normalImage forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomSelectView addSubview:cancelButton];
            
            bootomSelectViewHeight += kRowHeight;
        }
        
        _bottomSelectView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, bootomSelectViewHeight);
    }
    
    return self;
    
}

#pragma mark - 快速构建并显示选择视图
+ (void)showBottomSelectViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(YZBottomSelectViewBlock)bottomSelectViewBlock {
    YZBottomSelectView *bottomSelectView = [[self alloc] initWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles handler:bottomSelectViewBlock];
    [bottomSelectView show];
}

#pragma mark - 视图展示
- (void)show {
    // 在主线程中处理,否则在viewDidLoad方法中直接调用,会先加本视图,后加控制器的视图到UIWindow上,导致本视图无法显示出来,这样处理后便会优先加控制器的视图到UIWindow上
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows) {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:self];
                break;
            }
        }
        
        [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundView.alpha = 1.0f;
            self.bottomSelectView.frame = CGRectMake(0, self.frame.size.height-self.bottomSelectView.frame.size.height, self.frame.size.width, self.bottomSelectView.frame.size.height);
        } completion:nil];
    }];
}

#pragma mark - 视图收起（隐藏）
- (void)dismiss {
    [UIView animateWithDuration:kAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundView.alpha = 0.0f;
        self.bottomSelectView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.bottomSelectView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 非选择区域点击，触发视图收起隐藏事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.backgroundView];
    if (!CGRectContainsPoint(self.bottomSelectView.frame, point)) {
        if (self.bottomSelectViewBlock) {
            self.bottomSelectViewBlock(self, 0);
        }
        [self dismiss];
    }
}

#pragma mark - 选择按钮点击事件
- (void)buttonClicked:(UIButton *)button {
    if (self.bottomSelectViewBlock) {
        self.bottomSelectViewBlock(self, button.tag);
    }
    [self dismiss];
}

#pragma mark - 根据颜色创建图片
- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
