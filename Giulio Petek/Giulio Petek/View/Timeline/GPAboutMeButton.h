/* ------------------------------------------------------------------------------------------------------
 GPAboutMeButton.h
 
 Created by Giulio Petek on 27.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

typedef NS_ENUM(NSInteger, GPAboutMeButtonArrowDirection) {
    GPAboutMeButtonArrowDirectionPointingDown = 0,
    GPAboutMeButtonArrowDirectionPointingUp
};

/* --- interface -------------------------------------------------------------------------------------- */

@interface GPAboutMeButton : UIControl

@property (nonatomic, strong) NSString *title;
@property (nonatomic, unsafe_unretained) GPAboutMeButtonArrowDirection direction;

@end
