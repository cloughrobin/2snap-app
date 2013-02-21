//
//  ArenaScreen.h
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArenaPhotoView.h"

@interface ArenaScreen : UIViewController <ArenaPhotoViewDelegate> {
//    IBOutlet UIBarButtonItem* btnCompose;
//    IBOutlet UIBarButtonItem* btnRefresh;
    IBOutlet UIScrollView* listView;
    
}

//refresh the photo stream
//-(IBAction)btnRefreshTapped;
- (IBAction)btnRefreshTag:(id)sender;
@property (assign, nonatomic) NSNumber* IdTagAS;
@property (assign, nonatomic) NSNumber* likedPhotoID;



@end