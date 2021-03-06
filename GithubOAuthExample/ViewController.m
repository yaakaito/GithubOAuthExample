//
//  ViewController.m
//  GithubOAuthExample
//
//  Created by yaakaito on 12/09/01.
//  Copyright (c) 2012年 yaakaito. All rights reserved.
//

#import "ViewController.h"
#import "Keys.h"
#import "OAuth.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)startOAuth:(id)sender {
    NSString *scope = @"public_repo,repo,repo:status,gist";
    NSString *state = [OAuth stateGen];
    ((OAuth*)[OAuth sharedObject]).state = state;
    ((OAuth*)[OAuth sharedObject]).enable = YES;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/login/oauth/authorize?client_id=%@&scope=%@&state=%@",kClientId, scope, state]];
    [[UIApplication sharedApplication] openURL:url];
}
@end
