//
//  Util.h
//  DemoAFNetworking
//
//  Created by techmaster on 10/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dump : NSObject
+ (NSString *) genRandStringLength: (int) len;
+ (NSString *) genRandomEmail;
+ (NSString *) getImageName:(NSInteger) pos;
+ (NSString *) getImageNameC:(NSInteger) pos;
@end
