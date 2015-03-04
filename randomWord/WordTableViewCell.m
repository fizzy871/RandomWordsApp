//
//  WordTableViewCell.m
//  randomWord
//
//  Created by Алексей Саечников on 05.03.15.
//  Copyright (c) 2015 vironit. All rights reserved.
//

#import "WordTableViewCell.h"

@implementation WordTableViewCell

-(void)prepareForReuse{
    self.wordLabel.text = nil;
}

@end
