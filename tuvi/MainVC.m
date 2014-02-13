//
//  MainVC.m
//  tuvi
//
//  Created by DuongND on 1/21/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import "MainVC.h"
#import "ListTuViVC.h"
#import "DetailListTuViVC.h"
#import "IIViewDeckController.h"
#import "TuViHangNgayVC.h"
#import "UIColor+Extend.h"
#import "AFNetworking.h"

@interface MainVC ()
{
    NSMutableArray *mainArray;
    NSString *path;
    NSArray *arrDauSo;
}
@property (nonatomic, strong) ListTuViVC *listTuVi;
@property (nonatomic, strong) DetailListTuViVC *detaiListTuVi;
@property (nonatomic, strong) TuViHangNgayVC *tuViHangNgayVC;

@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) TuViHangNgayVC *tuVihangNgay;
@end

@implementation MainVC
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCategory:(NSInteger) cID andTitle:(NSString *)stringTitle
{
    if (self = [super init]) {
        self.cID = cID;
        self.stringTitle = stringTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //NSLog(@"%d -- %@",self.cID,self.stringTitle);
    NSLog(@"1");
    NSLog(@"isLogin is %@", self.isLogin ? @"YES" : @"NO");
    [self createUsingFilePlist];
    [self disPlayAdd];
    arrDauSo = [NSArray arrayWithObjects:@"6130",@"6230",@"6330",@"6530",@"6630",@"6730", nil];
    
    if (SYSTEM_VERSION_GREATER_THAN(@"7.0")) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor initByHexString:@"#99c73a" alpha:1]];//415D33 //95B252
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   [UIColor whiteColor],
                                                   UITextAttributeTextColor,
                                                   [UIColor blackColor],
                                                   UITextAttributeTextShadowColor,
                                                   [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                   UITextAttributeTextShadowOffset, nil];
        
        [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    }else{
        //[[UINavigationBar appearance] setTintColor:[UIColor UIColorFromRGB(0x212121)]];
    }
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"]
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self.viewDeckController
                                                                            action:@selector(toggleLeftView)];
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgrond.png"]]];
    
    [self.myColl setBackgroundColor:[UIColor clearColor]];
    [self.myColl setShowsHorizontalScrollIndicator:NO];
    [self.myColl setShowsVerticalScrollIndicator:NO];
    
    mainArray = [[NSMutableArray alloc] init];
    if (self.cID == 0 || self.cID == 1) {
        [self getDataToArray12ConGiap];
    }else if (self.cID == 2 || self.cID == 3){
        [self getDataToArray12Cung];
    }
}

- (void) disPlayAdd{
    GADBannerView *bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = @"a152df8a25c4221";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    
    GADRequest * request = [GADRequest request];
    //request.testDevices = [NSArray arrayWithObjects:@"cbe917cfd5a5dc834dda707bc37a5938", nil];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:request];
    [self.viewAdd addSubview:bannerView_];
}

- (void) getDataToArray12ConGiap
{
    [mainArray addObject:@"ic_rat.png,Tuổi Tý,"];
    [mainArray addObject:@"ic_buffalo.png,Tuổi Sửu,"];
    [mainArray addObject:@"ic_tiger.png,Tuổi Dần,"];
    [mainArray addObject:@"ic_cat.png,Tuổi Mão,"];
    [mainArray addObject:@"ic_dragon.png,Tuổi Thìn,"];
    [mainArray addObject:@"ic_snake.png,Tuổi Tỵ,"];
    [mainArray addObject:@"ic_horse.png,Tuổi Ngọ,"];
    [mainArray addObject:@"ic_goat.png,Tuổi Mùi,"];
    [mainArray addObject:@"ic_monkey.png,Tuổi Thân,"];
    [mainArray addObject:@"ic_chicken.png,Tuổi Dậu,"];
    [mainArray addObject:@"ic_dog.png,Tuổi Tuất,"];
    [mainArray addObject:@"ic_pig.png,Tuổi Hợi,"];
}

