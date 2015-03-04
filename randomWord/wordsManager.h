//
//  wordsManager.h
//  randomWord
//
//  Created by Алексей Саечников on 05.03.15.
//  Copyright (c) 2015 vironit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wordsManager : NSObject
+ (wordsManager *)sharedInstance;
-(void)addWord:(NSString*)word;
-(void)removeWord:(NSString*)word;
-(NSArray*)allWords;
-(NSString*)randomWordExceptWords:(NSArray*)exceptWords;
-(void)writeFile;
@end
