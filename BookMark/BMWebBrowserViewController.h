//
//  BMWebBrowserViewController.h
//  BookMarker
//
//  Created by Daniel Alabi on 4/16/14.
//  Copyright (c) 2014 Daniel Alabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMWebBrowserViewController : UIViewController <UIWebViewDelegate>

@property NSString *uri;

/*
 * Used to load pages in the browser
 */
- (void) loadRequestFromString:(NSString*) uriString;

/*
 * Update buttons for Web View
 */
- (void) updateButtons;

@end
