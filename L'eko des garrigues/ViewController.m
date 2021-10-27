//
//  ViewController.m
//  L'eko des garrigues
//
//  Created by boris on 08/06/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import "ViewController.h"


#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface ViewController ()  <StreamDelegate>
            

@end

@implementation ViewController

#pragma mark - Load


-(UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
    dataController = [[DataController alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PLAYLIST" inManagedObjectContext:dataController.managedObjectContext];
    playlist = [[PLAYLIST alloc] initWithEntity:entity insertIntoManagedObjectContext:dataController.managedObjectContext];
    NSLog(@"%@",dataController.managedObjectContext);
	userAction = false;

	stream = [[Stream alloc] init];
	stream.delegate = self;
	
	if(IPAD) {
		self.splitViewController.delegate = self;
	}
	self.view.backgroundColor = [UIColor blackColor];
	
	UIImage *btnImage = [UIImage imageNamed:@"play.png"];
	[self.stateStream setImage:btnImage forState:UIControlStateNormal];
	[self.stateStream removeTarget:self action:@selector(stopStream:) forControlEvents:UIControlEventTouchDown];
	[self.stateStream removeTarget:self action:@selector(playStream:) forControlEvents:UIControlEventTouchDown];
	[self.stateStream addTarget:self  action:@selector(playStream:) forControlEvents:UIControlEventTouchDown];
	
	
	[self getNameTrack];
	
	
	
	[NSTimer scheduledTimerWithTimeInterval:10.0 target:self
		selector:@selector(getNameTrack) userInfo:nil repeats:YES];
	
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(stateChanged:)
												 name: MPMoviePlayerLoadStateDidChangeNotification
											   object: stream.player];
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(playBackStateChanged:)
												 name: MPMoviePlayerPlaybackStateDidChangeNotification
											   object: stream.player];
	
	
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		if ([[UIScreen mainScreen] scale] == 2.0) {
			//RETINA DISPLAY
			//NSLog(@"Retina %f",[UIScreen mainScreen].bounds.size.height);
			if([UIScreen mainScreen].bounds.size.height < 568){
				self.imgBottom.hidden = YES;
			} else{
				
			}
		}
		else {
			// NON RETINA
			//NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
			if([UIScreen mainScreen].bounds.size.height < 568){
				self.imgBottom.hidden = YES;
			}
		}
	}
	
	
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
 
	// Turn on remote control event delivery
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
 
	// Set itself as the first responder
	[self becomeFirstResponder];
    
    if(!IPAD ) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
	// Turn off remote control event delivery
	[[UIApplication sharedApplication] endReceivingRemoteControlEvents];
 
	// Resign as first responder
	[self resignFirstResponder];
 
	
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}



#pragma mark - Background Event
- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {

	if (receivedEvent.type == UIEventTypeRemoteControl) {
		switch (receivedEvent.subtype) {
				
			case UIEventSubtypeRemoteControlPlay:
				[stream playOrStopAudio];
				break;
			case UIEventSubtypeRemoteControlPause:
				[stream playOrStopAudio];
				break;
			case UIEventSubtypeRemoteControlTogglePlayPause:
				[stream playOrStopAudio];
				break;
				
			case UIEventSubtypeRemoteControlPreviousTrack:
				
				break;
				
			case UIEventSubtypeRemoteControlNextTrack:
				
				break;
				
			default:
				NSLog(@"Event4");
				break;
		}
	}
}


#pragma mark - UI Action

- (IBAction)playStream:(UIButton *)sender {
	[stream playAudio];
}

- (IBAction)stopStream:(UIButton *)sender {
	userAction = true;
	[stream stopAudio];
}
- (IBAction)showDons:(id)sender {
	
}
- (IBAction)showMailinglist:(id)sender {
	
}



#pragma mark - DELEGATE

