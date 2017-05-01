//
//  ViewController.m
//  Twitter_Sharing_App
//
//  Created by OSX on 24/06/16.
//  Copyright © 2016 OSX. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweet_Text;
-(void)configureTweet;
-(void) showAlertMessage:(NSString *)myMessage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTweet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showAlertMessage:(NSString *) myMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Problem!" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)show_Share:(id)sender {
    if([self.tweet_Text isFirstResponder]) {
        [self.tweet_Text resignFirstResponder];
    }
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Share Options" message:@"Share it with your friends" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        //Tweet
            SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            if([self.tweet_Text.text length] < 140){
                [twitterVC setInitialText:self.tweet_Text.text];
                
            }
            else{
                NSString *shortText = [self.tweet_Text.text substringToIndex:140];
                [twitterVC setInitialText:shortText];
            }
            [self presentViewController:twitterVC animated:YES completion:nil];
        }
        else{
        //POP up not signed in
            [self showAlertMessage:@"Please Sign in to Twitter"];
        }
    }];
    
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Post to FaceBook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
            SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
           
            [facebookVC setInitialText:self.tweet_Text.text];
            
            [self presentViewController:facebookVC animated:YES completion:nil];
        }
        else{
            [self showAlertMessage:@"Please Sign in to FaceBook"];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    
    UIAlertAction *uiActivityAction = [UIAlertAction actionWithTitle:@"More" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    
        UIActivityViewController *actVC = [[UIActivityViewController alloc]initWithActivityItems:@[self.tweet_Text.text] applicationActivities:nil];
       
        [self presentViewController:actVC animated:YES completion:nil];
        
    }];
    
    
    
    [actionController addAction:facebookAction];
    [actionController addAction:tweetAction];
    [actionController addAction:uiActivityAction];
    [actionController addAction:cancelAction];
    
    [self presentViewController:actionController animated:YES completion:nil];
    
    
}

-(void) configureTweet{
    self.tweet_Text.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweet_Text.layer.cornerRadius = 10.0;
    self.tweet_Text.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweet_Text.layer.borderWidth = 2.0;
}

@end
