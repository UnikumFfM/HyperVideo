//
//  ReuterTest1ViewController.m
//  ReuterTest1
//
//  Created by Sven Reuter on 29.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReuterTest1ViewController.h"

@implementation ReuterTest1ViewController

@synthesize moviePlayer;
@synthesize movieView;
@synthesize movieButton;
@synthesize timeLabel;
@synthesize extraButton;
@synthesize extraTextView;
@synthesize extraImageView;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// ein Timer für die Methode "starteAnzeige" damit diese Methode jederzeit abgefragt wird
	[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(starteAnzeige:) userInfo:nil repeats:YES];
	
	// Notifications, um das Video vollständig geladen zu haben, bevor man es verwendet (wichtig später für Streams)
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(movieDurationAvailable:)
	 name:MPMovieDurationAvailableNotification
	 object:nil];
}



//Zusatzinformation aufrufen durch Knopfdruck
- (void)playExtra:(id)sender {
	
	extraTextView.hidden = NO;											//TextView taucht auf	
	extraImageView.hidden = NO;											//ImageView taucht auf
	UIImage *bild = [UIImage imageNamed: @"test.jpg"];					//Name wird festgelegt (Bild wird vorher in die Ressourcen geladen)
	 
	[extraImageView setImage:bild];										//ausgewählte Bild wird in ImageView eingebunden
	
	[moviePlayer pause];												//bei Knopfdruck pausieren des Videos
	[movieButton setTitle:@"Continue" forState:UIControlStateNormal];	//StartKnopf wird umbenannt	
}



//Anzeige starten-Methode
- (void)starteAnzeige:(NSTimer*)theTimer {
	
	/*
	 In der Zeit zwischen 7 und 12 Sekunden wird der ExtraButton (InfoButton) eingeblendet. 
	 Die Taktung ist jede Sekunde (siehe NSTimer). 
	 */
	if (moviePlayer.currentPlaybackTime > 7 & moviePlayer.currentPlaybackTime < 12) {
		
		//NSLog(@"Anzeige zwischen 7 und 12 Sekunden geschaltet");
		[self.moviePlayer.view addSubview:extraButton];
		extraButton.hidden = NO;
		
	} else {
		
		extraButton.hidden = YES;		//ansonsten Button verstecken
	}
	
	/*
	 Hier wird ab 10 Sekunden Playback-Time zum Test der Button von einer zur anderen Stelle versetzt
	 */
	
	if (moviePlayer.currentPlaybackTime > 10 & moviePlayer.currentPlaybackTime < 12) {
		
		/*Hier wird der Text des Buttons geändert (ausgeblendet)
		 Diese Zeile entfällt, solange der Button ein InfoButton ist*/
		//[extraButton setTitle:@"Hurry up!" forState:UIControlStateNormal];
		
		/*Hier wird die Position des Buttons geändert, während das Video läuft*/
		CGRect frame = extraButton.frame;
		frame.origin.x = 140;					// neue X-Koordinate
		frame.origin.y = 90;					// neue Y-Koordinate
		extraButton.frame = frame;
	}
}



//Movie Notification
- (void) movieDurationAvailable:(NSNotification*)notification {
	
	[self getInfo:nil];
	
}



//Hier wird die URL des Films deklariert
-(NSURL *)movieURL {
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = [bundle pathForResource:@"spot" ofType:@"mp4"];		//Movie wird in die Ressourcen geladen
	
	if (moviePath) {
		return [NSURL fileURLWithPath:moviePath];
	} else {
		return nil;
	}
}



//Methode, wenn der MovieButton betätigt wird
- (void) playMovie:(id)sender {
	
	NSString *text = movieButton.titleLabel.text;				//hier wird der Text des MovieButtons ausgelesen
//	NSLog(@"Der Text ist %@", text);
	
	/*
	 Diese If-Abfrage schaut, welchen Label der MovieButton trägt. 
	 Bei "Play Movie" wird das Video gestartet, bei "Continue" wird es fortgesetzt.
	 Die Zusatzinformationen verschwinden anschließend wieder.
	 */
	if ([text isEqualToString:@"Play Movie"]) {
		
		self.moviePlayer = [[MPMoviePlayerController alloc] init];	//Initialisierung des MPMoviePlayerControllers
		self.moviePlayer.contentURL = [self movieURL];				//Die URL des Videos wird eingelesen
		
		self.moviePlayer.view.frame = self.movieView.bounds;		//Die Größe des Views wird auf das Video übertragen
		self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		[self.movieView addSubview:moviePlayer.view];				
		[self.moviePlayer play];
		
	} else if (movieButton.titleLabel.text = @"Continue") {
		
		[self.moviePlayer play];
		extraTextView.hidden = YES;
		extraImageView.hidden = YES;
		
	} 
}



//getInfo-Methode für das Anzeigen der aktuellen Playback-Informationen
- (void) getInfo:(id)sender {
	
	//Deklarieren der Variablen für Breite, Höhe, Abspielzeit, -geschwindigkeit und Gesamtzeit
	float width = moviePlayer.naturalSize.width;
	float height = moviePlayer.naturalSize.height;
	float playbackTime = moviePlayer.currentPlaybackTime;
	float playbackRate = moviePlayer.currentPlaybackRate;
	float duration = moviePlayer.duration;
	
	//Ausgabe dieser Variablen im Label
	timeLabel.text = [NSString stringWithFormat:@"[Time: %.1f of %.f secs][Playback: %.0f x][Size: %.0f x %.0f]", 
								 playbackTime, duration, playbackRate, width, height];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
