//
//  AllWordsViewController.m
//  randomWord
//
//  Created by Алексей Саечников on 05.03.15.
//  Copyright (c) 2015 vironit. All rights reserved.
//

#import "AllWordsViewController.h"
#import "wordsManager.h"

@interface AllWordsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSArray *words;
@end

@implementation AllWordsViewController

-(void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    self.words = [[wordsManager sharedInstance] allWords];
}
#pragma mark - keyboard appearance
-(void)keyboardWillHide:(NSNotification*)notification{
    self.scrollViewBottomConstraint.constant = 0;
    [self.view layoutIfNeeded];
}
-(void)keyboardWillShow:(NSNotification*)notification{
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.scrollViewBottomConstraint.constant = CGRectGetHeight(frame);
    [self.view layoutIfNeeded];
}
#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.words.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.words[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [[wordsManager sharedInstance] removeWord:self.words[indexPath.row]];
        [[wordsManager sharedInstance] writeFile];
        self.words = [[wordsManager sharedInstance] allWords];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]){
        [[wordsManager sharedInstance] addWord:textField.text];
        [[wordsManager sharedInstance] writeFile];
        self.words = [[wordsManager sharedInstance] allWords];
        [self.tableView reloadData];
        textField.text = @"";
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}


@end
