//
//  UserTagsStreamScreen.m
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "UserTagsStreamScreen.h"
#import "UserStreamScreen.h"
#import "API.h"
#import "TagIconView.h"


@interface UserTagsStreamScreen ()

-(void)getTagPoint:(NSInteger)tagID;
-(void)refreshStream;
-(void)showStream:(NSArray*)stream;

@end

@implementation UserTagsStreamScreen

@synthesize IdTagUTSS;

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
    if (![[API sharedInstance] isAuthorized]) {
	[self performSegueWithIdentifier:@"ShowLogin" sender:nil];
        
	}
    self.navigationItem.title = @"My Profile";
    


    
	//show the photo stream
	[self refreshStream];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)btnRefreshTapped:(id)sender {
    [self refreshStream];
}

-(void)refreshStream {

    
    //just call the "stream" command from the web API
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"listtags", @"command", nil] onCompletion:^(NSDictionary *json) {
		//got stream
		[self showStream:[json objectForKey:@"result"]];
	}];
       

    


    [self getTagPoint:1];
     [self getTagPoint:2];
     [self getTagPoint:3];
     [self getTagPoint:4];
    [self getTagPoint:5];
     [self getTagPoint:6];
    



}

-(void)getTagPoint:(NSInteger)tagID {
    
    NSArray *tagLabels = [[NSArray alloc] initWithObjects:labelTag1,labelTag2,labelTag3,labelTag4,labelTag5,labelTag6, nil];
    NSArray *tagNames = [[NSArray alloc] initWithObjects:@"Someone",@"Natural",@"Fashion",@"Drinks",@"Food",@"Shopping", nil];

    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"getTagPoints",@"command",[NSNumber numberWithInt:tagID] ,@"tagID",[[[API sharedInstance] user] objectForKey:@"IdUser"],@"IdUser", nil] onCompletion:^(NSDictionary *json) {
		//got stream
        //       [[labelsForTags objectAtIndex:i] setText:[[NSString alloc] initWithFormat:@"%@",[[[json objectForKey:@"result"] objectAtIndex:0] objectForKey:@"totalpoints"] ]];
        
        NSString* tagPnt = [NSString stringWithFormat:
                            @"%@",[[NSString alloc] initWithFormat:@"%@: %@",[tagNames objectAtIndex:tagID-1],[[[json objectForKey:@"result"] objectAtIndex:0] objectForKey:@"totalpoints"] ] ];
        
        [[tagLabels objectAtIndex:tagID-1] setText:tagPnt];
        
        NSLog(@"points %@", tagPnt);
        
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
    [self performSegueWithIdentifier:@"UserStreamScreen" sender:[NSNumber numberWithInt:sender.tag]];
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([@"UserStreamScreen" compare: segue.identifier]==NSOrderedSame) {
        UserStreamScreen* userStreamScreen = segue.destinationViewController;
        userStreamScreen.IdTagUSS = sender;
    }
    
}

@end
