//
//  ViewController.h
//  thunderbeat
//
//  Created by Steve Suranie on 8/9/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAI_AudioManager.h"
#import "OAI_ColorManager.h"
#import "OAI_CurrencyConvertor.h"
#import "OAI_FileManager.h"
#import "OAI_SplashScreen.h"
#import "OAI_TitleBar.h"
#import "OAI_TitleScreen.h"
#import "OAI_NumberManager.h"

#import "OAI_Label.h"

@interface ViewController : UIViewController {
    
    OAI_AudioManager* sfxManager;
    OAI_ColorManager* colorManager;
    OAI_CurrencyConvertor* currencyConvertor;
    OAI_FileManager* fileManager;
    OAI_SplashScreen* splashScreen;
    OAI_TitleBar* titleBar;
    OAI_TitleScreen* titleScreen;
    OAI_NumberManager* numberManager;
    
}

- (void) deviceOrientationDidChange : (UIDeviceOrientation*) orientation;

@end
