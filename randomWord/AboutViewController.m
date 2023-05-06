//
//  AboutViewController.m
//  randomWord
//
//  Created by Алексей Саечников on 07.03.15.
//  Copyright (c) 2015 vironit. All rights reserved.
//

#import "AboutViewController.h"
#import <MessageUI/MessageUI.h>

#define RGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface AboutViewController ()<MFMailComposeViewControllerDelegate>
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation AboutViewController

-(void)viewDidAppear:(BOOL)animated{
    NSString *placeholderString = @"<p align=\"center\" style=\"margin: 0px; font-size: 14px; font-family: 'Helvetica Neue Light';\">&nbsp;</p>\
    <p align=\"center\" style=\"margin: 0px; font-size: 14px; font-family: 'Helvetica Neue Light';\">&nbsp;</p>\
    <p align=\"center\" style=\"margin: 0px; font-size: 14px; font-family: 'Helvetica Neue Light';\">&nbsp;</p>\
    <p align=\"center\" style=\"margin: 0px; font-size: 14px; font-family: 'Helvetica Neue Light';\"><font size=\"4\">Random Words</font></p>\
    <p align=\"center\" style=\"margin: 0px; font-size: 14px; font-family: 'Helvetica Neue UltraLight';\"><font size=\"4\">by Saechnikov Alexey</font></p>\
    <p align=\"center\" style=\"margin: 0px; font-size: 14px; font-family: 'Helvetica Neue UltraLight';\"><font size=\"4\">march, 2015</font></p>\
    ";
    [self.webView loadHTMLString:placeholderString baseURL:nil];
}

-(IBAction)sendFeedBack:(id)sender{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mcController = [[MFMailComposeViewController alloc] init];
        mcController.navigationBar.tintColor = RGB(235., 106., 106.);
        mcController.mailComposeDelegate = self;
        [mcController setSubject:@"RandomWords feedback"];
        [mcController setToRecipients:@[@"fizzy871@gmail.com"]];
        [self presentViewController:mcController animated:YES completion:nil];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error){
        [[[UIAlertView alloc] initWithTitle:nil message:@"can't send feedback" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else if (result == MFMailComposeResultSent){
        [self dismissViewControllerAnimated:YES completion:nil];
        [[[UIAlertView alloc] initWithTitle:nil message:@"thank you for your feedback" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
