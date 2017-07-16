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

@interface DMChatVC () <UICollectionViewDelegateFlowLayout, DMDialogHolderDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UIView *textInputView;

@property (strong, nonatomic) DMDialogHolder *dialogHolder;

@end

@implementation DMChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.companion.name;
    
    self.dialogHolder = [[DMDialogHolder alloc] initWithCompanion:self.companion];
    self.dialogHolder.delegate = self;
    
    for (Class viewClass in [DMMessageCellFactory cellClasses]) {
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(viewClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(viewClass)];
    }
    
    self.textInput.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dialogHolder.fetchedResultsController.fetchedObjects.count;
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
        [self showImagePicker];
    }];
    
    UIAlertAction *geolocationAction = [UIAlertAction actionWithTitle:@"Send your geolocation" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:imageAction];
    [alertController addAction:geolocationAction];
    [alertController addAction:cancelAction];
    
    alertController.popoverPresentationController.sourceView = button;
    alertController.popoverPresentationController.sourceRect = button.bounds;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showImagePicker {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.modalPresentationStyle = UIModalPresentationPopover;
    imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    UIPopoverPresentationController *presentationController = imagePickerController.popoverPresentationController;
    presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)sendPressed:(id)sender {
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
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.dialogHolder sendImageMessage:image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
