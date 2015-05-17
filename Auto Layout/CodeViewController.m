//
//  CodeViewController.m
//  Auto Layout
//
//  Created by Diogo Tridapalli on 5/13/15.
//  Copyright (c) 2015 Diogo Tridapalli. All rights reserved.
//

#import "CodeViewController.h"

@interface CodeViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


@implementation CodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Code";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // This code should be on a custom view, it's here only to
    // pedagogical reasons
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *contentView = [self createView];
    [scrollView addSubview:contentView];
    
    UILabel *title = [UILabel new];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    title.text = @"My Great View";
    [contentView addSubview:title];
    
    UIView *verticalSpace1 = [self createView];
    [contentView addSubview:verticalSpace1];

    UIView *colorViews = [self colorViews];
    [contentView addSubview:colorViews];
    
    UIView *verticalSpace2 = [self createView];
    [contentView addSubview:verticalSpace2];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"Log something" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    
    UIView *verticalSpace3 = [self createView];
    [contentView addSubview:verticalSpace3];

    UITextField *textField = [UITextField new];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    self.textField = textField;
    [contentView addSubview:textField];
    
    UIView *verticalSpace4 = [self createView];
    [contentView addSubview:verticalSpace4];
    
    //
    // Layout code
    //
    NSDictionary *views = NSDictionaryOfVariableBindings(scrollView,
                                                         contentView,
                                                         title,
                                                         verticalSpace1,
                                                         colorViews,
                                                         verticalSpace2,
                                                         button,
                                                         verticalSpace3,
                                                         textField,
                                                         verticalSpace4);
    
    NSDictionary *metrics = @{@"topSpace": @(90),
                              @"zero": @(0),
                              @"textFieldMinWidth": @(150)};
    
    // scrollView
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    // contentView
    [scrollView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                             options:NSLayoutFormatAlignAllCenterX |NSLayoutFormatAlignAllCenterY
                                             metrics:nil
                                               views:views]];
    [scrollView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:contentView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:1
                                   constant:0]];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:contentView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1
                                   constant:0]];
    
    // other views
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpace-[title][verticalSpace1][colorViews][verticalSpace2(==verticalSpace1)][button][verticalSpace3(==verticalSpace1)][textField][verticalSpace4(==verticalSpace1)]|"
                                             options:NSLayoutFormatAlignAllCenterX
                                             metrics:metrics
                                               views:views]];

    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[colorViews]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[verticalSpace1(zero)]"
                                             options:0
                                             metrics:metrics
                                               views:views]];
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[verticalSpace2(==verticalSpace1)]"
                                             options:0
                                             metrics:metrics
                                               views:views]];
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[verticalSpace3(==verticalSpace1)]"
                                             options:0
                                             metrics:metrics
                                               views:views]];
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[verticalSpace4(==verticalSpace1)]"
                                             options:0
                                             metrics:metrics
                                               views:views]];

    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[textField(>=textFieldMinWidth)]"
                                             options:0
                                             metrics:metrics
                                               views:views]];
}

- (UIView *)createView
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    return view;
}

- (UIView *)colorViews
{
    UIView *colorView = [self createView];
    
    UIView *red = [self createView];
    red.backgroundColor = [UIColor redColor];
    [colorView addSubview:red];
    
    UIView *green = [self createView];
    green.backgroundColor = [UIColor greenColor];
    [colorView addSubview:green];
    
    UIView *blue = [self createView];
    blue.backgroundColor = [UIColor blueColor];
    [colorView addSubview:blue];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(red, green, blue);
    NSDictionary *metrics = @{@"hSpace": @(50),
                              @"size": @(50)};
    
    NSArray *horizontalConstraits =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[red(==green)]-hSpace-[green(size)]-hSpace-[blue(==green)]"
                                            options:NSLayoutFormatAlignAllCenterY
                                            metrics:metrics
                                              views:views];
    [colorView addConstraints:horizontalConstraits];

    [colorView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[green(size)]|"
                                             options:0
                                             metrics:metrics
                                               views:views]];
    
    [colorView addConstraint:
     [NSLayoutConstraint constraintWithItem:green
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:colorView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0]];
    
    [colorView addConstraint:
     [NSLayoutConstraint constraintWithItem:red
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:green
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:1
                                   constant:0]];
    [colorView addConstraint:
     [NSLayoutConstraint constraintWithItem:red
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:green
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];

    [colorView addConstraint:
     [NSLayoutConstraint constraintWithItem:blue
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:green
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:1
                                   constant:0]];
    [colorView addConstraint:
     [NSLayoutConstraint constraintWithItem:blue
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:green
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];

    
    return colorView;
}



- (IBAction)buttonPressed:(id)sender
{
    NSLog(@"button pressed");
}

#pragma mark - Keyboard handling

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
