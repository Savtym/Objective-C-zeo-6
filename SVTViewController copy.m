//
//  SVTViewController.m
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/13/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SVTViewController.h"
#import "AppDelegate.h"
#import "SVTMessage.h"

@interface SVTViewController() <NSWindowDelegate>
@property (assign) IBOutlet NSTextField *labelAlice;
@property (assign) IBOutlet NSTextField *labelBob;
@property (assign) IBOutlet NSTextView *labelHistory;
@property (assign) IBOutlet NSColorWell *colorTextAlice;
@property (assign) IBOutlet NSColorWell *colorTextBob;
@property (assign) BOOL checkBoxShowDate;
@property (assign) BOOL checkBoxDiscardStyle;
@end


NSString *const kSVTControllerKeyAlice = @"Alice";
NSString *const kSVTControllerKeyBob = @"Bob";

@implementation SVTViewController
{
@private
    NSTextField *_labelAlice;
    NSTextField *_labelBob;
    NSTextView *_labelHistory;
    NSColorWell *_colorTextAlice;
    NSColorWell *_colorTextBob;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _checkBoxShowDate = YES;
        _checkBoxDiscardStyle = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"notificationCenter" object:nil];
    }
    return self;
}

//- (instancetype)initWithSubClass:(SVTModelController *)model
//{
//    self = [self init];
//    if (self)
//    {
//        _model = model;
//    }
//    return self;
//}

- (IBAction)sendAlice:(NSButton *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss "];
    NSString *date = [[NSString alloc] initWithString:[formatter stringFromDate:[NSDate date]]];
    SVTMessage *message = [[SVTMessage alloc] initWithName:date name:kSVTControllerKeyAlice message:self.labelAlice.stringValue color:self.colorTextAlice.color];
    [self.model addMessage:message.message namePerson:message.name colorText:message.color date:message.date disableColor:self.checkBoxDiscardStyle showDate:self.checkBoxShowDate];
    [message release];
    [formatter release];
    self.labelAlice.stringValue = @"";
}

- (IBAction)sendBob:(NSButton *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss "];
    NSString *date = [[NSString alloc] initWithString:[formatter stringFromDate:[NSDate date]]];
    SVTMessage *message = [[SVTMessage alloc] initWithName:date name:kSVTControllerKeyAlice message:self.labelBob.stringValue color:self.colorTextBob.color];
    [self.model addMessage:message.message namePerson:message.name colorText:message.color date:message.date disableColor:self.checkBoxDiscardStyle showDate:self.checkBoxShowDate];
    [message release];
    [formatter release];
    self.labelBob.stringValue = @"";
    
    
    [self.labelHistory scrollRangeToVisible:NSMakeRange([[self.labelHistory string] length], 0)];
}

- (IBAction)checkBoxShowDate:(NSButton *)sender
{
    if ([sender state] == NSOnState)
    {
        self.checkBoxShowDate = YES;
    }
    else
    {
        self.checkBoxShowDate = NO;
    }
    [self.model textMessage:self.checkBoxDiscardStyle date:self.checkBoxShowDate];
}

- (IBAction)checkBoxDiscardStyle:(NSButton *)sender
{
    if ([sender state] == NSOnState)
    {
        self.checkBoxDiscardStyle = YES;
    }
    else
    {
        self.checkBoxDiscardStyle = NO;
    }
    [self.model textMessage:self.checkBoxDiscardStyle date:self.checkBoxShowDate];
}

- (void)receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"notificationCenter"])
    {
        [self.labelHistory.textStorage appendAttributedString:self.model.messages];
    }
}

- (void)awakeFromNib
{
    [self.labelHistory.textStorage appendAttributedString:self.model.messages];
}

//- (void)windowWillClose:(NSNotification *)notification
//{
//    [self.model writeToFilePath];
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (NSTextField *)labelAlice
{
    return _labelAlice;
}

- (void)setLabelAlice:(NSTextField *)aLabelAlice
{
    _labelAlice = aLabelAlice;
}

- (NSTextField *)getlabelBob
{
    return _labelBob;
}

- (NSTextView *)getlabelHistory
{
    return _labelHistory;
}

- (NSColorWell *)colorTextBob
{
    return _colorTextBob;
}

- (void)setColorTextBob:(NSColorWell *)aColorTextBob
{
    _colorTextBob = aColorTextBob;
}

- (NSColorWell *)colorTextAlice
{
    return _colorTextAlice;
}

- (void)setColorTextAlice:(NSColorWell *)aColorTextAlice
{
    _colorTextAlice = aColorTextAlice;
}

@end
