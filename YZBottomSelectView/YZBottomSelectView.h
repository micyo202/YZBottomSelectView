/************************************************************
 Class    : YZBottomSelectView.h
 Describe : 底部弹出选择视图
 Company  : Prient
 Author   : Yanzheng
 Date     : 2017-11-01
 Declare  : Copyright © 2017 Yanzheng. All rights reserved.
 URL      : https://github.com/micyo202/YZBottomSelectView
 ************************************************************/

#import <UIKit/UIKit.h>
@class YZBottomSelectView;

/**
 * block回调方法
 *
 * @param   bootomSelectView    YZBottomSelectView对象本身
 * @param   index               被点击按钮序列号，取消：0，删除：-1，其他：1.2.3...
 */
typedef void(^YZBottomSelectViewBlock)(YZBottomSelectView *bootomSelectView, NSInteger index);

@interface YZBottomSelectView : UIView

/**
 * 快速创建并展示YZBottomSelectView视图
 *
 * @param   title                   提示文本
 * @param   cancelButtonTitle       取消按钮文本
 * @param   destructiveButtonTitle  删除按钮文本
 * @param   otherButtonTitles       其他按钮文本
 * @param   bottomSelectViewBlock   block回调
 */
+ (void)showBottomSelectViewWithTitle:(NSString *)title
                    cancelButtonTitle:(NSString *)cancelButtonTitle
               destructiveButtonTitle:(NSString *)destructiveButtonTitle
                    otherButtonTitles:(NSArray *)otherButtonTitles
                              handler:(YZBottomSelectViewBlock)bottomSelectViewBlock;

@end
