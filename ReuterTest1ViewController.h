//
//  ReuterTest1ViewController.h
//  ReuterTest1
//
//  Created by Sven Reuter on 29.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>


@interface ReuterTest1ViewController : UIViewController {
	
	MPMoviePlayerController *moviePlayer;
	UIView *movieView;
	UIButton *movieButton;
	UILabel *timeLabel;
	UIButton *extraButton;
	UITextView *extraTextView;
	UIImageView *extraImageView;
	AVPlayer *extraPlayer;
	UIView *extraPlayerView;
	
}

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (nonatomic, retain) IBOutlet UIView *movieView;
@property (nonatomic, retain) IBOutlet UIButton *movieButton;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UIButton *extraButton;
@property (nonatomic, retain) IBOutlet UITextView *extraTextView;
@property (nonatomic, retain) IBOutlet UIImageView *extraImageView;
@property (nonatomic, retain) AVPlayer *extraPlayer;
@property (nonatomic, retain) IBOutlet UIView *extraPlayerView;



-(NSURL *)movieURL;
-(IBAction)playExtra:(id)sender;
-(IBAction)playMovie:(id)sender;
-(IBAction)getInfo:(id)sender;

@end

