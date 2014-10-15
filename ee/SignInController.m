#import "SignInController.h"
#import "LinkedInClient.h"
#import "FirebaseClient.h"

@interface SignInController ()
@end

@implementation SignInController {
    LinkedInClient *_linkedIn;
    FirebaseClient *_firebase;
}

@synthesize signInButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    signInButton.enabled = false;
    
    _linkedIn = [[LinkedInClient alloc] init];
    _firebase = [[FirebaseClient alloc] init];
    
    [_linkedIn attemptToSignInFromSavedTokenWithSuccess:^(NSDictionary *linkedInProfile) {
        [self transitionToProfileControllerWithProfile: linkedInProfile];
    } andNoSavedToken:^{
        [self enableSignInButton];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)enableSignInButton {
    signInButton.enabled = true;
}

- (IBAction)didTapSignInButton:(id)sender {
    [_linkedIn showLinkedInSignIn:^(NSDictionary *linkedInProfile) {
        [self transitionToProfileControllerWithProfile: linkedInProfile];
    }];
}

- (void)transitionToProfileControllerWithProfile: (NSDictionary *) profile {
    [_firebase saveLinkedInProfile:profile];
    [self performSegueWithIdentifier:@"profile" sender:self];
}

@end
