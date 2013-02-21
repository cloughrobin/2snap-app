//
//  GlobalTagsStreamScreen.h
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagIconView.h"

@interface GlobalTagsStreamScreen : UIViewController <TagIconViewDelegate> {

IBOutlet UIBarButtonItem* btnCompose;
IBOutlet UIBarButtonItem* btnRefresh;
IBOutlet UIScrollView* listView;

}

//refresh the photo stream
//-(IBAction)btnRefreshTapped;

- (IBAction)btnRefreshCustom:(id)sender;
@property (assign, nonatomic) NSNumber* IdTagGTSS;



@end
