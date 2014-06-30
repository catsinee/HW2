//
//  statusViewController.m
//  HW2
//
//  Created by Kansinee Adsanatham on 6/29/14.
//  Copyright (c) 2014 kansinee. All rights reserved.
//

#import "statusViewController.h"

@interface statusViewController ()
- (IBAction)cancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *statusTextField;
- (IBAction)statusTextField:(id)sender ;

@end

@implementation statusViewController

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
    // Do any additional setup after loading the view from its nib.
      [self.statusTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)statusTextField:(id)sender {
    
}
- (IBAction)cancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
