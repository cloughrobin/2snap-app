//
//  UserStreamScreen.m
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//



#import "UserStreamScreen.h"
#import "API.h"
#import "PhotoView.h"
#import "UserStreamPhotoScreen.h"
#import "PhotoScreen.h"

@interface UserStreamScreen(private)

-(void)refreshStream;
-(void)showStream:(NSArray*)stream;

@end

@implementation UserStreamScreen
@synthesize IdTagUSS;

#pragma mark - View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = IdTagUSS;
    NSLog(@"idtag %@ ",IdTagUSS );

    //self.navigationItem.rightBarButtonItem = btnRefresh;
    self.navigationItem.rightBarButtonItem = btnCompose;
    
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"getTagPoints", @"command", IdTagUSS,@"tagID",[[[API sharedInstance] user] objectForKey:@"IdUser"],@"IdUser", nil] onCompletion:^(NSDictionary *json) {
		//got stream
        
       // NSLog(@"Arena %@ ",json );
        //        NSLog(@"Arena %d ", [[[[json objectForKey:@"result"] objectAtIndex:0] objectForKey:@"totalpoints"] intValue]) ;
        
        self.navigationItem.title=[[NSString alloc] initWithFormat:@"Total Points:%@",[[[json objectForKey:@"result"] objectAtIndex:0] objectForKey:@"totalpoints"] ] ;
	}];
	//show the photo stream
	[self refreshStream];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)btnRefreshTapped {
	[self refreshStream];
}

-(void)refreshStream {
    //just call the "stream" command from the web API
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command",IdTagUSS,@"tagID",[[[API sharedInstance] user] objectForKey:@"IdUser"],@"IdUser", nil] onCompletion:^(NSDictionary *json) {
		//got stream
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
        PhotoView* photoView = [[PhotoView alloc] initWithIndex:i andData:photo];
        photoView.delegate = self;
        [listView addSubview: photoView];
    }
    // 3 update scroll list's height
    int listHeight = ([stream count]/3 + 1)*(kThumbSide+kPadding);
    [listView setContentSize:CGSizeMake(320, listHeight)];
    [listView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
}

-(void)didSelectPhoto:(PhotoView*)sender {
    //photo selected - show it full screen
    [self performSegueWithIdentifier:@"UserShowPhoto" sender:[NSNumber numberWithInt:sender.tag]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"UserShowPhoto" compare: segue.identifier]==NSOrderedSame) {
        UserStreamPhotoScreen* streamPhotoScreen = segue.destinationViewController;
        streamPhotoScreen.IdPhoto = sender;
    }
    //TWO SEGUES
    if ([@"PhotoScreen" compare: segue.identifier]==NSOrderedSame) {
        PhotoScreen* PhotoScreen = segue.destinationViewController;
        PhotoScreen.IdTagPS = self.navigationItem.title;
    }
}

@end
