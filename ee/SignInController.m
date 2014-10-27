#import "SignInController.h"
#import "LinkedInClient.h"
#import "FirebaseClient.h"
#import "MainController.h"

@interface SignInController ()
@end

@implementation SignInController {
    LinkedInClient *_linkedIn;
    FirebaseClient *_firebase;
    LinkedInProfile *_profile;
}
@synthesize spinner;

@synthesize signInButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    signInButton.hidden = true;

    _linkedIn = [[LinkedInClient alloc] init];
    _firebase = [[FirebaseClient alloc] init];
    
    [_linkedIn attemptToSignInFromSavedTokenWithSuccess:^(LinkedInProfile *linkedInProfile) {
        [self transitionToProfileControllerWithProfile: linkedInProfile];
    } andNoSavedToken:^{
        [self enableSignInButton];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)enableSignInButton {
    signInButton.hidden = false;
    spinner.hidden = true;
}

- (IBAction)didTapSignInButton:(id)sender {
    [_linkedIn showLinkedInSignIn:^(LinkedInProfile *linkedInProfile) {
        [self transitionToProfileControllerWithProfile: linkedInProfile];
    } orWhenCancelled:^{
        [self enableSignInButton];
    }];
}

- (void)transitionToProfileControllerWithProfile: (LinkedInProfile *) profile {
    [_firebase saveLinkedInProfileWithId:[profile linkedInUserId] andProfile:[profile asDictionary]];
    _profile = profile;
    [self performSegueWithIdentifier:@"main" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"main"]) {
        MainController *mainController = [segue destinationViewController];
        [mainController setProfile:_profile];
    }
}

@end
