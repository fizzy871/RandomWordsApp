//
//  RandomWordsViewController.m
//  randomWord
//
//  Created by Алексей Саечников on 05.03.15.
//  Copyright (c) 2015 vironit. All rights reserved.
//

#import "RandomWordsViewController.h"
#import "WordTableViewCell.h"
#import "wordsManager.h"

@interface RandomWordsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (nonatomic, weak) IBOutlet UILabel *placeholderTextLabel;
@property (nonatomic, strong) NSMutableArray *words;
@end

@implementation RandomWordsViewController
-(void)updateConsts{
    self.tableViewHeightConstraint.constant = 68*self.words.count;
    [self.view setNeedsUpdateConstraints];
    self.placeholderTextLabel.hidden = self.words.count;
    [self.view updateConstraintsIfNeeded];
}
-(void)viewWillAppear:(BOOL)animated{
    [self updateConsts];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}
#pragma mark - getters/setters
-(NSMutableArray *)words{
    if (!_words){
        _words = [NSMutableArray array];
    }
    return _words;
}
#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.words.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.wordLabel.text = self.words[indexPath.row];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.words removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self updateConsts];
    }
}

#pragma mark - actions
-(IBAction)addWord:(id)sender{
    NSString *objectToInsert = [[wordsManager sharedInstance] randomWordExceptWords:self.words];
    if (!objectToInsert){
        [[[UIAlertView alloc] initWithTitle:nil message:@"слова закончились" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }
    [self.words addObject:objectToInsert];
    [self.tableView insertRowsAtIndexPaths:@[
                                             [NSIndexPath indexPathForRow:self.words.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self updateConsts];
}
-(IBAction)removeAll:(id)sender{
    [self.words removeAllObjects];
    [self.tableView reloadData];
    [self updateConsts];
}
@end
