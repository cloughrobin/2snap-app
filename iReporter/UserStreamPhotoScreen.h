//
//  UsetStreamPhotoScreen.h
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserStreamPhotoScreen : UIViewController
{
    //just the photo view and the photo title
    IBOutlet UIImageView* photoView;
    IBOutlet UILabel* lblTitle;
}

@property (assign, nonatomic) NSNumber* IdPhoto;

@end

