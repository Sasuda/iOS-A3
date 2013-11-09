//
//  CharacterCreationViewController.h
//  Assignment03-Sutherland
//
//  Created by Dan Sutherland on 2013-11-08.
//  Copyright (c) 2013 Dan Sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterCreationViewController : UIViewController

//Saving
-(NSString *) charactersPropertyListFilePath;//
//-(void)applicationWillResignActive:(NSNotification *)notification;

//Text fields
@property (weak, nonatomic) IBOutlet UITextField *characterNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *pointsLeftLabel;
@property (weak, nonatomic) IBOutlet UITextField *attackTextField;
@property (weak, nonatomic) IBOutlet UITextField *defenseTextField;
@property (weak, nonatomic) IBOutlet UITextField *speedTextField;
@property (weak, nonatomic) IBOutlet UITextField *agilityTextField;
@property (weak, nonatomic) IBOutlet UITextField *luckTextField;

//Leaving Text Field
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)textFieldNumberPadReturn:(id)sender;

//Actions of controls
//Name
- (IBAction)characterNameTextFieldChanged:(id)sender;
// Stats
// Attack
- (IBAction)attackStepperChanged:(UIStepper *)sender;
@property (weak, nonatomic) IBOutlet UIStepper *attackStepperOutlet;
- (IBAction)attackTextFieldChanged:(id)sender;
// Defense
- (IBAction)defenseStepperChanged:(UIStepper *)sender;
@property (weak, nonatomic) IBOutlet UIStepper *defenseStepperOutlet;
- (IBAction)defenseTextFieldChanged:(id)sender;
// Speed
- (IBAction)speedStepperChanged:(UIStepper *)sender;
@property (weak, nonatomic) IBOutlet UIStepper *speedStepperOutlet;
- (IBAction)speedTextFieldChanged:(id)sender;
//Agility
- (IBAction)agilityStepperChanged:(UIStepper *)sender;
@property (weak, nonatomic) IBOutlet UIStepper *agilityStepperOutlet;
- (IBAction)agilityTextFieldChanged:(id)sender;
// Luck
- (IBAction)luckStepperChanged:(UIStepper *)sender;
@property (weak, nonatomic) IBOutlet UIStepper *luckStepperOutlet;
- (IBAction)luckTextFieldChanged:(id)sender;
// Gender
- (IBAction)genderSegmentedControl:(id)sender;
//Finish
- (IBAction)saveCharacterButton:(id)sender;

@end
