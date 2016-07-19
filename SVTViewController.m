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
@property (assign, nonatomic) IBOutlet NSTextView *labelHistory;
@property (assign, nonatomic) IBOutlet NSTextField *labelAlice;
@property (assign, nonatomic) IBOutlet NSTextField *labelBob;
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
    BOOL _checkBoxShowDate;
    BOOL _checkBoxDiscardStyle;
}

- (instancetype)init
{
    self = [super initWithNibName:@"SVTViewController" bundle:nil];
    if (self)
    {
        _checkBoxShowDate = YES;
        _checkBoxDiscardStyle = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"SVTModelControllerXibChange" object:nil];
    }
    return self;
}

- (IBAction)sendAlice:(NSButton *)sender
{
    SVTMessage *message = [[SVTMessage alloc] initWithName:[NSDate date] name:kSVTControllerKeyAlice message:self.labelAlice.stringValue color:self.colorTextAlice.color];
    [self.model addMessage:message.message namePerson:message.name colorText:message.color date:message.date disableColor:self.checkBoxDiscardStyle showDate:self.checkBoxShowDate];
    [message release];
    self.labelAlice.stringValue = @"";
}

- (IBAction)sendBob:(NSButton *)sender
{
    SVTMessage *message = [[SVTMessage alloc] initWithName:[NSDate date] name:kSVTControllerKeyBob message:self.labelBob.stringValue color:self.colorTextBob.color];
    [self.model addMessage:message.message namePerson:message.name colorText:message.color date:message.date disableColor:self.checkBoxDiscardStyle showDate:self.checkBoxShowDate];
    [message release];
    self.labelBob.stringValue = @"";
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
    [self.model checkBoxChange:self.checkBoxDiscardStyle date:self.checkBoxShowDate];
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
    [self.model checkBoxChange:self.checkBoxDiscardStyle date:self.checkBoxShowDate];
}

- (void)receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"SVTModelControllerXibChange"])
    {
        if (self.model.messages)
        {
            [self.labelHistory setString:@""];
            [self.labelHistory.textStorage appendAttributedString:self.model.messages];
            [self.labelHistory scrollRangeToVisible:NSMakeRange([[self.labelHistory string] length], 0)];
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (NSTextView *)labelHistory
{
    return _labelHistory;
}

- (NSTextField *)labelAlice
{
    return _labelAlice;
}

- (NSTextField *)labelBob
{
    return _labelBob;
}

- (NSColorWell *)colorTextBob
{
    return _colorTextBob;
}

- (NSColorWell *)colorTextAlice
{
    return _colorTextAlice;
}

- (BOOL)checkBoxShowDate
{
    return _checkBoxShowDate;
}

- (BOOL)checkBoxDiscardStyle
{
    return _checkBoxDiscardStyle;
}

- (void)setLabelHistory:(NSTextView *)aLabelHistory
{
    _labelHistory = aLabelHistory;
}

- (void)setLabelAlice:(NSTextField *)aLabelAlice
{
    _labelAlice = aLabelAlice;
}

- (void)setLabelBob:(NSTextField *)aLabelBob
{
    _labelBob = aLabelBob;
}

- (void)setColorTextBob:(NSColorWell *)aColorTextBob
{
    _colorTextBob = aColorTextBob;
}

- (void)setColorTextAlice:(NSColorWell *)aColorTextAlice
{
    _colorTextAlice = aColorTextAlice;
}

- (void)setCheckBoxShowDate:(BOOL)aCheckBoxShowDate
{
    _checkBoxShowDate = aCheckBoxShowDate;
}

- (void)setCheckBoxDiscardStyle:(BOOL)aCheckBoxDiscardStyle
{
    _checkBoxDiscardStyle = aCheckBoxDiscardStyle;
}

@end
