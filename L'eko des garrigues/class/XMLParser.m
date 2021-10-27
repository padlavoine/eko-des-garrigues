//
//  XMLParser.m
//  L'eko des garrigues
//
//  Created by boris on 22/04/2015.
//  Copyright (c) 2015 Wearcraft. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

@synthesize nameArtist,nameTrack;
- (XMLParser *) initXMLParser {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"PLAYER"]) {

    }
    
    if ( [elementName isEqualToString:@"TRACK"]) {
        NSString *thisArtist = [attributeDict objectForKey:@"ARTIST"];
        if (thisArtist)
            nameArtist = thisArtist;
        NSString *thisTrack = [attributeDict objectForKey:@"TITLE"];
        if (thisTrack)
            nameTrack = thisTrack;
        
        return;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        // init the ad hoc string with the value
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        // append value to the ad hoc string
        [currentElementValue appendString:string];
    }
}  


- (void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"PLAYER"]) {
        // We reached the end of the XML document
        return;
    }
}



@end

