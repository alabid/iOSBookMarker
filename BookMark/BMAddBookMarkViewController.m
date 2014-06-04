//
//  BMAddBookMarkViewController.m
//  BookMarker
//
//  Created by Daniel Alabi on 4/15/14.
//  Copyright (c) 2014 Daniel Alabi. All rights reserved.
//

#import "BMAddBookMarkViewController.h"

@interface BMAddBookMarkViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *uri;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation BMAddBookMarkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // set name and URI of BookMark being edited
    if (self.currentBookMark != nil) {
        self.name.text = self.currentBookMark.name;
        self.uri.text = self.currentBookMark.uri;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton ||
        self.name.text.length == 0 ||
        self.uri.text.length == 0) {
        return;
    }
    
    // store result of editing current BookMark
    self.currentBookMark = [[BMBookMark alloc] init];
    self.currentBookMark.name = self.name.text;
    self.currentBookMark.uri = self.uri.text;
}

@end
