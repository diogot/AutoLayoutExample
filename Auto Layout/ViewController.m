//
//  ViewController.m
//  Auto Layout
//
//  Created by Diogo Tridapalli on 5/13/15.
//  Copyright (c) 2015 Diogo Tridapalli. All rights reserved.
//

#import "ViewController.h"
#import "CodeViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (IBAction)pushNextController:(id)sender {
    CodeViewController *controller = [CodeViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Keyboard handling

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self observeKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopObservingKeyboardNotifications];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)observeKeyboardNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillChangeFrameNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
}

- (void)stopObservingKeyboardNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    UIView *view = self.view;
    
    NSDictionary* info = [notification userInfo];
    CGRect keyboardFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrame = [view convertRect:keyboardFrame fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(keyboardFrame), 0);
    UIScrollView *scrollView = self.scrollView;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect viewFrame = view.frame;
    viewFrame.size.height -= keyboardFrame.size.height;
    
    NSTimeInterval duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSUInteger animationCurve = [info[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    CGRect textFieldFrame = self.textField.frame;
    if (!CGRectContainsPoint(viewFrame, textFieldFrame.origin)) {
        [UIView animateWithDuration:duration
                              delay:0
                            options:animationCurve
                         animations:^{
                             [scrollView scrollRectToVisible:textFieldFrame
                                                    animated:YES];
                         } completion:nil];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIScrollView *scrollView = self.scrollView;
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

@end
