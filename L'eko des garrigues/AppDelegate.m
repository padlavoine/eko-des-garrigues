//
//  AppDelegate.m
//  L'eko des garrigues
//
//  Created by boris on 08/06/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import "AppDelegate.h"
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad


@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	
	
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
		[[UITabBar appearance] setBarStyle:UIBarStyleBlackOpaque];
		[[UITabBar appearance] setBackgroundColor:[UIColor blackColor]];
		[[UITabBar appearance] setTintColor:[UIColor colorWithRed:1 green:0.92 blue:0.35 alpha:1]];

		[[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
		[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
		[[UINavigationBar appearance] setTitleTextAttributes:
		[NSDictionary dictionaryWithObjectsAndKeys:
			[UIColor whiteColor], NSForegroundColorAttributeName, nil, nil,  nil, nil, nil]];
	
	}
	
	//[[UIApplication sharedApplication] setStatusBarHidden:NO];
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
 
	NSError *setCategoryError = nil;
	BOOL success = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
	if (!success) { /* handle the error condition */ }
 
	NSError *activationError = nil;
	success = [audioSession setActive:YES error:&activationError];
	if (!success) { /* handle the error condition */ }
	
    [self setDataController:[[DataController alloc] init]];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
