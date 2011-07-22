//
//  Szenario1ViewController.m
//  Szenario1
//
//  Created by Sven Reuter on 13.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Szenario1ViewController.h"

@implementation Szenario1ViewController

@synthesize moviePlayer;
@synthesize viewForMovie;
@synthesize additionTextView;
@synthesize buttonToStartMovie;
@synthesize buttonForAddition;
@synthesize additionImageView;
@synthesize JSONText;
@synthesize error;
@synthesize additionVideoView;
@synthesize extraPlayer;


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

//Läd alle Werte in ein NSDictionary, um diese weiterzuverwenden
-(void) loadButtonsFor:(NSString *)text {
	
	//Auslesen der JSON-Datei in ein NSDictionary
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] 
													pathForResource:text ofType:@"json"]
														   encoding:NSUTF8StringEncoding error:&error];
	NSDictionary *allValues = [jsonString JSONValue];
	
	
	
	int i = 0;						//meine Laufvariable
	int count = [allValues count];	//Anzahl der Elemente an Zusatzinformationen
	NSLog(@"Count ist %i",i);
	
	/* In dieser FOR-Schleife werden die Buttons für alle Indizes angezeigt
	 Schleife läuft von 0 bis (Anzahl Elemente-1)*/
	for (i=0; i<count; i++) {

		//Das Image wird ausgelesen, um erkennen zu können, welches Symbol verwendet werden muss
		NSString *image = [[allValues valueForKey:@"Bezeichnung"] objectAtIndex:i];
		//Hier wird die Position des Buttons ausgelesen, dieser Teil muss ggf. flexibler gestaltet werden
		int x = [[[allValues valueForKey:@"XPos"] objectAtIndex:i] intValue];
		int y = [[[allValues valueForKey:@"YPos"] objectAtIndex:i] intValue];
	
		//Die Methode loadButtonWithTag wird geladen, um den Button an seiner Position zu laden
		[self loadButtonWithTag:100+i Image:image x:x y:y];
		
		NSLog(@"Image ist %@", image);
		
	}
}



//Gibt mir die Werte als Object aus, müssen anschließend nur in Integer konvertiert werden (siehe unten, auskommentiert)
/*-(NSString *) getValueFor:(NSString *)text from:(int)object {
	
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] 
																	 pathForResource:@"Hyperlinks" ofType:@"json"]
														   encoding:NSUTF8StringEncoding error:&error];
	
	NSDictionary *allValues = [jsonString JSONValue];
	NSLog(@"Dictionary lautet: %@", allValues);
	NSArray *array = [allValues objectForKey:@"Start"];
	//NSObject *wert = [array objectAtIndex:0];
	NSLog(@"Der Wert hingegen: %@", array);
	
	NSString *test = @"Hallo";
	return test;
}*/



/*
-(NSString *) getDateiinformationfrom:(int)object {
	
	NSDictionary *dic = [self loadButtonsFor:@"Hyperlinks"]; 
	NSString *wert = [[dic objectForKey:@"Dateiinformation"] objectAtIndex:object];
	return wert;
}


-(int *) getEndFrom:(int)object {
	
	NSDictionary *dic = [self loadButtonsFor:@"Hyperlinks"]; 
	int *wert = [[[dic objectForKey:@"End"] objectAtIndex:object] integerValue ];
	return wert;
}

-(int *) getStartFrom:(int)object {
	
	NSDictionary *dic = [self loadButtonsFor:@"Hyperlinks"]; 
	int *wert = [[[dic objectForKey:@"Start"] objectAtIndex:object] integerValue ];
	return wert;
}*/
 

