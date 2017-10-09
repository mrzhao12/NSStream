//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)


#pragma mark - 弹框在UIwindow上

+ (UIWindow *)removeHUDFromWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //在window上显示就可点击
    window.userInteractionEnabled = YES;
    for (UIView *tipVieww in window.subviews) {
        if ([tipVieww isKindOfClass:[MBProgressHUD class]]) {
            [tipVieww removeFromSuperview];
        }
    }
    return window;
}


/**
 *  隐藏window上创建的MBProgressHUD
 */
+ (void)hideLoadingFromWindow
{
    UIWindow *window = [self removeHUDFromWindow];
    //警告:配对出现不能删除
    window.userInteractionEnabled = YES;
    for (UIView *tipView in window.subviews) {
        //NSLog(@"隐藏window上创建的MBProgressHUD:%@",tipView);
        if ([tipView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *HUD = (MBProgressHUD *)tipView;
            [HUD hide:YES];
            [HUD removeFromSuperview];
        }
    }
}


/**
 *  在window上带图片的成功的Toast提示
 *
 *  @param success 成功提示文字
 */
+ (void)showSuccess:(NSString *)success
{
    [self hideLoadingFromWindow];
    [self showSuccess:success toView:nil];
}
+ (void)showSuccess:(NSString *)success model:(BOOL)model
{
    [self hideLoadingFromWindow];
    [self showSuccess:success toView:nil model:model];
}

/**
 *  在window上带图片的错误的Toast提示
 *
 *  @param success 错误提示文字
 */
+ (void)showError:(NSString *)error
{
    [self hideLoadingFromWindow];
    [self showError:error toView:nil];
}
+ (void)showError:(NSString *)error model:(BOOL)model
{
    [self showError:error toView:nil model:model];
}

/**
 *  在window上带文字几秒后提示消失
 *
 *  @param message 提示文字
 *  @param delay   几秒消失
 */
+ (void)showToastOnWindow:(NSString *)message afterDelay:(NSTimeInterval)delay
{
    UIWindow *window = [self removeHUDFromWindow];
    
    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:alert];
    alert.mode = MBProgressHUDModeText;
    alert.detailsLabelText = message;
    alert.detailsLabelFont = [UIFont systemFontOfSize:16];
    [alert show:YES];
    [alert hide:YES afterDelay:delay];
}
+ (void)showToastOnWindow:(NSString *)message afterDelay:(NSTimeInterval)delay model:(BOOL)model
{
    UIWindow *window = [self removeHUDFromWindow];
    
    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:alert];
    alert.mode = MBProgressHUDModeText;
    alert.detailsLabelText = message;
    alert.detailsLabelFont = [UIFont systemFontOfSize:16];
    if (model==YES) {
        alert.userInteractionEnabled = YES;
    }else{
        alert.userInteractionEnabled = NO;
    }
    [alert show:YES];
    [alert hide:YES afterDelay:delay];
}


/**
 *  在window上带文字提示Toast暂时卡住页面
 *
 *  @param message 提示语
 */
+ (void)showToastOnWindow:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [self removeHUDFromWindow];
        MBProgressHUD *alert = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:alert];
        alert.mode = MBProgressHUDModeText;
        alert.detailsLabelText = message;
        alert.detailsLabelFont = [UIFont systemFontOfSize:16];
        [alert show:YES];
        [alert hide:YES afterDelay:2.0];

    });
}
+ (void)showToastOnWindow:(NSString *)message model:(BOOL)model
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [self removeHUDFromWindow];
        MBProgressHUD *alert = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:alert];
        alert.mode = MBProgressHUDModeText;
        alert.detailsLabelText = message;
        alert.detailsLabelFont = [UIFont systemFontOfSize:16];
        if(model==YES) {
            alert.userInteractionEnabled = YES;
        }else{
            alert.userInteractionEnabled = NO;
        }
        [alert show:YES];
        [alert hide:YES afterDelay:2.0];
        
    });
}

/**
 *  在window上带图片的Toast暂时卡住页面
 *
 *  @param tipText 提示语
 */

