//
//  j.m
//  GithubOAuthExample
//
//  Created by yaakaito on 12/09/03.
//  Copyright (c) 2012年 yaakaito. All rights reserved.
//

#import "j.h"

@implementation j

+ (id)sharedReportManager {
    
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;    
}
@end
