//
//  Stream.h
//  Eko Des Garrigues
//
//  Created by boris on 08/06/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Reachability.h"
#import "XMLParser.h"

@protocol StreamDelegate;

@interface Stream : NSObject {
	MPMoviePlayerController *player;
	
		
	Reachability* networkReachability;

	BOOL nowPlaying; // Is playing ?
	
	int countErrorTxt;
    
    XMLParser *parser; // Parser XML
}

@property (nonatomic, weak) id<StreamDelegate> delegate;
@property (nonatomic, retain) MPMoviePlayerController *player;
@property(nonatomic, readonly) NSString* nameArtist;
@property(nonatomic, readonly) NSString* nameTrack;
@property (nonatomic)  Reachability* networkReachability;

- (BOOL) playAudio;
- (BOOL) pauseAudio;
- (BOOL) stopAudio;
- (void) playOrStopAudio;
- (void)getNameTrack;

- (BOOL) isConnected;

@end


@protocol StreamDelegate <NSObject>
// Indique que la méthode doit obligatoirement être implémentée
// @required @optional )
@required
- (void)connectivityChanged:(Reachability *)curReach;


@end