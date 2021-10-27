//
//  ViewController.h
//  L'eko des garrigues
//
//  Created by boris on 08/06/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stream.h"
#import "SpinnerView.h"
#import "DataController.h"
#import "PLAYLIST.h"


@interface ViewController : UIViewController <UISplitViewControllerDelegate>{
	Stream* stream;
	SpinnerView* spinner;
	BOOL userAction;
    PLAYLIST* playlist;
    DataController *dataController;
    
    NSString *currentTrackName;
    NSString *currentArtistName;

}
- (IBAction)playStream:(UIButton *)sender;
- (IBAction)stopStream:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *stateStream;
@property (weak, nonatomic) IBOutlet UILabel *nameArtist;
@property (weak, nonatomic) IBOutlet UITextView *nameTrack;
@property (weak, nonatomic) IBOutlet UIView *loaderView;

@property (weak, nonatomic) IBOutlet UIImageView *imgBottom;




@end

