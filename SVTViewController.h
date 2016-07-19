//
//  SVTController.h
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/13/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "SVTModelController.h"

@interface SVTViewController : NSViewController
@property (readwrite, retain) SVTModelController *model;
@end