//
//  SVTMessage.h
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/17/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SVTMessage : NSObject

@property(readonly, copy) NSDate *date;
@property(readonly, copy) NSString *name;
@property(readonly, copy) NSString *message;
@property(readonly, retain) NSColor *color;

- (instancetype)initWithName:(NSDate *)date name:(NSString *)name message:(NSString *)message color:(NSColor *)color;

@end
