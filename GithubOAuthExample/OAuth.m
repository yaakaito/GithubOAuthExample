//
//  OAuth.m
//  GithubOAuthExample
//
//  Created by yaakaito on 12/09/01.
//  Copyright (c) 2012年 yaakaito. All rights reserved.
//

#import "OAuth.h"
#import "Keys.h"
#import <AFNetworking/AFNetworking.h>

@implementation OAuth

+ (id)sharedObject {
    
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

+ (NSString *)stateGen {
    // なんかしらのアルゴリズムで作る
    return kFakeState;
}

- (void)oauthWithCode:(NSString *)code state:(NSString *)state {
    
    if(![state isEqualToString:self.state]) {
        abort();
    }
    
    NSURL *url = [NSURL URLWithString:@"https://github.com/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSDictionary *params = @{ @"code" : code,
                              @"client_id" : kClientId,
                              @"client_secret" : kClientSecret,
                              @"state" : self.state};
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:@"/login/oauth/access_token" parameters:params];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", response);
        NSArray *queryComponents = [response componentsSeparatedByString:@"&"];
        NSMutableDictionary *queries = [NSMutableDictionary dictionary];
        for (NSString *component in queryComponents) {
            NSArray *kv = [component componentsSeparatedByString:@"="];
            [queries setObject:[kv objectAtIndex:1] forKey:[kv objectAtIndex:0]];
        }
        NSLog(@"getted token %@", [queries objectForKey:@"access_token"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
    [operation start];
}
@end
