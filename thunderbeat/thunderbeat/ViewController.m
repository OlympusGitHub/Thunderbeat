//
//  ViewController.m
//  thunderbeat
//
//  Created by Steve Suranie on 8/9/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    //notification for device rotation
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //notification center for incoming messages
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"message"object:nil];
    
    //init managers
    sfxManager = [[OAI_AudioManager alloc] init];
    colorManager = [[OAI_ColorManager alloc] init];
    fileManager = [[OAI_FileManager alloc] init];
    currencyConvertor = [[OAI_CurrencyConvertor alloc] init];
    numberManager = [[OAI_NumberManager alloc] init];
    
    //add the title bar
    titleBar = [[OAI_TitleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 50.0)];
    titleBar.titleBarTitle = @"Thunderbeat Calculator";
    titleBar.hasAccount = YES;
    titleBar.hasReset = YES;
    titleBar.hasHome = YES;
    [titleBar buildTitleBar];
    [self.view addSubview:titleBar];
    
    //add the title screen
    titleScreen = [[OAI_TitleScreen alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 768.0)];
    titleScreen.strAppTitle = @"Thunderbeat Calculator";
    titleScreen.hasTitle = YES;
    titleScreen.hasImage = YES;
    titleScreen.strImageName = @"imgPlaceholder.png";
    [titleScreen buildTitleScreen];
    [self.view addSubview:titleScreen];
    
    //add the splash screen
    splashScreen = [[OAI_SplashScreen alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 768.0)];
    splashScreen.myTitleScreen = titleScreen;
    [splashScreen runSplashScreenAnimation];
    [self.view addSubview:splashScreen];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Notification Center
- (void) receiveNotification:(NSNotification* ) notification {
    
    if ([[notification name] isEqualToString:@"message"]) {
        
        //get the event
        NSString* theEvent = [[notification userInfo] objectForKey:@"Action"];
        
        if ([theEvent isEqualToString:@""]) {
            //do something based on event
        }
    }
}

#pragma mark - Orientation Changed Methods
- (void) deviceOrientationDidChange : (UIDeviceOrientation*) orientation {
    
    //call the rotation management methods of various classes
    [splashScreen adjustForRotation:orientation];
    [titleScreen adjustForRotation:orientation];
    [titleBar adjustForRotation:orientation];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
