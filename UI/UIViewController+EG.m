//
//  UIViewController+EG.m
//  PicPages
//
//  Created by 藤田正訓 on 2012/10/17.
//  Copyright (c) 2012年 tockri. All rights reserved.
//

#import "UIViewController+EG.h"
#import "EG.h"
#import "EG_ui.h"

@implementation UIViewController (EG)

-(id)eAddPane:(NSString *)storyBoardId {
    UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
    [self addChildViewController:vc];
    vc.view.hidden = YES;
    [self.view addSubview:vc.view];
    [vc.view eFittoSuperview];
    [vc.view eFadein];
    return vc;
}

-(void)eRemovePaneFromParent {
    [self.view eFadeout:^{
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

-(UIPopoverController *)ePopoverPane:(NSString *)storyBoardId on:(UIBarButtonItem *)button {
    UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
    UIPopoverController* pop = [[UIPopoverController alloc]
                                initWithContentViewController:vc];
    [pop presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    return pop;
}



-(void)ePop {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ePopFast {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
