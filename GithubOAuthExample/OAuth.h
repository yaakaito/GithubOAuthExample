//
//  OAuth.h
//  GithubOAuthExample
//
//  Created by yaakaito on 12/09/01.
//  Copyright (c) 2012年 yaakaito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth : NSObject
@property (nonatomic, retain) NSString *state;
@property (nonatomic) BOOL enable;
+ (id)sharedObject;
+ (NSString*)stateGen;
- (void)oauthWithCode:(NSString*)code state:(NSString*)state;
@end
