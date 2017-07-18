//
//  DMChatVC.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMChatVC.h"

#import "DMDialogHolder.h"

#import "DMMessageCell.h"
#import "DMMessageCellFactory.h"
#import <CoreLocation/CoreLocation.h>

@interface DMChatVC () <UICollectionViewDelegateFlowLayout, DMDialogHolderDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UIView *textInputView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *optionsButton;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) DMDialogHolder *dialogHolder;

@end

@implementation DMChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.companion.name;
    
    self.dialogHolder = [[DMDialogHolder alloc] initWithCompanion:self.companion];
    self.dialogHolder.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    [self setOptionLoading:NO];
    
    [DMMessageCellFactory registerNibsForTableView:self.tableView];
    
    self.textInput.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self viewDidLoad];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dialogHolder.fetchedResultsController.fetchedObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DMMessage *message = self.dialogHolder.fetchedResultsController.fetchedObjects[indexPath.row];
    return [DMMessageCellFactory estimatedHeightForCellWithMessage:message forScreenWidth:self.view.frame.size.width];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.textInputView.frame.size.height;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.textInputView;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DMMessage *message = self.dialogHolder.fetchedResultsController.fetchedObjects[indexPath.row];
    DMMessageCell *cell = [DMMessageCellFactory dequeueCellWithMessage:message forTableView:tableView];
    
    [cell setupWith:message];
    
    return cell;
}

#pragma mark - Controls

- (IBAction)optionsPressed:(UIButton *)sender {
    
    [self openDropDownFrom:sender];
    
}

- (void)openDropDownFrom:(UIButton *)button {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *imageAction = [UIAlertAction actionWithTitle:@"Choose image from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePicker:button];
    }];
    
    UIAlertAction *geolocationAction = [UIAlertAction actionWithTitle:@"Check-In" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendGeolocation];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:imageAction];
    [alertController addAction:geolocationAction];
    [alertController addAction:cancelAction];
    
    alertController.popoverPresentationController.sourceView = button;
    alertController.popoverPresentationController.sourceRect = button.bounds;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showImagePicker:(UIButton *)button {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.modalPresentationStyle = UIModalPresentationPopover;
    imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    UIPopoverPresentationController *presentationController = imagePickerController.popoverPresentationController;
    presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    presentationController.sourceView = button;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)sendGeolocation {
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestLocation];
    [self setOptionLoading:YES];
}

- (void)setOptionLoading:(BOOL)isLoading {
    self.optionsButton.hidden = isLoading;
    self.activityIndicator.hidden = !isLoading;
    isLoading ? [self.activityIndicator startAnimating] : [self.activityIndicator stopAnimating];
}

- (IBAction)sendPressed:(id)sender {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self.dialogHolder sendTextMessage:self.textInput.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.dialogHolder sendTextMessage:self.textInput.text];
    return YES;
}

#pragma mark - Dialog Holder Delegate

- (void)messageSent {
    self.textInput.text = nil;
}

- (void)insertObjectForIndexPath:(NSIndexPath *)indexPath {
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark - Image Picker Controller Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([(NSString *)[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
        
        [self.dialogHolder sendImageMessage:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Location Controller Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self setOptionLoading:NO];
    
    NSLog(@"%@", locations);
    CLLocation *locataion = [locations firstObject];
    [self.dialogHolder sendGeolocationMessage:locataion];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self setOptionLoading:NO];
    
    NSLog(@"%@", error);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't check-in" message:[NSString stringWithFormat:@"Error appeared 😔. %@", error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
