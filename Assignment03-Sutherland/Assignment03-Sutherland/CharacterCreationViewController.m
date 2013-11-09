//
//  CharacterCreationViewController.m
//  Assignment03-Sutherland
//
//  Created by Dan Sutherland on 2013-11-08.
//  Copyright (c) 2013 Dan Sutherland. All rights reserved.
//

#import "CharacterCreationViewController.h"
#define  kFileName @"Characters.plist"

@interface CharacterCreationViewController ()

@end

@implementation CharacterCreationViewController
{
    NSMutableString *characterName, *displayPointsLeft, *genderString, *customizationFinishedMessage;
    int attackStat, defenseStat, speedStat, agilityStat, luckStat, pointsLeft, maxPoints;
}
@synthesize characterNameTextField,
pointsLeftLabel,
attackStepperOutlet,
attackTextField,
defenseStepperOutlet,
defenseTextField,
speedStepperOutlet,
speedTextField,
agilityStepperOutlet,
agilityTextField,
luckTextField,
luckStepperOutlet;

// Find the plist for Characters
-(NSString *) charactersPropertyListFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // initialize variables
    pointsLeft = 10;
    maxPoints = 10;
    displayPointsLeft = [[NSMutableString alloc] initWithFormat:@"Points :%d", pointsLeft];
    genderString = [NSMutableString alloc];
    genderString = [genderString initWithFormat:@"Male"];
    customizationFinishedMessage = [NSMutableString alloc];
    customizationFinishedMessage = [customizationFinishedMessage initWithFormat:@"Your Name Is: %@ \nAttack: %@ \nDefense: %@ \nSpeed: %@ \nAgility: %@ \nLuck: %@", characterName, attackTextField.text, defenseTextField.text, speedTextField.text, agilityTextField.text, luckTextField.text];
    pointsLeftLabel.text = displayPointsLeft;
    
    // Loading from a plist
    NSString *filePath = [self charactersPropertyListFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        /*// For loading characters
         characterNameTextField.text [array objectAtIndex:0];
         attackTextField.text [array objectAtIndex:1];
         defenseTextField.text [array objectAtIndex:2];
         speedTextField.text [array objectAtIndex:3];
         agilityTextField.text [array objectAtIndex:4];
         luckTextField.text [array objectAtIndex:5];
         genderString = [array objectAtIndex:5];
         */
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// --Methods--
// Text field returns
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)textFieldNumberPadReturn:(id)sender
{
    [attackTextField resignFirstResponder];
    [defenseTextField resignFirstResponder];
    [speedTextField resignFirstResponder];
    [agilityTextField resignFirstResponder];
    [luckTextField resignFirstResponder];
}
- (IBAction)characterNameTextFieldChanged:(id)sender
{
    characterName = [[NSMutableString alloc] initWithFormat:@"%@",characterNameTextField.text];
    //[characterName setString:[NSString stringWithFormat:(characterNameTextField.text)]];//[NSString stringWithFormat:(characterNameTextField.text)];
}


//Actions of controls
// **ATTACK**
- (IBAction)attackStepperChanged:(UIStepper *)sender
{
    UIStepper *attackSteppernumber = (UIStepper *)sender;
    attackTextField.text = [NSMutableString stringWithFormat:@"%.f", attackSteppernumber.value];// change the text of the field
    
    //adjust the values
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    attackSteppernumber.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}
- (IBAction)attackTextFieldChanged:(id)sender
{
    //adjust values
    if ([attackTextField.text doubleValue] > pointsLeft)
    {
        attackTextField.text = [NSMutableString stringWithFormat:@"%d", pointsLeft];
        pointsLeft = maxPoints
        - [attackTextField.text doubleValue]
        - [defenseTextField.text doubleValue]
        - [speedTextField.text doubleValue]
        - [agilityTextField.text doubleValue]
        - [luckTextField.text doubleValue];
        attackTextField.text = [NSMutableString stringWithFormat:@"%d", (pointsLeft + [attackTextField.text intValue])];
    }
    else if ([attackTextField.text doubleValue] < 0)
    {
        attackTextField.text = [NSMutableString stringWithFormat:@"%d", 0];
    }
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    
    // change the stepper value to match the text value
    attackStepperOutlet.value = [attackTextField.text doubleValue];
    //adjust stepper maximums
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}

