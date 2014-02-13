//
//  DetailListTuViVC.h
//  tuvi2014
//
//  Created by DuongND on 1/20/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "GADBannerView.h"

@interface DetailListTuViVC : UIViewController <RTLabelDelegate, UIWebViewDelegate>
{
    
}
@property (nonatomic, strong) NSString *stringDetail;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (nonatomic, strong) NSString *stringTitle;
@property (strong, nonatomic) IBOutlet UIView *viewADDDDD;
@property (nonatomic, assign) NSInteger cID;
@end
