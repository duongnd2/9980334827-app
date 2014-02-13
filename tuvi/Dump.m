//
//  Util.m
//  DemoAFNetworking
//
//  Created by techmaster on 10/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "Dump.h"

@implementation Dump
static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+ (NSString *) genRandStringLength: (int) len
{
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
};

+ (NSString *) genRandomEmail
{
    NSString *firstPart = [Dump genRandStringLength :8];
    NSString *secondPart= [Dump genRandStringLength :8];
    NSArray *domainSuffix = @[@"com", @"org", @"net", @"vn", @"ca"];
    NSString *randomDomainSuffix = domainSuffix[arc4random()%[domainSuffix count]];
    return [NSString stringWithFormat:@"%@@%@.%@", firstPart, secondPart, randomDomainSuffix];
};

+ (NSString *) getImageName: (NSInteger) pos
{
    NSString *string;
    NSArray *array = [NSArray arrayWithObjects:
                      @"ic_rat.png",
                      @"ic_buffalo.png",
                      @"ic_tiger.png",
                      @"ic_cat.png",
                      @"ic_dragon.png",
                      @"ic_snake.png",
                      @"ic_horse.png",
                      @"ic_goat.png",
                      @"ic_monkey.png",
                      @"ic_chicken.png",
                      @"ic_dog.png",
                      @"ic_pig.png",nil];
    
    string = [array objectAtIndex:pos];
    
    return string;
};

+ (NSString *) getImageNameC: (NSInteger) pos
{
    NSString *string;
    NSArray *array = [NSArray arrayWithObjects:
                      @"ic_aries.png",
                      @"ic_taurus.png",
                      @"ic_gemini.png",
                      @"ic_cancer.png",
                      @"ic_leo.png",
                      @"ic_virgo.png",
                      @"ic_libra.png",
                      @"ic_scorpio.png",
                      @"ic_sagittarius.png",
                      @"ic_capricorn.png",
                      @"ic_aquarius.png",
                      @"ic_pisces.png",nil];
    string = [array objectAtIndex:pos];
    
    return string;
};
@end