// **DEFENSE**
- (IBAction)defenseStepperChanged:(UIStepper *)sender
{
    UIStepper *defenseSteppernumber = (UIStepper *)sender;
    
    defenseTextField.text = [NSString stringWithFormat:@"%.f", defenseSteppernumber.value];// change the text of the field
    pointsLeft = maxPoints
    
    //adjust the values
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    defenseSteppernumber.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}

// **SPEED**
- (IBAction)defenseTextFieldChanged:(id)sender
{
    //adjust values
    if ([defenseTextField.text doubleValue] > pointsLeft)
    {
        defenseTextField.text = [NSMutableString stringWithFormat:@"%d", pointsLeft];
        pointsLeft = maxPoints
        - [attackTextField.text doubleValue]
        - [defenseTextField.text doubleValue]
        - [speedTextField.text doubleValue]
        - [agilityTextField.text doubleValue]
        - [luckTextField.text doubleValue];
        defenseTextField.text = [NSMutableString stringWithFormat:@"%d", (pointsLeft + [defenseTextField.text intValue])];
    }
    else if ([defenseTextField.text doubleValue] < 0)
    {
        defenseTextField.text = [NSMutableString stringWithFormat:@"%d", 0];
    }
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    //
    defenseStepperOutlet.value = [defenseTextField.text doubleValue];
    //
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    //displayPointsLeft = [[NSMutableString alloc] initWithFormat:@"Points :%d", pointsLeft];
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}


- (IBAction)speedStepperChanged:(UIStepper *)sender
{
    UIStepper *speedSteppernumber = (UIStepper *)sender;
    // change the text of the field
    speedTextField.text = [NSMutableString stringWithFormat:@"%.f", speedSteppernumber.value];
    //adjust the values
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    speedSteppernumber.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}
- (IBAction)speedTextFieldChanged:(id)sender
{
    //adjust values
    if ([speedTextField.text doubleValue] > pointsLeft)
    {
        speedTextField.text = [NSMutableString stringWithFormat:@"%d", pointsLeft];
        pointsLeft = maxPoints
        - [attackTextField.text doubleValue]
        - [defenseTextField.text doubleValue]
        - [speedTextField.text doubleValue]
        - [agilityTextField.text doubleValue]
        - [luckTextField.text doubleValue];
        speedTextField.text = [NSMutableString stringWithFormat:@"%d", (pointsLeft + [speedTextField.text intValue])];
    }
    else if ([speedTextField.text doubleValue] < 0)
    {
        speedTextField.text = [NSMutableString stringWithFormat:@"%d", 0];
    }
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    
    //
    speedStepperOutlet.value = [speedTextField.text doubleValue];
    //
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}

//  **AGILTY**
- (IBAction)agilityStepperChanged:(UIStepper *)sender
{
    UIStepper *agilitySteppernumber = (UIStepper *)sender;
    // change the text of the field
    agilityTextField.text = [NSMutableString stringWithFormat:@"%.f", agilitySteppernumber.value];
    
    //adjust the values
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    agilitySteppernumber.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}
- (IBAction)agilityTextFieldChanged:(id)sender
{
    //adjust values
    if ([agilityTextField.text doubleValue] > pointsLeft)
    {
        agilityTextField.text = [NSMutableString stringWithFormat:@"%d", pointsLeft];
        pointsLeft = maxPoints
        - [attackTextField.text doubleValue]
        - [defenseTextField.text doubleValue]
        - [speedTextField.text doubleValue]
        - [agilityTextField.text doubleValue]
        - [luckTextField.text doubleValue];
        agilityTextField.text = [NSMutableString stringWithFormat:@"%d", (pointsLeft + [agilityTextField.text intValue])];
    }
    else if ([agilityTextField.text doubleValue] < 0)
    {
        agilityTextField.text = [NSMutableString stringWithFormat:@"%d", 0];
    }
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    
    //
    agilityStepperOutlet.value = [agilityTextField.text doubleValue];
    //
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}

