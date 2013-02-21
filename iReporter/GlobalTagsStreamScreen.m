//
//  GlobalTagsStreamScreen.m
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "GlobalTagsStreamScreen.h"
#import "StreamScreen.h"
#import "API.h"
#import "TagIconView.h"

@interface GlobalTagsStreamScreen ()

-(void)refreshStream;
-(void)showStream:(NSArray*)stream;

@end

@implementation GlobalTagsStreamScreen

@synthesize IdTagGTSS;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;


}

-(void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = IdTagSS;
    //self.navigationItem.rightBarButtonItem = btnRefresh;
    //self.navigationItem.rightBarButtonItem = btnCompose;
    self.navigationItem.title = @"Global View";
	//show the photo stream
	[self refreshStream];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-(IBAction)btnRefreshTapped {
//	[self refreshStream];
//}


- (IBAction)btnRefreshCustom:(id)sender {
    [self refreshStream];
    NSLog(@"refresh");
}

-(void)refreshStream {
    //just call the "listtags" command from the web API
    
   [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"listtags", @"command", nil] onCompletion:^(NSDictionary *json) {
		//got stream
		[self showStream:[json objectForKey:@"result"]];
     //  NSLog(@"Here %@ ",[json objectForKey:@"result"]);
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
        TagIconView* tagIconView = [[TagIconView alloc] initWithIndex:i andData:photo];
        tagIconView.delegate = self;
        [listView addSubview: tagIconView];
    }
    // 3 update scroll list's height
    int listHeight = ([stream count]/3 + 1)*(kThumbSide+kPadding);
    [listView setContentSize:CGSizeMake(320, listHeight)];
    [listView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
}

-(void)didSelectPhoto:(TagIconView*)sender {
    //Tag Icon selected - go to Stream Screen
    [self performSegueWithIdentifier:@"ShowStreamforTag" sender:[NSNumber numberWithInt:sender.tag]];
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([@"ShowStreamforTag" compare: segue.identifier]==NSOrderedSame) {
        StreamScreen* streamScreen = segue.destinationViewController;
        streamScreen.IdTagSS = sender;
    }
    
}

@end
