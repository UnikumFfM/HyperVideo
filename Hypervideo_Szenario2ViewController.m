//
//  Hypervideo_Szenario2ViewController.m
//  Hypervideo_Szenario2
//
//  Created by Sven Reuter on 26.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Hypervideo_Szenario2ViewController.h"

@implementation Hypervideo_Szenario2ViewController

@synthesize moviePlayer;
@synthesize moviePlayButton;
@synthesize movieView;
@synthesize textSubmitButton;
@synthesize textTextField;


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
	
	self.moviePlayer = [[MPMoviePlayerController alloc] init];	//Initialisierung des MPMoviePlayerControllers
	self.moviePlayer.contentURL = [self movieURL];				//Die URL des Videos wird eingelesen
	
	self.moviePlayer.view.frame = self.movieView.bounds;		//Die Größe des Views wird auf das Video übertragen
	self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[self.movieView addSubview:moviePlayer.view];				
	[self.moviePlayer play];
		
}

- (void) submitText:(id)sender {
	
	NSLog(@"Der eingegebene Text lautet: %@", textTextField.text);
	textTextField.text = nil;
	
	[self.moviePlayer play];
	
}

//Movie Notification
- (void) movieDurationAvailable:(NSNotification*)notification {
	
}

//Anzeige starten-Methode
- (void)starteAnzeige:(NSTimer*)theTimer {
	
	
	/*
	 Bei 4 und 12 Sekunden wird das Video pausiert. Erst nach einer Texteingabe wird weiter fortgefahren.
	 
	 Problem:
	 Es passiert, dass mehrmals gestoppt wird, weil es innerhalb der angezeigten Sekunde mehrere Taktschläge gibt.
	 */
	if (moviePlayer.currentPlaybackTime > 4 & moviePlayer.currentPlaybackTime < 5) {
		
		NSLog(@"Zeit ist %.4f", moviePlayer.currentPlaybackTime);
		
		[self.moviePlayer pause];
		
	} else if (moviePlayer.currentPlaybackTime > 12 & moviePlayer.currentPlaybackTime < 13) {
		
		NSLog(@"Zeit ist %.0f", moviePlayer.currentPlaybackTime);

		
		[self.moviePlayer pause];
	}
	
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