- (void) getDataToArray12Cung
{
    [mainArray addObject:@"ic_aries.png,Dương Cưu,21/3-20/4"];
    [mainArray addObject:@"ic_taurus.png,Kim ngưu,21/4-21/5"];
    [mainArray addObject:@"ic_gemini.png,Song Tử,22/5-21/6"];
    [mainArray addObject:@"ic_cancer.png,Cự Giải,22/6-23/7"];
    [mainArray addObject:@"ic_leo.png,Hải Sư,24/7-23/8"];
    [mainArray addObject:@"ic_virgo.png,Xử Nữ,24/8-23/9"];
    [mainArray addObject:@"ic_libra.png,Thiên Xứng,24/9-23/10"];
    [mainArray addObject:@"ic_scorpio.png,Hổ Cáp,24/10-22/11"];
    [mainArray addObject:@"ic_sagittarius.png,Nhân Mã,23/11-21/12"];
    [mainArray addObject:@"ic_capricorn.png,Ma Kết,22/11-20/1"];
    [mainArray addObject:@"ic_aquarius.png,Bảo Bình,21/1-19/2"];
    [mainArray addObject:@"ic_pisces.png,Song Ngư,20/2-20/3"];
}

- (void) openLeftMenu
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"2");
    if (self.cID == 0) {
        self.title = @"Tử vi 2014";
    }else{
        self.title = self.stringTitle;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"3");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"4");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"5");
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mainArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSString *cellValue = [mainArray objectAtIndex:indexPath.row];
    NSArray *array = [cellValue componentsSeparatedByString:@","]; // Split String
    
    UIImage* theImage = [UIImage imageNamed:array[0]];
    
    UILabel *titleDes = (UILabel *)[cell viewWithTag:103];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:102];
    UIImageView *imgIcon = (UIImageView *)[cell viewWithTag:101];
    
    imgIcon.image = theImage;
    titleLabel.text = array[1];
    titleDes.text = array[2];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.cID == 0 || self.cID == 1) {
        NSInteger cid = indexPath.row + 1;
        NSString *cellValue = [mainArray objectAtIndex:indexPath.row];
        NSArray *array = [cellValue componentsSeparatedByString:@","]; // Split String
        
        UIStoryboard *storyboard;
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        self.listTuVi = [storyboard instantiateViewControllerWithIdentifier:@"listTuViVC"];
        
        self.listTuVi.stringTitle = array[1];
        self.listTuVi.cID = self.cID;
        self.listTuVi.category_ID = cid;
        
        [self.navigationController pushViewController:self.listTuVi animated:NO];
        
    }else if (self.cID == 3){
        NSInteger cid = indexPath.row + 1;
        NSString *cellValue = [mainArray objectAtIndex:indexPath.row];
        NSArray *array = [cellValue componentsSeparatedByString:@","]; // Split String
        self.detaiListTuVi = [self.storyboard instantiateViewControllerWithIdentifier:@"detailListTuViVC"];
        self.detaiListTuVi.stringTitle = array[1];
        self.detaiListTuVi.stringDetail = array[1];
        self.detaiListTuVi.cID = cid;
        [self.navigationController pushViewController:self.detaiListTuVi animated:NO];
    }else if(self.cID == 2){
        NSLog(@"isLogin is %@", self.isLogin ? @"YES" : @"NO");
        if (self.isLogin) {
            NSInteger cid = indexPath.row + 1;
            NSString *cellValue = [mainArray objectAtIndex:indexPath.row];
            NSArray *array = [cellValue componentsSeparatedByString:@","]; // Split String
            
            self.tuViHangNgayVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tuViHangNgayVC"];
            self.tuViHangNgayVC.stringTitle = array[1];
            self.tuViHangNgayVC.cID = cid;
            [self.navigationController pushViewController:self.tuViHangNgayVC animated:NO];
        } else{
            UIActionSheet *photoSourcePicker =
            [[UIActionSheet alloc] initWithTitle:@"Bạn đã hết xu,vui lòng nạp xu để sử dụng tính năng này !"
                                        delegate:self
                               cancelButtonTitle:@"Huỷ bỏ"
                          destructiveButtonTitle:nil
                               otherButtonTitles:
             @"Nạp 1000  xu (1000đ /1  ngày)",
             @"Nạp 2000  xu (2000đ /2  ngày)",
             @"Nạp 3000  xu (3000đ /3  ngày)",
             @"Nạp 5000  xu (5000đ /5  ngày)",
             @"Nạp 15000 xu (10000đ/15 ngày)",
             @"Nạp 30000 xu (15000đ/30 ngày)",
             nil,
             nil];
            
            [photoSourcePicker showInView:self.view];
        }
        
    }
    
}


