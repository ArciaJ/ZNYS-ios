//
//  ViewController.h
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftStatusManager.h"

/*
@protocol GiftStatusDelegate <NSObject>

- (void)showPage;

@end

 */
 
@interface CabinetViewController : UIViewController

@property GiftStatusManager *giftStatusManager;

@end

