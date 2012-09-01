//
//  OAuth.h
//  GithubOAuthExample
//
//  Created by yaakaito on 12/09/01.
//  Copyright (c) 2012年 yaakaito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth : NSObject

- (void)oauthWithCode:(NSString*)code;
@end