//In dieser Methode werden die Eigenschaften zugeordnet und der Button in den View geladen
-(void) loadButtonWithTag:(int)tag Image:(NSString *)image x:(int)x y:(int)y {
	
	//Das Image für den Button
	UIImage *bild;
	
	NSLog(@"Auch hier ist Image %@", image);
	
	/* In dieser IF-Abfrage wird das Bild zur Zusatzinformation geladen */
	if ([image isEqualToString:@"Bild"]==TRUE) {
		bild = [UIImage imageNamed:@"Symbol_Bild.png"];
	} else if ([image isEqualToString:@"Bildergalerie"]==TRUE) {
		bild = [UIImage imageNamed:@"Symbol_Bildergalerie.png"];
	} else if ([image isEqualToString:@"Hypertext"]==TRUE) {
		bild = [UIImage imageNamed:@"Symbol_Hypertext.png"];
	} else if ([image isEqualToString:@"Text"]==TRUE) {
		bild = [UIImage imageNamed:@"Symbol_Text.png"];
	} else if ([image isEqualToString:@"Video"]==TRUE) {
		bild = [UIImage imageNamed:@"Symbol_Video.png"];
	} else {
		bild = [UIImage imageNamed:@"Symbol_Default.jpg"];
	}
	
	
	//Der Button wird als Custom erstellt, um Änderungen vornehmen zu können
	buttonForAddition = [UIButton buttonWithType:UIButtonTypeCustom]; 
	
	//Frame wird festgelegt mit den X- und Y-Koordinaten aus der JSON
	//Die Größe des Buttons ist hier auf 60 festgelegt
    [buttonForAddition setFrame:CGRectMake(x, y, 60, 60)]; 
	
	//Hier wird das Ziel hinzugefügt, um eine Action ausführen zu können in der Methode buttonClicked()
    [buttonForAddition addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside]; 
	
	//Das oben definierte Image wird dem Button zugewiesen
	[buttonForAddition setImage:bild forState:UIControlStateNormal];

	//Um auf die Instanz des Buttons zugreifen zu können, wird ein Tag verwendet
	[buttonForAddition setTag:tag];
	
	//Der Button wird dem ViewForMovie hinzugefügt
    [self.viewForMovie addSubview:buttonForAddition];
	
	//Der Button mit definiertem Tag wird versteckt
	[[self.viewForMovie viewWithTag:tag] setHidden:TRUE];
}
/*
-(void) loadAdditionFrom: (NSString *)text {
	
	
	int i = 0;
	
	//Auslesen der JSON-Datei in ein NSDictionary
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] 
														pathForResource:text ofType:@"json"]
														   encoding:NSUTF8StringEncoding error:&error];
	NSDictionary *allValues = [jsonString JSONValue];
	
	NSString *zusatz = [[allValues valueForKey:@"Bezeichnung"] objectAtIndex:i];
	
	/* In dieser IF-Abfrage wird das Bild zur Zusatzinformation geladen 
	if ([zusatz isEqualToString:@"Bild"]==TRUE) {
		
		NSLog(@"Ein Bild");

	} else if ([zusatz isEqualToString:@"Bildergalerie"]==TRUE) {
		
		NSLog(@"Ein Bildergalerie");

	} else if ([zusatz isEqualToString:@"Hypertext"]==TRUE) {
		
		NSLog(@"Ein HTML");

	} else if ([zusatz isEqualToString:@"Text"]==TRUE) {
		
		NSLog(@"Ein Text");
		
	} else if ([zusatz isEqualToString:@"Video"]==TRUE) {
		
		NSLog(@"Ein Video");

	} else {
		
		NSLog(@"Default!");
		
	}
}*/

-(void) buttonWithTag:(int)tag {
	
	int i = tag-100; //Index
	
	//Auslesen der JSON-Datei in ein NSDictionary
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] 
																	 pathForResource:@"Hyperlinks" ofType:@"json"]
														   encoding:NSUTF8StringEncoding error:&error];
	NSDictionary *allValues = [jsonString JSONValue];
	
	NSString *zusatz = [[allValues valueForKey:@"Bezeichnung"] objectAtIndex:i];

	
	/* In dieser IF-Abfrage wird das Bild zur Zusatzinformation geladen */
	if ([zusatz isEqualToString:@"Bild"]==TRUE) {
		
		
		additionImageView.hidden = NO;											//ImageView taucht auf
		UIImage *bild = [UIImage imageNamed: [[allValues valueForKey:@"Dateiinformation"] objectAtIndex:i]];				//Name wird festgelegt (Bild wird vorher in die Ressourcen geladen)
		
		[additionImageView setImage:bild];
		[self.viewForMovie bringSubviewToFront:additionImageView];
		additionImageView.hidden = NO;
		
		
	} else if ([zusatz isEqualToString:@"Bildergalerie"]==TRUE) {
		
		NSLog(@"Ein Bildergalerie");
		
	} else if ([zusatz isEqualToString:@"Hypertext"]==TRUE) {
		
		NSLog(@"Ein HTML");
		
	} else if ([zusatz isEqualToString:@"Text"]==TRUE) {
		
		NSString *text = [[allValues valueForKey:@"Dateiinformation"] objectAtIndex:i] ;
	
		additionTextView.text = text;
		[self.view addSubview:additionTextView];
		[self.view bringSubviewToFront:additionTextView];
		additionTextView.hidden = NO;
		//[additionTextView ]
		
	} else if ([zusatz isEqualToString:@"Video"]==TRUE) {
		
		/*Dies ist ein Test für ein zweites Video*/
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Pixar3" ofType:@"mp4"];	//File des Videos
		NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];							//File des Videos (URL)
		self.extraPlayer = [[AVPlayer alloc] initWithURL:fileURL];								//Initialisierung des Players
		
		AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:extraPlayer];			//Initialisierung des PlayerLayers
		playerLayer.frame = self.additionVideoView.bounds;
		[self.additionVideoView.layer addSublayer:playerLayer];
		
		//[super viewDidLoad];
		[self.viewForMovie bringSubviewToFront:additionVideoView];
		additionVideoView .hidden = NO;
		
		[self.extraPlayer play];
		/*End Test*/
		
	} else {
		
		NSLog(@"Default!");
		
	}
	
}

