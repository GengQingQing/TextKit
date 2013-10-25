//
//  MyTextStorage.h
//  TextKitDemo
//
//  Created by minjie on 13-10-25.
//  Copyright (c) 2013年 minjie. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *const DefaultTokenName;
@interface MyTextStorage : NSTextStorage
@property (nonatomic, copy) NSDictionary *tokens;
@end
