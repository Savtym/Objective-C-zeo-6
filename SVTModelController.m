//
//  SVTModelController.m
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/16/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import "SVTModelController.h"
#import "SVTModelController+SVTModelControllerSerialization.h"

@interface SVTModelController()
@property (readwrite, copy) NSAttributedString *messages;
@property (readwrite) NSMutableArray<NSAttributedString *> *mHistory;
@property (readwrite) NSMutableArray<NSDate *> *mHistoryDate;
@property (readwrite) NSMutableArray<NSColor *> *mAttributes;
@end

@implementation SVTModelController
{
@private
    NSAttributedString *_messages;
    NSMutableArray<NSAttributedString *> *_mHistory;
    NSMutableArray<NSDate *> *_mHistoryDate;
    NSMutableArray<NSColor *> *_mAttributes;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _messages = [[NSAttributedString alloc] init];
        _mHistory = [[NSMutableArray alloc] init];
        _mHistoryDate = [[NSMutableArray alloc] init];
        _mAttributes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSMutableArray<NSAttributedString *> *)aHistory historyDate:(NSMutableArray<NSDate *> *)aHistoryDate attributes:(NSMutableArray<NSColor *> *)anAttributes
{
    self = [self init];
    if (self)
    {
        _mHistory = [aHistory mutableCopy];
        _mHistoryDate = [aHistoryDate mutableCopy];
        _mAttributes = [anAttributes mutableCopy];
    }
    return self;
}

- (void)checkBoxChange:(BOOL)aColorBlack date:(BOOL)aDate
{
    NSMutableAttributedString *bufString = [[[NSMutableAttributedString alloc] init] autorelease];
    NSUInteger i = 0;
    for (NSMutableAttributedString *iCur in self.history)
    {
        if (aDate)
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm:ss "];
            NSAttributedString *date = [[NSAttributedString alloc] initWithString:[formatter stringFromDate:self.historyDate[i]]];
            [bufString appendAttributedString:date];
            [date release];
            [formatter release];
        }
        if (aColorBlack)
        {
            [iCur addAttribute:NSForegroundColorAttributeName value:[NSColor blackColor] range:NSMakeRange(0, iCur.length)];
        }
        else
        {
            [iCur addAttribute:NSForegroundColorAttributeName value: self.attributes[i] range:NSMakeRange(0, iCur.length)];
        }
        [bufString appendAttributedString:iCur];
        i++;
    }
    self.messages = bufString;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SVTModelControllerXibChange" object:self];
}

- (void)addMessage:(NSString *)aText namePerson:(NSString *)aPerson colorText:(NSColor *)aColor date:(NSDate *)aDate disableColor:(BOOL)aColorBlack showDate:(BOOL)showDate
{
    if (![aText isEqualToString:@""])
    {
        
        NSMutableAttributedString *messageWithColor = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@\n", aPerson, aText] attributes:@{NSForegroundColorAttributeName: aColor}];
        
        [self.mHistoryDate addObject:aDate];
        [self.mHistory addObject:messageWithColor];
        [self.mAttributes addObject:aColor];

        [messageWithColor release];
        
        [self checkBoxChange:aColorBlack date:showDate];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SVTModelControllerXibChange" object:self];
}

- (void)writeToFilePath:(NSString *)aPath
{
    NSDictionary *dict = [self dictionaryRepresentation];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[myString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:aPath atomically:NO];
    [myString release];
}

- (instancetype)initWithFilePath:(NSString *)aPath
{
    NSError *error = nil;
    NSString *stringFromFileAtPath = [[NSString alloc] initWithContentsOfFile:aPath encoding:NSUTF8StringEncoding error:&error];
    
    if(!stringFromFileAtPath)
    {
        NSLog(@"initWithFilePath: error: %@", error.localizedDescription);
        stringFromFileAtPath = @"{}";
    }
    NSData *data = [stringFromFileAtPath dataUsingEncoding:NSUTF8StringEncoding];
    [stringFromFileAtPath release];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    return [self initWithDictionaryRepresentation:dictionary];
}

- (NSArray<NSDate *> *)historyDate
{
    return (NSArray *)_mHistoryDate;
}

- (NSArray<NSAttributedString *> *)history
{
    return (NSArray *)_mHistory;
}

- (NSArray<NSColor *> *)attributes
{
    return (NSArray *)_mAttributes;
}

- (NSAttributedString *)messages
{
    return _messages;
}

- (void)setMessages:(NSAttributedString *)messages
{
    if (_messages != messages)
    {
        [_messages release];
        _messages = [messages copy];
    }
}

- (void)dealloc
{
    [_messages release];
    [_mHistory release];
    [_mHistoryDate release];
    [_mAttributes release];
    [super dealloc];
}

@end
