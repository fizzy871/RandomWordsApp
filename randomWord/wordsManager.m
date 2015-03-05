//
//  wordsManager.m
//  randomWord
//
//  Created by Алексей Саечников on 05.03.15.
//  Copyright (c) 2015 vironit. All rights reserved.
//

#import "wordsManager.h"

@interface wordsManager ()
@property (nonatomic, strong) NSArray *words;
@end

@implementation wordsManager
+ (wordsManager *)sharedInstance
{
    static wordsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[wordsManager alloc] init];
        [sharedInstance readFile];
        [[NSNotificationCenter defaultCenter] addObserver: sharedInstance
                                                 selector: @selector(writeFile)
                                                     name: @"didEnterBackground"
                                                   object: nil];
    });
    return sharedInstance;
}
-(void)dealloc{
    [self writeFile];
}
#pragma mark - file
-(void)readFile{
    NSString *filePath = [self filePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]){
        [[NSArray array] writeToFile:filePath atomically:YES];
    }
    self.words = [NSArray arrayWithContentsOfFile:filePath];
}
-(void)writeFile{
    NSString *filePath = [self filePath];
    [self.words writeToFile:filePath atomically:YES];
}
-(NSString*)filePath{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = array[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"words.plist"];
    return filePath;
}
#pragma mark - words
-(NSArray*)allWords{
    return self.words;
}
-(void)addWord:(NSString*)word{
    self.words = [self.words arrayByAddingObject:word];
}
-(void)removeWord:(NSString*)word{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.words];
    NSUInteger index = [array indexOfObjectPassingTest:^BOOL(NSString* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:word]){
            *stop = YES;
            return YES;
        }
        else{
            return NO;
        }
    }];
    [array removeObjectAtIndex:index];
    self.words = array;
}
-(NSString*)randomWordExceptWords:(NSArray*)exceptWords{
    NSArray *words = [self wordsArrayExceptWords:exceptWords];
    if (!words.count){
        return nil;
    }
    return words[arc4random() % [words count]];
}
-(NSArray*)wordsArrayExceptWords:(NSArray*)exceptWords{
    NSMutableArray *resultWordsArray = [NSMutableArray array];
    for (NSString *currentString in self.words){
        BOOL found = NO;
        for (NSString *currentExceptedWord in exceptWords){
            if ([currentExceptedWord isEqualToString:currentString]){
                found = YES;
                break;
            }
        }
        if (!found){
            [resultWordsArray addObject:currentString];
        }
    }
    return resultWordsArray;
}
@end
