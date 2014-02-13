//
//  LeftMenuVC.m
//  tuvi
//
//  Created by DuongND on 1/21/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import "LeftMenuVC.h"
#import "UIColor+Extend.h"
#import "MainVC.h"
#import "IIViewDeckController.h"

@interface LeftMenuVC ()
{
    NSMutableArray *myObject;
    NSString *path;
    NSArray *arrDauSo;
    BOOL isLogin;
}
@end

@implementation LeftMenuVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUsingFilePlist];
    
    [self.view setBackgroundColor:[UIColor initByHexString:@"#685e55" alpha:1.0]];
    [self.myTable setBackgroundColor:[UIColor initByHexString:@"#685e55" alpha:1.0]];
    myObject = [[NSMutableArray alloc] init];
    [myObject addObject:@"ic_menu_yinyang.png,Tử vi 2014"];
    [myObject addObject:@"ic_menu_ribbon.png,Tử vi trọn đời"];
    [myObject addObject:@"ic_menu_cal.png,Tử vi hàng ngày"];
    [myObject addObject:@"ic_menu_zodiac.png,Tử vi 12 chòm sao"];
    
    //NSLog(@"1-1");
    
    if ([self readCountLogin:@"countLogin"] == 1 || ![self checkUserCode]) {
        
        [self registerUser:YES];
        
    }else{
        [self getDataList:YES];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //NSLog(@"2-1");
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //NSLog(@"3-1");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //NSLog(@"4-1");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //NSLog(@"5-1");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myObject.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // Use the default cell style.
        cell = [[UITableViewCell alloc] initWithStyle : UITableViewCellStyleSubtitle
                                      reuseIdentifier : CellIdentifier];
    }
    
    [cell setBackgroundColor:[UIColor initByHexString:@"#685e55" alpha:1.0]];
    
    NSString *cellValue = [myObject objectAtIndex:indexPath.row];
    NSArray *array = [cellValue componentsSeparatedByString:@","]; // Split String
    
    UIImage* theImage = [UIImage imageNamed:array[0]];
    cell.imageView.image = theImage;
    cell.textLabel.text = array[1];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {

        NSString *cellValue = [myObject objectAtIndex:indexPath.row];
        NSArray *array = [cellValue componentsSeparatedByString:@","]; // Split String
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        MainVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"centerVC"];
        mainVC.cID = indexPath.row;
        mainVC.stringTitle = array[1];
        mainVC.isLogin = isLogin;
        [self.viewDeckController rightViewPushViewControllerOverCenterController:mainVC];
        [self.myTable reloadData];
        
    }];
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    // Create a view of the standard size at the top of the screen.
//    // Available AdSize constants are explained in GADAdSize.h.
//    GADBannerView *bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
//    
//    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
//    bannerView_.adUnitID = @"a152df8a25c4221";
//    
//    // Let the runtime know which UIViewController to restore after taking
//    // the user wherever the ad goes and add it to the view hierarchy.
//    bannerView_.rootViewController = self;
//    
//    GADRequest * request = [GADRequest request];
//    //request.testDevices = [NSArray arrayWithObjects:@"cbe917cfd5a5dc834dda707bc37a5938", nil];
//    
//    // Initiate a generic request to load it with an ad.
//    [bannerView_ loadRequest:request];
//    
//    return bannerView_;
//}
//
//-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    // admob ad size height
//    return 50.0;
//}

#pragma mark- Đăng ký UserCode lần đầu tiên vào app nếu chưa đăng ký thì đăng ký đến khi nào được thì thôi
- (void)registerUser:(BOOL) withHUD
{
    NSString *stringUDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            stringUDID,@"imei",
                            @"1",@"platform",
                            @"TV",@"app",
                            @"post",@"type",
                            nil];
    
    if (withHUD) {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeIndeterminate;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://tranghay.vn/xosoplus/readers/register"
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id JSON) {
              NSLog(@"JSON(getContent): %@", JSON);
              
              @try {
                  
                  NSDictionary *dataDictA = [JSON objectForKey:@"Reader"];
                  
                  NSInteger currentXu = [[dataDictA objectForKey:@"xu"] integerValue];
                  
                  [self writeObjectValue:[NSString stringWithFormat:@"%@",[dataDictA objectForKey:@"code"]]
                                  andKey:@"userCode"];
                  
                  
                  if (currentXu > 0) {
                      isLogin = YES;
                  }else{
                      isLogin = NO;
                  }
                  self.lblXu.text = [NSString stringWithFormat:@"Số xu hiện tại là : %@", [dataDictA objectForKey:@"xu"]];
                  
                  NSLog(@"registerUser -- CountLogin is : %d", [self readCountLogin:@"countLogin"]);
                  NSInteger countXX = [self readCountLogin:@"countLogin"] + 1;
                  [self writeObjectValue:[NSString stringWithFormat:@"%d",countXX] andKey:@"countLogin"];
                  
                  NSLog(@"registerUser -- CountLogin is : %d", [self readCountLogin:@"countLogin"]);
                  NSLog(@"registerUser -- UserCode is   : %@",[self readObjectWithKey:@"userCode"]);
                  NSLog(@"registerUser -- Xu is         : %d",currentXu);
                  
              }
              @catch (NSException *exception) {
                  NSLog(@"%@", exception.reason);
                  
              }
              @finally {
                  if (withHUD) {
                      HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                      HUD.mode = MBProgressHUDModeCustomView;
                      [HUD hide:YES];
                  } else {
                      //[self stopLoading];
                  }
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Request Failed with Error: %@", error);
              //self.title = @"Lỗi kết nối mạng !";
              if (withHUD) {
                  [HUD hide:YES];
              } else {
                  //[self stopLoading];
              }
          }];
}

#pragma mark - get Info User
- (void) getDataList: (BOOL) withHUD
{
    NSString *stringURL = [NSString stringWithFormat:@"http://tranghay.vn/xosoplus/readers/get_reader?code=%@",[self readObjectWithKey:@"userCode"]];
    
    if (withHUD) {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeIndeterminate;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:stringURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON(getDataList): %@", responseObject);
        NSDictionary *dataDictA = [responseObject objectForKey:@"Reader"];
        
        NSInteger xuInt = [[dataDictA objectForKey:@"xu"] integerValue];
        
        if (xuInt > 0) {
            isLogin = YES;
        }else{
            isLogin = NO;
        }
        self.lblXu.text = [NSString stringWithFormat:@"Số xu hiện tại là : %@", [dataDictA objectForKey:@"xu"]];
        
        
        NSLog(@"isSuccess is : %@", isLogin ? @"YES" : @"NO");
        NSLog(@"Số xu hiện tại là : %d",xuInt);
        NSLog(@"GetDataList - userCode is : %@", [dataDictA objectForKey:@"code"]);
        
        //
        
        if (withHUD) {
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            HUD.mode = MBProgressHUDModeCustomView;
            [HUD hide:YES];
        } else {
            //[self stopLoading];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failed with Error: %@", error);
        //self.title = @"Lỗi kết nối mạng !";
        if (withHUD) {
            [HUD hide:YES];
        } else {
            //[self stopLoading];
        }
    }];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
