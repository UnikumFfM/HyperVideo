//
//  Hypervideo_Szenario2ViewController.h
//  Hypervideo_Szenario2
//
//  Created by Sven Reuter on 26.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Hypervideo_Szenario2ViewController : UIViewController {
	
	MPMoviePlayerController *moviePlayer;
	UIView *movieView;
	UIButton *moviePlayButton;
	UIButton *textSubmitButton;
	UITextField *textTextField;

}

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (nonatomic, retain) IBOutlet UIView *movieView;
@property (nonatomic, retain) IBOutlet UIButton *moviePlayButton;
@property (nonatomic, retain) IBOutlet UIButton *textSubmitButton;
@property (nonatomic, retain) IBOutlet UITextField *textTextField;

-(NSURL *)movieURL;
-(IBAction)playMovie:(id)sender;
-(IBAction)submitText:(id)sender;


@end

