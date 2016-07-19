//
//  AppDelegate.m
//  Exercise5
//
//  Created by Тимофей Савицкий on 7/13/16.
//  Copyright © 2016 Тимофей Савицкий. All rights reserved.
//

#import "AppDelegate.h"
#import "SVTModelController.h"
#import "SVTViewController.h"

@interface AppDelegate ()
@property (assign) IBOutlet NSWindow *window;
@property (retain) SVTViewController *view;
@property (retain) SVTModelController *model;
@end

NSString *const kSVTControllerKeyPath = @"/Users/savtym/Documents/obj c/Exercise5/history";

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    SVTModelController *model = [[SVTModelController alloc] initWithFilePath:kSVTControllerKeyPath];
    self.model = model;
    SVTViewController *controller = [[SVTViewController alloc] init];
    [self.window.contentView addSubview:controller.view];
    self.view = controller;
    [self.view setModel:self.model];
    [controller release];
    [model release];
    [self.model checkBoxChange:YES date:YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [self.model writeToFilePath:kSVTControllerKeyPath];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
