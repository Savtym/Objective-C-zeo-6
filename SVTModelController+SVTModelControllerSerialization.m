//
//  SVTModelController+SVTModelControllerSerialization.m
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/18/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import "SVTModelController+SVTModelControllerSerialization.h"

@implementation SVTModelController(SVTModelControllerSerilization)

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
    NSMutableArray *history = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *historyDate = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *attributes = [[[NSMutableArray alloc] init] autorelease];
        for (NSUInteger iCur = 0; iCur < [[aDictionary objectForKey:@"colors"] count]; iCur++)
        {
            double bufDate = [aDictionary[@"dates"][iCur][@"date"] integerValue];
            [historyDate addObject:[NSDate dateWithTimeIntervalSince1970:bufDate]];
  
            unsigned int colorCode = 0;
            if (aDictionary[@"colors"][iCur])
            {
                NSScanner *scanner = [NSScanner scannerWithString:aDictionary[@"colors"][iCur][@"color"]];
                (void)[scanner scanHexInt:&colorCode];
            }
            [attributes addObject:[NSColor colorWithDeviceRed:((colorCode>>16)&0xFF)/255.0 green:((colorCode>>8)&0xFF)/255.0 blue:((colorCode)&0xFF)/255.0 alpha:1.0]];
            NSMutableAttributedString *bufMessage = [[NSMutableAttributedString alloc] initWithString: aDictionary[@"messages"][iCur][@"message"] attributes:@{NSForegroundColorAttributeName: attributes[iCur]}];
            [history addObject:bufMessage];
            [bufMessage release];
        }
    return [self initWithDictionary:history historyDate:historyDate attributes:attributes];
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    if (self.historyDate)
    {
        NSMutableArray *bufResult = [[NSMutableArray alloc] init];
        for (NSDate *iCur in self.historyDate)
        {
            NSTimeInterval start = [iCur timeIntervalSince1970];
            [bufResult addObject:@{@"date" : @(start)}];
        }
        result [@"dates"] = bufResult;
        [bufResult release];
    }
    if (self.history)
    {
        NSMutableArray *bufResult = [[NSMutableArray alloc] init];
        for (NSAttributedString *iCur in self.history)
        {
            [bufResult addObject: @{@"message" : iCur.string}];
        }
        result [@"messages"] = bufResult;
        [bufResult release];
    }
    if (self.attributes)
    {
        NSMutableArray *bufResult = [[NSMutableArray alloc] init];
        for (NSColor *iCur in self.attributes)
        {
            
            NSString* hexString = [NSString stringWithFormat:@"%02X%02X%02X", (int) (iCur.redComponent * 0xFF), (int) (iCur.greenComponent * 0xFF), (int) (iCur.blueComponent * 0xFF)];
            [bufResult addObject: @{@"color" : hexString}];
        }
        result [@"colors"] = bufResult;
        [bufResult release];
        
    }
    return result;
}

@end
