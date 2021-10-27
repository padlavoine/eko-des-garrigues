//
//  SpinnerView.h
//  L'eko des garrigues
//
//  Created by boris on 11/07/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView

+(SpinnerView *)loadSpinnerIntoView:(UIView *)superView;
-(void)removeSpinner;
@end
