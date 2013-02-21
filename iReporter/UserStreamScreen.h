//
//  UserStreamScreen.h
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"

@interface UserStreamScreen : UIViewController <PhotoViewDelegate> {
    IBOutlet UIBarButtonItem* btnCompose;
    IBOutlet UIBarButtonItem* btnRefresh;
    IBOutlet UIScrollView* listView;
    
}

//refresh the photo stream
-(IBAction)btnRefreshTapped;
@property (assign, nonatomic) NSNumber* IdTagUSS;


@end