-(void) buttonClicked:(UIButton *)button{
	
	[self buttonWithTag:[button tag]];

}

//Der Button mit definiertem Tag wird angezeigt
-(void) doButtonWithTag:(int)x {
	
	//mittels setHidden:FALSE
	[[self.viewForMovie viewWithTag:x] setHidden:FALSE];
}

//analog dazu wird der Tag wieder ausgeblendet
-(void) undoButtonWithTag:(int)x {
	
	/* Ausblenden mit Animation */
	/*
	[UIView animateWithDuration:0.75 animations:^{
		[self.viewForMovie viewWithTag:x].alpha = 0.0;	
	}];*/
	//mittels setHidden:TRUE
	[[self.viewForMovie viewWithTag:x] setHidden:TRUE];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Notification, um das Video vollständig geladen zu haben, bevor es verwendet wird (wichtig für Streams)
	[[NSNotificationCenter defaultCenter]
	 addObserver:self 
	 selector:@selector(movieDurationAvailable:)
	 name:MPMovieDurationAvailableNotification
	 object:nil];
		
}


- (NSArray *)valueWithKey:(NSString *)key atPosition:(int)x {
	
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] 
														pathForResource:@"Hyperlinks" ofType:@"json"]
														   encoding:NSUTF8StringEncoding error:&error];
	
	NSDictionary *allValues = [jsonString JSONValue];
	
	NSArray *keyArray = [allValues valueForKey:key]; 
		
	return [keyArray objectAtIndex:x] ;
	
}

-(int)anzeigeFuer:(NSString *)text at:(int)position {
	
	NSArray *array = [NSArray arrayWithObject:[self valueWithKey:text atPosition:position]];
	int start = [[array objectAtIndex:0] intValue];
	
	return start;
	
}

-(int) anzahlElementeFor:(NSString *)text {
	
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] 
																	 pathForResource:text ofType:@"json"]
														   encoding:NSUTF8StringEncoding error:&error];
	
	NSDictionary *allValues = [jsonString JSONValue];
	int count = [allValues count];
	return count;
	
}

-(void)starteAnzeige:(NSTimer *)theTimer {
	
	for (elemente=0; elemente<[self anzahlElementeFor:@"Hyperlinks"]; elemente++) {
	 	
	if (moviePlayer.currentPlaybackTime>[self anzeigeFuer:@"Start" at:elemente] & 
		moviePlayer.currentPlaybackTime<[self anzeigeFuer:@"Ende" at:elemente]) {
		
		
		//NSLog(@"Die Anzeige schaltet!");
		[self doButtonWithTag:100+elemente];
		
		
		
	} else if (moviePlayer.currentPlaybackTime>[self anzeigeFuer:@"Ende" at:elemente]) {
		
		[self undoButtonWithTag:100+elemente];
	}
	}
}


- (void)movieDurationAvailable:(NSNotification*)notification {
	
}

//Die URL des Filmes wird hier definiert
-(NSURL *)movieURL {
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = [bundle pathForResource:@"PIXAR1" ofType:@"mp4"];
	
	if (moviePath) {
		return [NSURL fileURLWithPath:moviePath];
	} else {
		return nil;
	}	
}

//Die Aktion nach dem Drücken des "Play"-Buttons
-(void)playMovie:(id)sender {
	
	/* Initialisierung und Anpassung des MoviePlayers*/
	//Hier wird der Player initialisiert und geladen
	self.moviePlayer = [[MPMoviePlayerController alloc] init];
	//Die URL wird aus movieURL gelesen
	self.moviePlayer.contentURL = [self movieURL];
	//Die Maße des Views werden übernommen
	self.moviePlayer.view.frame = self.viewForMovie.bounds;
	//Die Maße des Videos werden dem View flexibel angepasst
	self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	//Der MoviePlayer wird ein Subview des ViewforMovie
	[self.viewForMovie addSubview:moviePlayer.view];
	//Der Player wird gestartet
	[self.moviePlayer play];
	
	//Starten des NSTimers um eine Intervaltaktung zu bekommen, für Methode "starteAnzeige()"
	[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(starteAnzeige:)
								   userInfo:nil repeats:YES];

	[self loadButtonsFor:@"Hyperlinks"];

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
