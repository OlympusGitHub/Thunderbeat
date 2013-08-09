//
//  OAI_TitleBar.m
//  AVI Site Integration
//
//  Created by Steve Suranie on 3/7/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_TitleBar.h"

@implementation OAI_TitleBar

@synthesize titleBarTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        //shadow
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.75;
        
    }
    return self;
}

- (void) buildTitleBar { 
        
    //set olympus logo
    UIImageView* OALogoTopBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OA_logo_black_topbar.png"]];
    
    //position the logo
    CGRect topBarLogoFrame = OALogoTopBar.frame;
    topBarLogoFrame.origin.x = 15.0;
    topBarLogoFrame.origin.y = 8.0;
    OALogoTopBar.frame = topBarLogoFrame;
    
    //add the logo
    [self addSubview:OALogoTopBar];
    
    titleFont = [UIFont fontWithName:@"Helvetica" size:22.0];
    
    //add title bar title
    CGSize titleSize = [titleBarTitle sizeWithFont:titleFont];
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-(titleSize.width+10.), 20.0, titleSize.width, titleSize.height)];
    lblTitle.text = titleBarTitle;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = titleFont;
    lblTitle.tag = 100;
    [self addSubview:lblTitle];
    
    //declare some buttons
    UIButton* btnAccount;
    UIButton* btnReset;
    UIButton* btnHome;
    UIButton* lastButton;
    
    //set a starting location for the buttons
    float btnStartX = 0.0; 
    
    //add titlebar buttons
    if(_hasAccount) {
        
        lastButton = [self addButton:btnAccount :lastButton :btnStartX:OALogoTopBar.frame:@"btnAccount"];
        btnStartX = lastButton.frame.origin.x;
    }
     
    
    if (_hasReset) {
        
        lastButton = [self addButton:btnReset :lastButton :btnStartX:OALogoTopBar.frame:@"btnReload"];
        btnStartX = lastButton.frame.origin.x;
        
    }
    
    if (_hasHome) {
        
        lastButton = [self addButton:btnHome :lastButton :btnStartX:OALogoTopBar.frame:@"btnHome"];
        btnStartX = lastButton.frame.origin.x;
        
    }
    
    
}

- (UIButton*) addButton : (UIButton*) buttonToAdd : (UIButton*) lastButton : (float) btnX : (CGRect) logoFrame : (NSString*) strButtonImage {
    
    if (btnX == 0) {
        btnX = logoFrame.origin.x + logoFrame.size.width + 10.0;
    } else {
        btnX = lastButton.frame.origin.x + lastButton.frame.size.width + 10.0;
    }
    
    //buid btn
    buttonToAdd = [[UIButton alloc] init];
    [buttonToAdd buildImageButton:strButtonImage:btnX];
    [self addSubview:buttonToAdd];
    
    //set lastButton to this btn
    return buttonToAdd;
    
}


#pragma mark - Adjust For Orientation Methods
- (void) adjustForRotation : (UIDeviceOrientation*) orientation {
    
    //get the subviews
    NSArray* arrMySubviews = self.subviews;
    
    //get the label
    UILabel* lblTitleLabel;
    for(int i=0; i<arrMySubviews.count; i++) {
        if ([[arrMySubviews objectAtIndex:i] isMemberOfClass:[UILabel class]]) {
            lblTitleLabel = [arrMySubviews objectAtIndex:i];
        }
    }
    
    //get the size of the title
    CGSize myTitleSize = [lblTitleLabel.text sizeWithFont:titleFont constrainedToSize:CGSizeMake(self.frame.size.width, 999.0) lineBreakMode:NSLineBreakByWordWrapping];
        
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        
        [self setFrame:CGRectMake(0.0, 0.0, 1024.0, 50.0)];
        
    } else if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        
        [self setFrame:CGRectMake(0.0, 0.0, 768.0, 50.0)];
        
    }
    
    CGRect titleFrame = lblTitleLabel.frame;
    
    //reposition app title
    titleFrame.origin.x = self.frame.size.width - (myTitleSize.width + 30.0);
    lblTitleLabel.frame = titleFrame;
}


#pragma mark - Button Touched Methods
- (void) toggleAccount : (UIButton* ) btnAccount {
    
    NSMutableDictionary* userData = [[NSMutableDictionary alloc] init];
    
    [userData setObject:@"Show Account" forKey:@"Action"];
    
    /*This is the call back to the notification center, */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"theMessenger" object:self userInfo: userData];
    
}

- (void) resetAll : (UIButton*) myButton {
    
    //return dictionary of results
    NSMutableDictionary* userData = [[NSMutableDictionary alloc] init];
    [userData setObject:@"Reset All" forKey:@"Action"];
    
    /*This is the call back to the notification center, */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"theMessenger" object:self userInfo: userData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
