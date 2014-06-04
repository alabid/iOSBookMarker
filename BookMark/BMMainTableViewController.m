//
//  BMMainTableViewController.m
//  BookMarker
//
//  Created by Daniel Alabi on 4/15/14.
//  Copyright (c) 2014 Daniel Alabi. All rights reserved.
//

# import "BMMainTableViewController.h"
# import "BMAddBookMarkViewController.h"
# import "BMWebBrowserViewController.h"
# import "BMBookMark.h"

@interface BMMainTableViewController ()

@property NSMutableArray *bookmarks;

@end


@implementation BMMainTableViewController

-(IBAction) unwindToList:(UIStoryboardSegue *) segue {
    BMAddBookMarkViewController *source = [segue sourceViewController];
    BMBookMark *newBookMark = source.currentBookMark;
    
    if (newBookMark != nil) {
        NSString *uriString = newBookMark.uri;

        // check if new URI has a protocol. If not, assume and append http
        BOOL hasHttp = [[uriString lowercaseString] hasPrefix:@"http://"];
        if (hasHttp) {
            newBookMark.uri = uriString;
        } else {
            NSString *goodUri = [NSString stringWithFormat:@"http://%@", uriString];
            newBookMark.uri = goodUri;
        }
        
        BOOL safeToInsert = YES;
        BMBookMark *bookmark;
        for (int i = 0; i < [self.bookmarks count]; i++) {
            bookmark = [self.bookmarks objectAtIndex:i];
            if ([bookmark.name isEqualToString:newBookMark.name]) {
                safeToInsert = NO;
                bookmark.uri = newBookMark.uri;
            }
        }
        
        if (safeToInsert == YES) {
            [self.bookmarks addObject:newBookMark];
            [self.tableView reloadData];
        }
    }
    
    [self saveData];
}


-(void) loadBookMarks {
    NSMutableArray *ns = [self getData];

    // load Array of BookMarks into 'self.bookmarks'
    if (ns != nil) {
        self.bookmarks = [self getData];
    } else {
        self.bookmarks = [[NSMutableArray alloc] init];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create 'Edit' button on navigation bar
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    // make table rows selectable during editing
    self.tableView.allowsSelectionDuringEditing = YES;
    
    [self loadBookMarks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.bookmarks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"BookMarkCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
    BMBookMark *bookmark = [self.bookmarks objectAtIndex:indexPath.row];
    cell.textLabel.text = bookmark.name;
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.bookmarks removeObjectAtIndex:indexPath.row];
        [self saveData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated: NO];
    
    BMBookMark *bookmark = [self.bookmarks objectAtIndex: indexPath.row];
    NSString *name = bookmark.name;
    NSString *uri = bookmark.uri;
    
    
    if (tableView.editing == YES) {
        /*
         * Open AddNewBookMark view to edit currently selected BookMark
         */
        BMAddBookMarkViewController *addController =
        [[UIStoryboard storyboardWithName:@"Main" bundle:NULL]
         instantiateViewControllerWithIdentifier:@"BMAddBookMarkView"];
        
        // pass in the data for the selected BookMark to BMAddBookMarkViewController
        addController.currentBookMark = [[BMBookMark alloc] init];
        addController.currentBookMark.name = name;
        addController.currentBookMark.uri = uri;
        
        [self.navigationController pushViewController: addController animated:YES];
        
        return;
    }
    
    /** open your app browser here -- using 'uri' */
    BMWebBrowserViewController *browserController =
    [[BMWebBrowserViewController alloc]
    initWithNibName:@"BMWebBrowserViewController"
    bundle:nil];
    
    // pass in the URI to open in the browser
    browserController.uri = uri;
    
    [self.navigationController pushViewController: browserController animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    [super setEditing:flag animated:animated];
    if (flag == YES){
        NSLog(@"changed views to edit mode");
        // Change views to edit mode.
    }
    else {
        NSLog(@"save the changes if needed and change the views to noneditable");
        // Save the changes if needed and change the views to noneditable.
    }
}

-(void) saveData {
    // save data to NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[BMBookMark serialize:self.bookmarks] forKey: @"bookmarks"];
}

-(NSMutableArray *) getData {
    // get data from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [BMBookMark unserialize: [defaults objectForKey:@"bookmarks"]];
}


@end
