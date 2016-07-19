//
//  SVTMessage.m
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/17/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import "SVTMessage.h"

@implementation SVTMessage
{
@private
    NSDate *_date;
    NSString *_name;
    NSString *_message;
    NSColor *_color;
}

- (instancetype)initWithName:(NSDate *)date name:(NSString *)name message:(NSString *)message color:(NSColor *)color
{
    self = [self init];
    if (self)
    {
        _date = [date copy];
        _name = [name copy];
        _message = [message copy];
        _color = [color retain];
    }
    return self;
}

- (void)dealloc
{
    [_date release];
    [_name release];
    [_message release];
    [_color release];
    [super dealloc];
}

- (NSDate *)date
{
    return _date;
}

- (NSString *)name
{
    return _name;
}

- (NSString *)message
{
    return _message;
}

- (NSColor *)color
{
    return _color;
}

@end
