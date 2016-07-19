//
//  SVTModelController+SVTModelControllerSerialization.h
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/18/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVTModelController.h"

@interface SVTModelController(SVTModelControllerSerilization)

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;
- (NSDictionary *)dictionaryRepresentation;

@end
