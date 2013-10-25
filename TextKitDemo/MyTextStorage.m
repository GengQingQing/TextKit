//
//  MyTextStorage.m
//  TextKitDemo
//
//  Created by minjie on 13-10-25.
//  Copyright (c) 2013年 minjie. All rights reserved.
//

#import "MyTextStorage.h"

NSString *const DefaultTokenName = @"DefaultTokenName";

@implementation MyTextStorage
{
    NSMutableAttributedString *_imp;
    BOOL _dynamicTextNeedsUpdate;
    NSInteger editCount;
}

- (id)init
{
	self = [super init];
	
	if (self) {
		_imp = [NSMutableAttributedString new];
	}
	
	return self;
}


#pragma mark - Reading Text

- (NSString *)string
{
	return _imp.string;
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
	return [_imp attributesAtIndex:location effectiveRange:range];
}

#pragma mark - Text Editing

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
	[self beginEditing];
    [_imp replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters|NSTextStorageEditedAttributes range:range changeInLength:str.length - range.length];
    _dynamicTextNeedsUpdate = YES;
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
	[self beginEditing];
    [_imp setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}


#pragma mark - Syntax highlighting

- (void)processEditing
{
	if(_dynamicTextNeedsUpdate)
    {
        _dynamicTextNeedsUpdate = NO;
        [self performReplacementsForCharacterChangeInRange:[self editedRange]];
    }
    [super processEditing];
}

- (void)performReplacementsForCharacterChangeInRange:(NSRange)changedRange
{
    NSRange extendedRange = NSUnionRange(changedRange, [[_imp string] lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [[_imp string] lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    
    [self applyTokenAttributesToRange:extendedRange];
}

- (void)applyTokenAttributesToRange:(NSRange)searchRange
{
    NSDictionary *defaultAttributes = [self.tokens objectForKey:DefaultTokenName];
    
    [[_imp string] enumerateSubstringsInRange:searchRange options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        NSDictionary *attributesForToken = [self.tokens objectForKey:substring];
        if(!attributesForToken)
            attributesForToken = defaultAttributes;
        
        if(attributesForToken)
            [self addAttributes:attributesForToken range:substringRange];
    }];
}


@end
