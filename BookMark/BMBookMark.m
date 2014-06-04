//
//  BookMark.m
//  BookMarker
//
//  Created by Daniel Alabi on 4/15/14.
//  Copyright (c) 2014 Daniel Alabi. All rights reserved.
//

#import "BMBookMark.h"

@implementation BMBookMark

// implementation of serialize. See .h file for documentation.
+ (NSMutableArray *) serialize: (NSMutableArray*)rawBookmarks {
    NSMutableArray * newArray = [[NSMutableArray alloc] init];
    int count = [rawBookmarks count];
    BMBookMark *bookmark;
    NSString *serializedString;
    
    for (int i = 0; i < count; i++) {
        bookmark = [rawBookmarks objectAtIndex:i];
        serializedString = [NSString stringWithFormat:@"%@|%@", bookmark.name, bookmark.uri];
        [newArray addObject:serializedString];
    }
    
    return newArray;
}

// implementation of unserialize. See .h file for documentation.
+ (NSMutableArray *) unserialize:(NSMutableArray*)processedBookmarks {
    NSMutableArray * newArray = [[NSMutableArray alloc] init];
    int count = [processedBookmarks count];
    NSString *bookmarkString;
    BMBookMark *bookmark;
    
    NSArray *nsa;
    for (int i = 0; i < count; i++) {
        bookmarkString = [processedBookmarks objectAtIndex:i];
        nsa = [bookmarkString componentsSeparatedByString:@"|"];
        bookmark = [[BMBookMark alloc] init];
        bookmark.name = [nsa objectAtIndex:0];
        bookmark.uri = [nsa objectAtIndex:1];
        [newArray addObject:bookmark];
    }
    
    return newArray;
}

@end
