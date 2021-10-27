//
//  Stream.m
//  Eko Des Garrigues
//
//  Created by boris on 08/06/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

/*
 MPMusicPlaybackStateStopped,
 MPMusicPlaybackStatePlaying,
 MPMusicPlaybackStatePaused,
 MPMusicPlaybackStateInterrupted,
 MPMusicPlaybackStateSeekingForward,
 MPMusicPlaybackStateSeekingBackward
 */

#import "Stream.h"


@implementation Stream

@synthesize player,nameArtist,nameTrack,networkReachability;

- (id) init {
	if ( self = [super init] ) {
		
		// http://91.121.159.124:8000/eko-des-garrigues-32k.mp3
		// http://91.121.159.124:8000/eko-des-garrigues-128k.mp3
		
		player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://91.121.159.124:8000/eko-des-garrigues-128k.mp3"]];
		player.movieSourceType = MPMovieSourceTypeStreaming;

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
		
		networkReachability = [Reachability reachabilityForInternetConnection];
		[networkReachability startNotifier];
		
		nowPlaying = false;
	}
	return self;
}



- (BOOL) playAudio {
	if([self isConnected] == FALSE) {
		return false;
	}
	NSLog(@"playAudio");
	[player stop];
	[player play];
	nowPlaying = true;
	return true;
}

- (BOOL) pauseAudio {
	[player pause];
	nowPlaying = false;
	return true;
}

- (BOOL) stopAudio {	
	[player stop];
	nowPlaying = false;
	return true;
}

- (void) playOrStopAudio {
	NSLog(@"PlayOrStopStop");
	if (nowPlaying) {
		[self stopAudio];
	} else {
		[self playAudio];
	}
}



- (void)getNameTrackOld {
	NSString *string = @" :: ";
	
	if([self isConnected] == FALSE) {
		nameArtist = @"NOCONNECTION";
		nameTrack = @"NOCONNECTION";
		return;
	}
	
	NSURL *URL = [NSURL URLWithString:@"http://www.ekodesgarrigues.com/EKO-LIVE/Lecteur-Mp3/Appli.txt"];
	NSData *data = [NSData dataWithContentsOfURL:URL];
 
	
	if(data != nil) {
		countErrorTxt=0;
		string = [NSString stringWithUTF8String:[data bytes]];
		NSArray *tracks = [string componentsSeparatedByString: @" :: "];
		nameArtist = [tracks objectAtIndex:0];
		nameTrack = [tracks objectAtIndex:1];
	} else {
		countErrorTxt++;
		if(countErrorTxt > 3) {
			countErrorTxt=0;
			nameArtist = @"";
			nameTrack = @"";
		}
	}

	nameArtist = [nameArtist stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	nameTrack = [nameTrack stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
}



  - (void)getNameTrack {
    if([self isConnected] == FALSE) {
        nameArtist = @"NOCONNECTION";
        nameTrack = @"NOCONNECTION";
        return;
    }
      
    NSURL *URL = [NSURL URLWithString:@"http://www.ekodesgarrigues.com/EKO-LIVE/Lecteur-Mp3/nowplaying.xml"];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];

    // create and init our delegate
    XMLParser *parser = [[XMLParser alloc] initXMLParser];

    // set delegate
    [nsXmlParser setDelegate:parser];

    // parsing...
    BOOL success = [nsXmlParser parse];

    // test the result
    if (success) {
        nameArtist = [parser nameArtist];
        nameTrack = [parser nameTrack];
    } else {
        
    }
}


-(BOOL) isConnected {
	NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
	if (networkStatus == NotReachable) {
		return false;
	} else {
		return true;
	}
}


/*
 
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	
	// Set DELEGATE
	if ([self.delegate respondsToSelector:@selector(connectivityChanged:)]) {
		// La méthode est appelée avec le nom de la tâche en paramètre
		[self.delegate connectivityChanged:curReach];
	}
}




@end
