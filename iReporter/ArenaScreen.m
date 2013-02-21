//
//  ArenaScreen.m
//  SnapDuel
//
//  Created by Arda Varilsuha on 1/16/13.
//  Copyright (c) 2013 Arda Varilsuha. All rights reserved.
//


#import "ArenaScreen.h"
#import "API.h"
#import "ArenaPhotoView.h"
#import <Security/Security.h>

#import "StreamPhotoScreen.h" 

//#import "ArenaPhotoScreen.h" segue
//#import "PhotoScreen.h" segue

@interface ArenaScreen(private)

-(void)refreshStream;
-(void)showStream:(NSArray*)stream;

@end

@implementation ArenaScreen
@synthesize IdTagAS;
@synthesize likedPhotoID;

#pragma mark - View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"maxTagID", @"command", nil] onCompletion:^(NSDictionary *json) {
		//got stream
         NSLog(@"Arena %@ ", [[json objectForKey:@"result"] objectAtIndex:0]) ;
        
	}];//use the result to replace 6 below with synthesized maxTagID

 [self btnRefreshTag:(id)self];

    
    
    //self.navigationItem.rightBarButtonItem = btnRefresh;
    //self.navigationItem.rightBarButtonItem = btnCompose;
    
	//show the photo stream
	//[self refreshStream];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)btnRefreshTag:(id)sender {
    
//    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"maxTagID", @"command", nil] onCompletion:^(NSDictionary *json) {
//		//got stream
//        NSLog(@"Arena %d ", [[[[json objectForKey:@"result"] objectAtIndex:0] objectForKey:@"maxTag"] intValue]) ;
//        
//	}];//use the result to replace 6 below with synthesized maxTagID
    
         IdTagAS = [NSNumber numberWithInt:(arc4random() % (6-1+1)) +1]; //random

//    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"getTagName", @"command",IdTagAS,@"tagID", nil] onCompletion:^(NSDictionary *json) {
//		//got stream
//        self.navigationItem.title = [[NSString alloc] initWithString:[[[json objectForKey:@"result"] objectAtIndex:0] objectForKey:@"tagName"]];
//	}];


    [self refreshStream];

}

-(void)refreshStream {
    //just call the "stream" command from the web API
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"streamArena", @"command",IdTagAS,@"tagID", nil] onCompletion:^(NSDictionary *json) {
		//got stream
       //  NSLog(@"Arena %@ ", [[json objectForKey:@"result"] objectAtIndex:0]) ;
		[self showStream:[json objectForKey:@"result"]];
	}];
    

}

-(void)showStream:(NSArray*)stream {
    // 1 remove old photos
    for (UIView* view in listView.subviews) {
        [view removeFromSuperview];
    }
    // 2 add new photo views
    for (int i=0;i<[stream count];i++) {
        NSDictionary* photo = [stream objectAtIndex:i];
        ArenaPhotoView* photoView = [[ArenaPhotoView alloc] initWithIndex:i andData:photo];
        photoView.delegate = self;
        [listView addSubview: photoView];
    }
    // 3 update scroll list's height
    int listHeight = ([stream count]/3 + 1)*(kThumbSide+kPadding);
    [listView setContentSize:CGSizeMake(320, listHeight)];
    [listView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
}

//[[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command",IdTagSS,@"tagID", nil] onCompletion:^(NSDictionary *json) {
//    //got stream
//    [self showStream:[json objectForKey:@"result"]];
//}];

-(void)didSelectArenaPhoto:(ArenaPhotoView*)sender {
//    //photo selected - show it full screen
  //  [self performSegueWithIdentifier:@"ShowPhoto" sender:[NSNumber numberWithInt:sender.tag]];
  //  likedPhotoID = sender.tag;
    likedPhotoID = [NSNumber numberWithInt:sender.tag];
    // NSLog(@"liked   %@ ",likedPhotoID );
    
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"givepoint", @"command",likedPhotoID,@"IdPhoto", nil] onCompletion:^(NSDictionary *json) {
	}];
    
   [self btnRefreshTag:(id)sender];
    

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"ShowPhoto" compare: segue.identifier]==NSOrderedSame) {
        StreamPhotoScreen* streamPhotoScreen = segue.destinationViewController;
        streamPhotoScreen.IdPhoto = sender;
    }
    //TWO SEGUES
//    if ([@"PhotoScreen" compare: segue.identifier]==NSOrderedSame) {
//        PhotoScreen* PhotoScreen = segue.destinationViewController;
//        PhotoScreen.IdTagPS = IdTagSS;
//    }
}

@end