+ (void)showToastWithImgOnWindow:(NSString *)tipStr toastImg:(UIImage *)toastImg
{
    UIWindow *window = [self removeHUDFromWindow];
    if (!toastImg) {
        toastImg = [UIImage imageNamed:@"success"];
    }
    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:alert];
    alert.customView = [[UIImageView alloc] initWithImage:toastImg];
    alert.mode = MBProgressHUDModeCustomView;
    alert.detailsLabelText = tipStr;
    alert.detailsLabelFont = [UIFont systemFontOfSize:16];
    alert.userInteractionEnabled = NO;
    [alert show:YES];
    [alert hide:YES afterDelay:2.0];
}
+ (void)showToastWithImgOnWindow:(NSString *)tipStr toastImg:(UIImage *)toastImg after:(NSTimeInterval)delay model:(BOOL)model
{
    UIWindow *window = [self removeHUDFromWindow];
    if (!toastImg) {
        toastImg = [UIImage imageNamed:@"success"];
    }
    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:alert];
    alert.customView = [[UIImageView alloc] initWithImage:toastImg];
    alert.mode = MBProgressHUDModeCustomView;
    alert.detailsLabelText = tipStr;
    alert.detailsLabelFont = [UIFont systemFontOfSize:16];
    if (model==YES) {
        alert.userInteractionEnabled = YES;
    }else{
        alert.userInteractionEnabled = NO;
    }
    [alert show:YES];
    if (delay==0) {
        [alert hide:YES afterDelay:2.0];
    }else{
        [alert hide:YES afterDelay:delay];
    }
    
}


/**
 *  在window上显示转圈的MBProgressHUD (不会自动消失,需要手动调用隐藏方法)
 *
 *  @param tipStr 提示语
 */
+ (void)showLoadingOnWindowWithText:(NSString *)tipStr
{
    UIWindow *window = [self removeHUDFromWindow];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = tipStr;
    HUD.userInteractionEnabled = NO;
    
    //在window上显示就不让其点击
    window.userInteractionEnabled = NO;
    
    [HUD show:YES];
}
+(void)showLoadingOnWindow
{
    [self showLoadingOnWindowWithText:@""];
}

+ (void)showLoadingOnWindowWithText:(NSString *)tipStr model:(BOOL)model
{
    UIWindow *window = [self removeHUDFromWindow];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = tipStr;
    if (model==YES) {
        HUD.userInteractionEnabled = YES;
    }else{
        HUD.userInteractionEnabled = NO;
    }
    [HUD show:YES];
}


#pragma mark - 弹框在指定view上

/**
 *  获取子view
 */
+ (UIView *)getHUDFromSubview:(UIView *)addView
{
    if (addView) {
        for (UIView *tipVieww in addView.subviews) {
            if ([tipVieww isKindOfClass:[MBProgressHUD class]]) {
                if (tipVieww.superview) {
                    [tipVieww removeFromSuperview];
                }
            }
        }
    } else {
        addView = [UIApplication sharedApplication].keyWindow;
    }
    return addView;
}


/**
 *  在指定view上带图片的成功的Toast提示
 *
 *  @param success 成功提示文字
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self showLoadingToView:view text:success icon:@"popup_ok"];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view model:(BOOL)model
{
    [self showLoadingToView:view text:success icon:[UIImage imageNamed:@"popup_ok"] after:0 model:model];
}

/**
 *  在指定view上带图片的失败的Toast提示
 *
 *  @param success 成功提示文字
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self showLoadingToView:view text:error icon:@"popup_cancel"];
}
+ (void)showError:(NSString *)error toView:(UIView *)view model:(BOOL)model{
    [self showLoadingToView:view text:error icon:[UIImage imageNamed:@"popup_cancel"] after:0 model:model];
}

/**
 *  在自定义view上暂时卡住页面
 *
 *  @param sender  提示层加在当前页面上
 *  @param message 提示语
 */
+ (void)showToastViewOnView:(UIView *)addView text:(NSString *)message
{
    addView = [self getHUDFromSubview:addView];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:HUD];
    
    if (message.length>14) {
        HUD.detailsLabelText = message;
    } else {
        if(message) HUD.labelText = message;
        else HUD.labelText = @"请稍等"; 
    }
    
    HUD.mode = MBProgressHUDModeText;
    HUD.removeFromSuperViewOnHide = YES;
    // HUD.dimBackground = YES;// YES代表需要蒙版效果
    [HUD show:YES];
    [HUD hide:YES afterDelay:2.0];
}

+ (void)showToastViewOnView:(UIView *)addView text:(NSString *)message model:(BOOL)model
{
    addView = [self getHUDFromSubview:addView];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:HUD];
    
    if (message.length>14) {
        HUD.detailsLabelText = message;
    } else {
        
        if(message) HUD.labelText = message;
        else HUD.labelText = @"请稍等";
    }
    
    HUD.mode = MBProgressHUDModeText;
    HUD.removeFromSuperViewOnHide = YES;
    // HUD.dimBackground = YES;// YES代表需要蒙版效果
    if (model==YES) {
        HUD.userInteractionEnabled = YES;
    }else{
        HUD.userInteractionEnabled = NO;
    }
    [HUD show:YES];
    [HUD hide:YES afterDelay:2.0];
}

/**
 *  在自定义Viwe上带文字暂时卡住页面
 *
 *  @param sender  自定义View
 *  @param message 提示文字
 *  @param delay   几秒后消失
 */
