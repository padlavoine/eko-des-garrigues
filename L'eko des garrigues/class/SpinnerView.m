//
//  SpinnerView.m
//  L'eko des garrigues
//
//  Created by boris on 11/07/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import "SpinnerView.h"

@implementation SpinnerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)removeSpinner {
	[super removeFromSuperview];
}

+(SpinnerView *)loadSpinnerIntoView:(UIView *)superView{
	// Create a new view with the same frame size as the superView
	SpinnerView *spinnerView = [[SpinnerView alloc] initWithFrame:superView.bounds];
	
	// If something's gone wrong, abort!
	if(!spinnerView){ return nil; }
 
	// This is the new stuff here ;)
	UIActivityIndicatorView *indicator =
	[[UIActivityIndicatorView alloc]
	  initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
	
	
	// Set the resizing mask so it's not stretched
	indicator.autoresizingMask =
	UIViewAutoresizingFlexibleTopMargin |
	UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleBottomMargin |
	UIViewAutoresizingFlexibleLeftMargin;
	
	// Place it in the middle of the view
	indicator.center = spinnerView.center;
 
	// Add it into the spinnerView

	[spinnerView addSubview:indicator];
 
	// Start it spinning! Don't miss this step
	[indicator startAnimating];
	
	// Just to show we've done something, let's make the background black
	spinnerView.backgroundColor = [UIColor blackColor];
 
	// Add the spinner view to the superView. Boom.
	[superView addSubview:spinnerView];

 
	return spinnerView;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
