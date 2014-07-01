//
//  MainViewController.m
//  HW2
//
//  Created by Kansinee Adsanatham on 6/27/14.
//  Copyright (c) 2014 kansinee. All rights reserved.
//

#import "MainViewController.h"
#import "FeedViewController.h"
#import "MoreViewController.h"
#import "statusViewController.h"

@interface MainViewController ()
- (IBAction)onTab:(id)sender;
- (IBAction)onEditChange:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *textFields;

@property (weak, nonatomic) IBOutlet UIView *loginContainerView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *signupLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButtonView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;


- (IBAction)loginButton:(id)sender;
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginContainerView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.loginContainerView.frame.size.height, self.loginContainerView.frame.size.width, self.loginContainerView.frame.size.height);
                         
                         CGRect labelFrame = self.signupLabel.frame;
                         labelFrame.origin.y -= 140;
                         self.signupLabel.frame = labelFrame;
                     }
                     completion:nil];
}


- (void)willHideKeyboard:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         CGRect containerFrame = self.loginContainerView.frame;
                         containerFrame.origin.y += 40;
                         self.loginContainerView.frame = containerFrame;
                         
                         CGRect labelFrame = self.signupLabel.frame;
                         labelFrame.origin.y += 140;
                         self.signupLabel.frame = labelFrame;
                         
                         
                     } completion:nil ];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.loginButtonView.enabled = NO;
    self.passwordTextField.secureTextEntry = YES;


  }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginButton:(id)sender {
    
    [self.view endEditing:YES];
    
    [self.loginButtonView setImage:[UIImage imageNamed:@"logging_in_button"] forState:UIControlStateNormal];
     
    [self.indicatorView startAnimating];
    
    [self performSelector:@selector(loadCondition) withObject:nil afterDelay:1];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.center = self.view.center;
    
    [self.view addSubview:indicatorView];
    
    
    

}
    
- (void) loadCondition
    {
        [self.indicatorView stopAnimating];
        
        
        [self.loginButtonView setBackgroundImage:[UIImage imageNamed:@"login_button_disabled"] forState:UIControlStateNormal];
        
        if ([self.passwordTextField.text isEqualToString:@"password"] && [self.emailTextField.text isEqualToString:@"username"]) {
            
            
            UIViewController *fvc = [[FeedViewController alloc] init];
            UIViewController *mvc = [[MoreViewController alloc] init];
            
            UINavigationController *fnc = [[UINavigationController alloc] initWithRootViewController:fvc];
            fnc.navigationBar.barTintColor = [UIColor colorWithRed:.23 green:.35 blue:.60 alpha:1];
            fnc.navigationBar.tintColor = [UIColor whiteColor];
            
            NSShadow *shadow = [[NSShadow alloc] init];
            
            NSDictionary *titleTextAttributes =
            @{
              NSFontAttributeName : [UIFont boldSystemFontOfSize:16],
              NSForegroundColorAttributeName : [UIColor whiteColor],
              NSShadowAttributeName : shadow
              };
            fnc.navigationBar.titleTextAttributes = titleTextAttributes;

            
            fvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            fnc.tabBarItem.title = @"News Feed";
            fnc.tabBarItem.image = [UIImage imageNamed:@"tab_feed"];
            mvc.tabBarItem.title = @"More";
            mvc.tabBarItem.image = [UIImage imageNamed:@"tab_more"];
            
            UITabBarController *tabBarController = [[UITabBarController alloc] init];
            tabBarController.viewControllers = @[fnc,mvc];
            
            [self presentViewController:tabBarController animated:YES completion:nil];
            
            
        }
        
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong email or password" message:@"Please try enter your email and password again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];

        }
        

}


- (IBAction)onTab:(id)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)onEditChange:(id)sender {
    
    
   if ([self.passwordTextField.text isEqualToString:@""] || [self.emailTextField.text isEqualToString:@""]){
       self.loginButtonView.enabled = NO;
    
    }
   else{
       self.loginButtonView.enabled = YES;
   }
}





@end
