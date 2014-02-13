//
//  Horoscope.h
//  tuvi
//
//  Created by DuongND on 1/22/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Horoscope : NSObject

@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *mood;
@property (nonatomic, strong) NSString *mood_star;
@property (nonatomic, strong) NSString *love;
@property (nonatomic, strong) NSString *love_star;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *money_star;
@property (nonatomic, strong) NSString *work;
@property (nonatomic, strong) NSString *work_star;

-(id) initWithSummary:(NSString*) summary
              andmood:(NSString*) mood
         andmood_star:(NSString*) mood_star
              andlove:(NSString*) love
         andlove_star:(NSString*) love_star
             andmoney:(NSString*) money
        andmoney_star:(NSString*) money_star
              andwork:(NSString*) work
         andwork_star:(NSString*) work_star;

@end
