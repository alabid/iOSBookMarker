//
//  BookMark.h
//  BookMarker
//
//  Created by Daniel Alabi on 4/15/14.
//  Copyright (c) 2014 Daniel Alabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMBookMark : NSObject

@property NSString *name;
@property NSString *uri;

/*
 * Used to serialize an array of BookMarks to a representative array of Strings
 * A BookMark with name = @"CNN" and uri = @"http://cnn.com" is stored as
 *                 @"CNN|http://cnn.com"
 */
+ (NSMutableArray *) serialize: (NSMutableArray*) rawBookmarks;

/*
 * Used to un-serialize an array of strings used to represent BookMarks into
 * an array of BookMarks
 */
+ (NSMutableArray *) unserialize: (NSMutableArray*) processedBookmarks;

@end
