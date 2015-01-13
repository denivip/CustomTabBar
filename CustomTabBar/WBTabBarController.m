//
//  WBTabBarController.m
//  CustomTabBar
//
//  Created by Tito Ciuro on 4/21/12.
//
// Copyright (c) 2012 Webbo, L.L.C. All rights reserved.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "WBTabBarController.h"

@interface WBTabBarController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation WBTabBarController

@synthesize plusController;
@synthesize centerButton;

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

    [self addCenterButtonWithImage:[UIImage imageNamed:@"centerButton"] highlightImage:[UIImage imageNamed:@"centerButton_h"] target:self action:@selector(buttonPressed:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Create a custom UIButton and add it to the center of our tab bar
- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGPoint center = self.tabBar.center;
    center.y = CGRectGetHeight(self.view.frame) - buttonImage.size.height/2.0 - 20;
    button.center = center;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [UILabel new];
    label.text = NSLocalizedString(@"New B.EAT", nil);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12.f];
    [label sizeToFit];

    center = self.tabBar.center;
    center.y = CGRectGetHeight(self.view.frame) - label.frame.size.height/2;
    label.center = center;
    [self.view addSubview:button];
   self.centerButton = button;

    [self.view addSubview:label];
}

- (void)buttonPressed:(id)sender
{
    [self setSelectedIndex:2];
    [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
}

- (void)doHighlight:(UIButton*)b {
    [self takePhoto:b];
//    [b setHighlighted:YES];
}

- (void)doNotHighlight:(UIButton*)b {
    [b setHighlighted:NO];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(self.tabBarController.selectedIndex != 2){
        [self performSelector:@selector(doNotHighlight:) withObject:centerButton afterDelay:0];
    }
}

- (BOOL)tabBarHidden {
    return self.centerButton.hidden && self.tabBar.hidden;
}

- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    self.centerButton.hidden = tabBarHidden;
    self.tabBar.hidden = tabBarHidden;
}


- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    .image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
