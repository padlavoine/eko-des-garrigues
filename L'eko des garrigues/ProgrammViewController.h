//
//  ProgrammViewController.h
//  L'eko des garrigues
//
//  Created by boris on 11/06/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinnerView.h"

@interface ProgrammViewController : UIViewController <UIWebViewDelegate> {
	BOOL weeklyProgram;
	UIWebView *webview;
	SpinnerView * spinner;
	NSURLRequest *requestObject;
}

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *linkSwitch;

@property (weak, nonatomic) IBOutlet UIButton *btnProgramme;
@property (weak, nonatomic) IBOutlet UIButton *btnEmission;


@end
