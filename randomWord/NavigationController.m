//
//  NavigationController.m
//  randomWords
//
//  Created by Alexey Saechnikov on 06.05.23.
//  Copyright © 2023 vironit. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)awakeFromNib {
    [super awakeFromNib];
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [appearance setBackgroundColor:[UIColor colorNamed:@"applicationColor"]];
        [appearance setBackIndicatorImage:[UIImage imageNamed:@"back"] transitionMaskImage:[UIImage imageNamed:@"back"]];
        UIBarButtonItemAppearance *backButtonAppearance = [[UIBarButtonItemAppearance alloc] init];
        [[backButtonAppearance normal] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}];
        [appearance setBackButtonAppearance:backButtonAppearance];
        [[self navigationBar] setStandardAppearance:appearance];
        [[self navigationBar] setScrollEdgeAppearance:appearance];
        if (@available(iOS 15.0, *)) {
            [[self navigationBar] setCompactScrollEdgeAppearance:appearance];
        }
    }
}

@end
