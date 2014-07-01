//
//  FeedViewController.m
//  HW2
//
//  Created by Kansinee Adsanatham on 6/27/14.
//  Copyright (c) 2014 kansinee. All rights reserved.
//

#import "FeedViewController.h"
#import "statusViewController.h"
#import "MoreViewController.h"

@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *leftButtonImage;
@property (weak, nonatomic) IBOutlet UIScrollView *feedView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;


- (IBAction)statusButton:(id)sender;
- (void)loadFeed;
@end

@implementation FeedViewController

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
    
    self.navigationItem.title = @"News Feed";
     self.feedView.alpha = 0;
    [self.indicatorView startAnimating];
    
[self performSelector:@selector(loadFeed) withObject:nil afterDelay:2];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.center = self.view.center;
    
    UIImage *leftButtonImage = [[UIImage imageNamed:@"ico_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    [self.view addSubview:indicatorView];
    
}

-(void)onLeftButton
{
    
}

-(void)loadFeed
{
    self.feedView.alpha = 1;
    [self.indicatorView stopAnimating];
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)statusButton:(id)sender {
    
    UIViewController *vc = [[statusViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:vc animated:YES completion:nil];
}
@end