// **LUCK**
- (IBAction)luckStepperChanged:(UIStepper *)sender
{
    UIStepper *luckSteppernumber = (UIStepper *)sender;
    // change the text of the field
    luckTextField.text = [NSMutableString stringWithFormat:@"%.f", luckSteppernumber.value];
    
    //adjust the values
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    luckSteppernumber.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}
- (IBAction)luckTextFieldChanged:(id)sender
{
    //adjust values
    if ([luckTextField.text doubleValue] > pointsLeft)
    {
        luckTextField.text = [NSString stringWithFormat:@"%d", pointsLeft];
        pointsLeft = maxPoints
        - [attackTextField.text doubleValue]
        - [defenseTextField.text doubleValue]
        - [speedTextField.text doubleValue]
        - [agilityTextField.text doubleValue]
        - [luckTextField.text doubleValue];
        luckTextField.text = [NSString stringWithFormat:@"%d", (pointsLeft + [luckTextField.text intValue])];
    }
    else if ([luckTextField.text doubleValue] < 0)
    {
        luckTextField.text = [NSString stringWithFormat:@"%d", 0];
    }
    pointsLeft = maxPoints
    - [attackTextField.text doubleValue]
    - [defenseTextField.text doubleValue]
    - [speedTextField.text doubleValue]
    - [agilityTextField.text doubleValue]
    - [luckTextField.text doubleValue];
    
    //
    luckStepperOutlet.value = [luckTextField.text doubleValue];
    //
    attackStepperOutlet.maximumValue = [attackTextField.text doubleValue] + pointsLeft;
    defenseStepperOutlet.maximumValue = [defenseTextField.text doubleValue] + pointsLeft;
    speedStepperOutlet.maximumValue = [speedTextField.text doubleValue] + pointsLeft;
    agilityStepperOutlet.maximumValue = [agilityTextField.text doubleValue] + pointsLeft;
    luckStepperOutlet.maximumValue = [luckTextField.text doubleValue] + pointsLeft;
    
    // Change the displayed points left label
    [displayPointsLeft setString:[NSString stringWithFormat:@"Points :%d", pointsLeft]];
    pointsLeftLabel.text = displayPointsLeft;
}

// ** GENDER **
- (IBAction)genderSegmentedControl:(id)sender
{
    if([sender selectedSegmentIndex] == 0)
    {
        [genderString setString:@"Male"];
    }
    else if([sender selectedSegmentIndex] == 1)
    {
        [genderString setString:@"Female"];
    }
}

- (IBAction)saveCharacterButton:(id)sender
{
    [customizationFinishedMessage setString:[NSString stringWithFormat:@"Your Name Is: %@ \nGender: %@ \nAttack: %@ \nDefense: %@ \nSpeed: %@ \nAgility: %@ \nLuck: %@", characterName, genderString, attackTextField.text, defenseTextField.text, speedTextField.text, agilityTextField.text, luckTextField.text]]; // CHANGES THE STRING EVERY TIME BUTTON IS PRESSED
    // customizationFinishedMessage = [[NSMutableString alloc] initWithFormat:@"Your Name Is: %@ \nAttack: %@ \nDefense: %@ \nSpeed: %@ \nAgility: %@ \nLuck: %@", characterName, attackTextField.text, defenseTextField.text, speedTextField.text, agilityTextField.text, luckTextField.text]; // CREATES A NEW MUTABLE STRING EVERY TIME THE BUTTON IS PRESSED
    
    UIAlertView *customizationFinishedAlert = [[UIAlertView alloc]initWithTitle:@"Customization Finished" message:customizationFinishedMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [customizationFinishedAlert show];
    
}


-(IBAction)doneWithCharacterCreation:(UIStoryboardSegue *) segue
{
    /*
     if([segue.identifier isEqualToString:@"characterCreationSegue" ])
     {
     //ProvinceViewController *viewController    =   segue.sourceViewController;
     //NSInteger selectedRow = [viewController.provincePicker selectedRowInComponent:0];
     //NSString *provinceName = viewController.provinceArray[selectedRow];
     
     //NSDate *selectedDate = viewController.birthdatePicker.date;
     //NSDateFormatter *dateFormatter = [NSDateFormatter new];
     //[dateFormatter setDateFormat:@"MMM dd, yyyy"];
     //self.provinceTextField.text = [NSString viewController.provincePicker ];
     }*/
}



/* //
 -(void)applicationWillResignActive:(NSNotification *)notification
 {
 NSMutableArray *array = [[NSMutableArray alloc] init];
 }
 */
@end