+ (void)showToastViewOnView:(UIView *)addView text:(NSString *)message afterDelay:(NSTimeInterval)delay
{
    addView = [self getHUDFromSubview:addView];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    if(message) HUD.labelText = message;
    else HUD.labelText = @"";
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}

+ (void)showToastViewOnView:(UIView *)addView text:(NSString *)message afterDelay:(NSTimeInterval)delay model:(BOOL)model
{
    addView = [self getHUDFromSubview:addView];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    if(message) HUD.labelText = message;
    else HUD.labelText = @"";
    if (model==YES) {
        HUD.userInteractionEnabled = YES;
    }else{
        HUD.userInteractionEnabled = NO;
    }
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}

/**
 *  在自定义Viwe上带文字暂时卡住页面
 *
 *  @param sender  自定义View
 *  @param message 提示文字
 *  @param icon   显示的图片
 */
+ (void)showLoadingToView:(UIView *)addView text:(NSString *)text icon:(NSString *)icon
{
    UIImage *img = [UIImage imageNamed:icon];
    addView = [self getHUDFromSubview:addView];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:hud];
    [addView bringSubviewToFront:hud];
    
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:img];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    [hud show:YES];
    [hud hide:YES afterDelay:2.0];

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showLoadingToView:(UIView *)addView text:(NSString *)text icon:(UIImage *)icon after:(NSTimeInterval)delay model:(BOOL)model
{
    addView = [self getHUDFromSubview:addView];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:hud];
    [addView bringSubviewToFront:hud];
    
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:icon];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    if (model==YES) {
        hud.userInteractionEnabled = YES;
    }else{
        hud.userInteractionEnabled = NO;
    }
    [hud show:YES];
    if (delay==0) {
        [hud hide:YES afterDelay:2.0];
    }else{
        [hud hide:YES afterDelay:delay];
    }
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
}


/**
 *  在指定view上显示转圈的MBProgressHUD (不会自动消失,需要手动调用隐藏方法)
 *
 *  @param tipStr 提示语
 */
+ (void)showLoadingWithView:(UIView *)addView text:(NSString *)tipStr
{
    addView = [self getHUDFromSubview:addView];

    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.userInteractionEnabled = NO;
    HUD.labelText = tipStr;
    [HUD show:YES];
}

+ (void)showLoadingWithView:(UIView *)addView text:(NSString *)tipStr model:(BOOL)model
{
    addView = [self getHUDFromSubview:addView];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    if (model==YES) {
        HUD.userInteractionEnabled = YES;
    }else{
        HUD.userInteractionEnabled = NO;
    }
    HUD.labelText = tipStr;
    [HUD show:YES];
}


+ (void)showModelLoadingWithView:(UIView *)addView text:(NSString *)tipStr
{
    addView = [self getHUDFromSubview:addView];

    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.userInteractionEnabled = YES;
    HUD.labelText = tipStr;
    [HUD show:YES];
}


/**
 *  隐藏指定view上创建的MBProgressHUD
 */
+ (void)hideLoadingFromView:(UIView *)view
{
    for (UIView *tipView in view.subviews) {
        if ([tipView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *HUD = (MBProgressHUD *)tipView;
            if (tipView.superview) {
                [tipView removeFromSuperview];
            }
            [HUD hide:YES];
        }
    }
}


#pragma mark - 展示一个带GIF图片的弹框

+ (MBProgressHUD *)showGIFByImageViewToView:(UIView *)view
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.dimBackground = NO;
    __block UIImageView *imageView;
    dispatch_sync(dispatch_get_main_queue(), ^{
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        imageView.backgroundColor = [UIColor redColor];
        //imageView.gifPath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
        //[imageView startGIF];
    });
    HUD.customView = imageView;
    //HUD.minSize = CGSizeMake(135.f, 135.f);
    return HUD;
}


/**
 *  城市表格列表用到
 */
+ (void)showHUDAnimationZoomWithTip:(NSString *)text ToView:(UIView *)view
{
    UILabel *centerLabel = [[UILabel alloc] init];
    centerLabel.center = view.center;
    centerLabel.bounds = CGRectMake(0, 0, 85, 85);
    centerLabel.text = text;
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.font = [UIFont systemFontOfSize:28];
    centerLabel.textColor = [UIColor whiteColor];
    centerLabel.backgroundColor = [UIColor darkGrayColor];
    centerLabel.layer.masksToBounds = YES;
    centerLabel.layer.cornerRadius = 5.f;
    [view addSubview:centerLabel];
    [self performSelector:@selector(removeCenterLabel:) withObject:centerLabel afterDelay:1.f];
}

+ (void)removeCenterLabel:(UILabel *)tempLabel
{
    [tempLabel removeFromSuperview];
}

@end