#pragma mark- Create Using File Plist
-(void) createUsingFilePlist
{
    @try {
        //********** Create if exit user.plist
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        path = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath: path])
        {
            path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"user.plist"] ];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
        
    }
}

-(NSInteger) readCountLogin:(NSString*) objectKey
{
    NSInteger countLogin;
    @try {
        
        
        NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSString *readValueString;
        readValueString = [savedStock objectForKey:objectKey];
        //self.stringUserName = readValueString;
        if (readValueString == nil) {
            //NSLog(@"Value is null");
            countLogin = 1;
        }else{
            //NSLog(@"Value is : %@", readValueString);
            countLogin = [readValueString intValue];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
    }
    @finally {
        
    }
    return countLogin;
}

- (BOOL) checkUserCode
{
    bool isCheck;
    @try {
        NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSString *readValueString;
        readValueString = [savedStock objectForKey:@"userCode"];
        //self.stringUserName = readValueString;
        if (readValueString == nil) {
            isCheck = false;
        }else{
            isCheck = true;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
    }
    @finally {
        
    }
    return isCheck;
}

-(void) writeObjectValue:(NSString*) objectValue andKey:(NSString*) objectKey
{
    @try {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSMutableDictionary *data;
        
        if ([fileManager fileExistsAtPath: path])
        {
            data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        }
        else
        {
            // If the file doesn’t exist, create an empty dictionary
            data = [[NSMutableDictionary alloc] init];
        }
        
        NSString *writeValueString = objectValue;
        [data setObject:writeValueString forKey:objectKey];
        [data writeToFile: path atomically:YES];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
    }
    @finally {
        
    }
}

-(NSString*) readObjectWithKey:(NSString*) objectKey
{
    NSString *resultString;
    @try {
        
        NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSString *readValueString;
        readValueString = [savedStock objectForKey:objectKey];
        //self.stringUserName = readValueString;
        if (readValueString == nil) {
            resultString = [NSString stringWithFormat:@"null"];
        }else{
            resultString = [NSString stringWithFormat:@"%@",readValueString];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
    }
    @finally {
        
    }
    return resultString;
}


- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
		{
            [self showSMS:[NSString stringWithFormat:@"%@",[arrDauSo objectAtIndex:buttonIndex]]];
			break;
		}
        case 1:
		{
            [self showSMS:[NSString stringWithFormat:@"%@",[arrDauSo objectAtIndex:buttonIndex]]];
			break;
		}
        case 2:
		{
            [self showSMS:[NSString stringWithFormat:@"%@",[arrDauSo objectAtIndex:buttonIndex]]];
			break;
		}
		case 3:
		{
            [self showSMS:[NSString stringWithFormat:@"%@",[arrDauSo objectAtIndex:buttonIndex]]];
			break;
		}
        case 4:
		{
            [self showSMS:[NSString stringWithFormat:@"%@",[arrDauSo objectAtIndex:buttonIndex]]];
			break;
		}
        case 5:
		{
            [self showSMS:[NSString stringWithFormat:@"%@",[arrDauSo objectAtIndex:buttonIndex]]];
			break;
		}
	}
}

#pragma mark - Send SMS
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showSMS:(NSString*)dauSo{
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[dauSo];
    NSString *message = [NSString stringWithFormat:@"TUV %@", [self readObjectWithKey:@"userCode"]];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
