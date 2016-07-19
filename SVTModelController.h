//
//  SVTModelController.h
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/16/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SVTModelController : NSObject

- (void)addMessage:(NSString *)aText namePerson:(NSString *)aPerson colorText:(NSColor *)aColor date:(NSDate *)aDate disableColor:(BOOL)aColorBlack showDate:(BOOL)showDate;

- (void)checkBoxChange:(BOOL)aColorBlack date:(BOOL)aDate;
- (void)writeToFilePath:(NSString *)aPath;

- (instancetype)initWithFilePath:(NSString *)aPath;
- (instancetype)initWithDictionary:(NSMutableArray<NSAttributedString *> *)aHistory historyDate:(NSMutableArray<NSDate *> *)aHistoryDate attributes:(NSMutableArray<NSColor *> *)anAttributes;

@property (readonly) NSArray<NSAttributedString *> *history;
@property (readonly) NSArray<NSDate *> *historyDate;
@property (readonly) NSArray<NSColor *> *attributes;
@property (readonly) NSAttributedString *messages;
@end