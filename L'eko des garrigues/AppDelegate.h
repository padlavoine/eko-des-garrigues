//
//  AppDelegate.h
//  L'eko des garrigues
//
//  Created by boris on 08/06/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "DataController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DataController *dataController;

@end

