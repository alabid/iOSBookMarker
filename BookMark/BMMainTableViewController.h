//
//  BMMainTableViewController.h
//  BookMarker
//
//  Created by Daniel Alabi on 4/15/14.
//  Copyright (c) 2014 Daniel Alabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMMainTableViewController : UITableViewController

-(IBAction) unwindToList:(UIStoryboardSegue *) segue;

/*
 * Load BookMarks into self.bookmarks private variable
 */
-(void) loadBookMarks;

/*
 * Save BookMarks to persistent storage using NSUserDefaults
 */
-(void) saveData;

/*
 * Load BookMarks from persistent storage using NSUserDefaults
 */
-(NSMutableArray *) getData;

@end
