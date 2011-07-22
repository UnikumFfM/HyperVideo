//
//  Szenario1AppDelegate.h
//  Szenario1
//
//  Created by Sven Reuter on 13.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Szenario1ViewController;

@interface Szenario1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Szenario1ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Szenario1ViewController *viewController;

@end

