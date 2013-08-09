//
//  OAI_TitleScreen.m
//  AVI Site Integration
//
//  Created by Steve Suranie on 3/7/13.
//  Copyright (c) 2013 Olympus. All rights reserved.
//

#import "OAI_TitleScreen.h"

@implementation OAI_TitleScreen

@synthesize strAppTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void) buildTitleScreen  {
    
    //init the color manager
    colorManager = [[OAI_ColorManager alloc] init];
    
    if (_hasTitle) {
        
        //get the size of the title string
        CGSize titleSize = [strAppTitle sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size: 36.0]];
        
        UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(titleSize.width/2), 300.0, titleSize.width, titleSize.height)];
        lblTitle.text = strAppTitle;
        lblTitle.textColor = [colorManager setColor:8.0 :16.0 :123.0];
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:36.0];
        
        [self addSubview:lblTitle];
        
        //add title image
        UIImage* imgTitle = [UIImage imageNamed:@"imgTitleScreen.png"];
        UIImageView* vImgTitle = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(imgTitle.size.width/2), lblTitle.frame.origin.y + lblTitle.frame.size.height + 10.0, imgTitle.size.width, imgTitle.size.height)];
        [vImgTitle setImage:imgTitle];
        [self addSubview:vImgTitle];
    }
    
    if (_hasImage) {
        
        UIImage* imgTitleScreen = [UIImage imageNamed:_strImageName];
        UIImageView* ivTitleScreen = [[UIImageView alloc] initWithImage:imgTitleScreen];
        
        //reset the frame to center
        [ivTitleScreen setFrame:CGRectMake((self.frame.size.width/2)-(imgTitleScreen.size.width/2), (self.frame.size.height/2)-(imgTitleScreen.size.height/2), imgTitleScreen.size.width, imgTitleScreen.size.height)];
        [self addSubview:ivTitleScreen];
        
    }
}

- (void) adjustForRotation : (UIDeviceOrientation*) orientation {
    
    //get subviews
    NSArray* arrMySubviews = self.subviews;
    UIImageView* ivTitleImage;
    UILabel* lblTitle;
    
    for(int i=0; i<arrMySubviews.count; i++) {
        
        if ([[arrMySubviews objectAtIndex:i] isMemberOfClass:[UIImageView class]]) {
            ivTitleImage = [arrMySubviews objectAtIndex:i];
        } else if ([[arrMySubviews objectAtIndex:i] isMemberOfClass:[UILabel class]]) {
            lblTitle = [arrMySubviews objectAtIndex:i];
        }
    }
    
    //rotate the view
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        
        [self setFrame:CGRectMake(0.0, 0.0, 1024.0, 768.0)];
        
    } else if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        
        [self setFrame:CGRectMake(0.0, 0.0, 768.0, 1024.0)];
        
    }
    
    CGRect myFrame = self.frame;
    
    if (_hasImage) {
        
        //center the logo
        CGRect myImageFrame = ivTitleImage.frame;
        myImageFrame.origin.x = (myFrame.size.width/2)-(myImageFrame.size.width/2);
        myImageFrame.origin.y = (myFrame.size.height/2)-(myImageFrame.size.height/2);
        
        ivTitleImage.frame = myImageFrame;
        
    }
    
    if (_hasTitle) {
        
        //center the title
        CGRect myTitleFrame = lblTitle.frame;
        myTitleFrame.origin.x = (myFrame.size.width/2)-(myTitleFrame.size.width/2);
        
        lblTitle.frame = myTitleFrame;
        
    }
}

- (void) fadeTitleScreen   {
    
    [UIView animateWithDuration:2.0 delay:.5 options:UIViewAnimationOptionCurveEaseOut
     
        animations:^{
            self.alpha = 0.0;
        }
     
        completion:^ (BOOL finished) {
            
            CGRect myFrame = self.frame;
            myFrame.origin.x = 0-myFrame.size.width;
            myFrame.origin.y = 0-myFrame.size.height;
            self.frame = myFrame;
        }
     ];
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
