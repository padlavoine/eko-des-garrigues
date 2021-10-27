//
//  XMLParser.h
//  L'eko des garrigues
//
//  Created by boris on 22/04/2015.
//  Copyright (c) 2015 Wearcraft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLParser : NSObject {
    // an ad hoc string to hold element value
    NSMutableString *currentElementValue;
}
@property(nonatomic, readonly) NSString* nameArtist;
@property(nonatomic, readonly) NSString* nameTrack;

- (XMLParser *) initXMLParser;

@end