-(void)stateChanged:(id)sender
{
	switch ([stream.player loadState]) {
		case MPMovieLoadStateUnknown :
		{
			NSLog(@"StateUnknown");
			
			if(userAction || ![stream isConnected]) {
				UIImage *btnImage = [UIImage imageNamed:@"play.png"];
				[self.stateStream setImage:btnImage forState:UIControlStateNormal];
				[self.stateStream removeTarget:self action:@selector(stopStream:) forControlEvents:UIControlEventTouchDown];
				[self.stateStream addTarget:self  action:@selector(playStream:) forControlEvents:UIControlEventTouchDown];
			} else {
				NSLog(@"stopped by other");
				[NSTimer scheduledTimerWithTimeInterval:3.0 target:self
											   selector:@selector(playStream:) userInfo:nil repeats:NO];
				
			}
			
			userAction = false;
			break;
		}
		case MPMovieLoadStatePlayable :
		{
			NSLog(@"StatePlayable");
			UIImage *btnImage = [UIImage imageNamed:@"stop.png"];
			[self.stateStream setImage:btnImage forState:UIControlStateNormal];
			[self.stateStream removeTarget:self action:@selector(playStream:) forControlEvents:UIControlEventTouchDown];
			[self.stateStream addTarget:self  action:@selector(stopStream:) forControlEvents:UIControlEventTouchDown];
			[spinner removeSpinner];
			break;
		}
		case MPMovieLoadStatePlaythroughOK :
			NSLog(@"PlaythroughOK");
			[self stopStream:nil];
			break;
		case MPMovieLoadStateStalled :
			NSLog(@"StateStalled");
			[self stopStream:nil];
			break;
	}
}
-(void)playBackStateChanged:(id)sender
{
	MPMoviePlaybackState playbackState = [stream.player playbackState];
	
	switch (playbackState) {
		case MPMoviePlaybackStateStopped :
			NSLog(@"stopped");
			[spinner removeSpinner];
			break;
		case MPMoviePlaybackStatePlaying :
			NSLog(@"playing");
			spinner = [SpinnerView loadSpinnerIntoView:_loaderView];
			break;
		case MPMoviePlaybackStateInterrupted :
			NSLog(@"interrupt");
			spinner = [SpinnerView loadSpinnerIntoView:_loaderView];
			break;
		case MPMoviePlaybackStatePaused :
			NSLog(@"pauser");
			[spinner removeSpinner];
			break;
		case MPMoviePlaybackStateSeekingBackward :
			NSLog(@"backward");
			break;
		case MPMoviePlaybackStateSeekingForward :
			NSLog(@"forward");
			break;
	}
}

- (void)connectivityChanged:(Reachability *)curReach {
	if (curReach == NotReachable) {
		NSLog(@"NotReachable");
	} else {
		NSLog(@"Reachable");
	}
}

- (BOOL) splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
	return NO;
}






#pragma mark - Function

- (void) getNameTrack {
	[stream getNameTrack];
    
	if([stream.nameArtist isEqual: @"NOCONNECTION"]) {
		[self.nameArtist setText:@""];
		[self.nameTrack setText:@"Pas de connexion internet"];
	} else {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PLAYLIST"];
        NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:FALSE];
        NSArray *sortDescriptors = @[dateSort];
        
        [request setSortDescriptors:sortDescriptors];
        [request setReturnsObjectsAsFaults:NO];
        [request setFetchLimit:1];
        

        NSManagedObjectContext *moc = dataController.managedObjectContext;
        NSArray *result = [moc executeFetchRequest:request error:nil];
        //NSLog(@"%@",result);
        
        if([result count] > 0) {
            playlist = [result objectAtIndex:0];
        }
        [self.nameTrack setText:stream.nameTrack];
        [self.nameArtist setText:stream.nameArtist];
        
        if([playlist.trackname isEqual:stream.nameTrack] && [playlist.trackartist isEqual:stream.nameArtist]) {
        } else {
            playlist.trackname = stream.nameTrack;
            playlist.trackartist = stream.nameArtist;
            playlist.date = [NSDate date];
            [playlist save];
        }
        
	}
	[self.nameTrack setTextColor:[UIColor whiteColor]];
	[self.nameTrack setTextAlignment:NSTextAlignmentCenter];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
	UIButton *btn = (UIButton *)sender;
	UINavigationController *controllerDons;
	if(btn.tag == 1) {
		controllerDons = [self.storyboard instantiateViewControllerWithIdentifier: @"viewDons"];
	} else {
		controllerDons = [self.storyboard instantiateViewControllerWithIdentifier: @"viewMailinglist"];
	}

	UINavigationController *controller = [segue destinationViewController];
	
	[controller pushViewController:controllerDons animated:YES];
*/
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}


@end
