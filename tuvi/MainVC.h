//
//  MainVC.h
//  tuvi
//
//  Created by DuongND on 1/21/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LeftMenuVC.h"
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import "GADBannerView.h"

@interface MainVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,MBProgressHUDDelegate,MFMessageComposeViewControllerDelegate,UIActionSheetDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, assign) NSInteger cID;
@property (nonatomic, strong) NSString *stringTitle;
@property (nonatomic, assign) BOOL isLogin;
@property (strong, nonatomic) IBOutlet UICollectionView *myColl;
@property (strong, nonatomic) IBOutlet UIView *viewAdd;
-(id)initWithCategory:(NSInteger) cID andTitle:(NSString*) stringTitle;
@end
