#import "SignInController.h"
#import "LinkedInClient.h"

@interface SignInController ()

@end

@implementation SignInController {
    LinkedInClient *_client;
}

@synthesize signInButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    signInButton.enabled = false;
    
    [_client attemptToSignInFromSavedTokenWithSuccess:^(NSDictionary *linkedInProfile) {
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
    
}

- (void)transitionToProfileControllerWithProfile: (NSDictionary *) profile {
    [self performSegueWithIdentifier:@"profile" sender:self];
}

@end
