//
//  UserTagsStreamScreen.h
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagIconView.h"

@interface UserTagsStreamScreen : UIViewController <TagIconViewDelegate> {
//
//IBOutlet UIBarButtonItem* btnCompose;
//IBOutlet UIBarButtonItem* btnRefresh;
IBOutlet UIScrollView* listView;

    
IBOutlet UILabel *labelTagTitle;

    IBOutlet UILabel *labelTag1;
    IBOutlet UILabel *labelTag2;
    IBOutlet UILabel *labelTag3;
    
    IBOutlet UILabel *labelTag4;
    
    IBOutlet UILabel *labelTag5;
    
    IBOutlet UILabel *labelTag6;
}

//refresh the photo stream
- (IBAction)btnRefreshTapped:(id)sender;
@property (assign, nonatomic) NSNumber* IdTagUTSS;


@end
