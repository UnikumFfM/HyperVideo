//
//  Szenario1ViewController.h
//  Szenario1
//
//  Created by Sven Reuter on 13.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "JSON.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>


@interface Szenario1ViewController : UIViewController {
	
	UIView *viewForMovie;
	UIButton *buttonToStartMovie;
	UITextView *additionTextView;
	AVPlayer *extraPlayer;	
	UIImageView *additionImageView;
	UIView *additionVideoView;
	MPMoviePlayerController *moviePlayer;
	UIButton *buttonForAddition;
	NSString *JSONText;
	NSError *error;
	int elemente;


}

@property (nonatomic, retain) IBOutlet UIView *viewForMovie;
@property (nonatomic, retain) IBOutlet UIButton *buttonToStartMovie;
@property (nonatomic, retain) IBOutlet UITextView *additionTextView;
@property (nonatomic, retain) IBOutlet UIView *additionVideoView;
@property (nonatomic, retain) IBOutlet UIImageView *additionImageView;
@property (nonatomic, retain) AVPlayer *extraPlayer;
@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (nonatomic, retain) UIButton *buttonForAddition;
@property (nonatomic, retain) NSString *JSONText;
@property (nonatomic, retain) NSError *error;


/* Methoden mit IBActions */
-(IBAction)playMovie:(id)sender;

/* Methoden ohne Rückgabewert */
-(void) loadButtonWithTag:(int)tag Image:(NSString *)image x:(int)x y:(int)y;
-(void) loadButtonsFor:(NSString *)text;
-(void) doButtonWithTag:(int)x;
-(void) undoButtonWithTag:(int)x;

/* Methoden mit dem Rückgabewert eines Integer */
-(int) anzeigeFuer:(NSString *)text at:(int)position;
-(int) anzahlElementeFor:(NSString *)text;

/* Methoden mit anderen Rückgabewerten */
-(NSURL *) movieURL;
-(NSArray *) valueWithKey:(NSString *)key atPosition:(int)x;


@end

