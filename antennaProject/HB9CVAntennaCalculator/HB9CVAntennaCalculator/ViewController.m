//
//  ViewController.m
//  HB9CVAntennaCalculator
//
//  Created by Andreas Falkenberg on 4/16/15.
//  Copyright (c) 2015 Andreas Falkenberg. All rights reserved.
//
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.

//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.

//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//


#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Rvalue;
@property (weak, nonatomic) IBOutlet UILabel *Svalue;
@property (weak, nonatomic) IBOutlet UILabel *SSvalue;
@property (weak, nonatomic) IBOutlet UILabel *Avalue;
@property (weak, nonatomic) IBOutlet UILabel *RSvalue;
@property (weak, nonatomic) IBOutlet UILabel *Xvalue;



@property (weak, nonatomic) IBOutlet UILabel *mhzVsBandLabel;

@property (weak, nonatomic) IBOutlet UITextField *inputValue;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapOnBackground;

@end

@implementation ViewController


float r;
float s;
float ss;
float a;
float x;
float rs;

float freq;
float meter;

NSInteger meterVsFeet;
NSInteger meterVsFrequency;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)input:(id)sender
{
    
    
    [self updateEverything];
    
}


- (IBAction)meterVsFeetChanged:(id)sender {

    meterVsFeet = [sender selectedSegmentIndex];
    
    [self updateEverything];
    
}





- (IBAction)frequencyVsBandSwitch:(id)sender
{

    NSString *inputString = _inputValue.text;
    float inp;
    inp = [inputString floatValue];
    
    
    meterVsFrequency = [sender selectedSegmentIndex];
    
    
    if(meterVsFrequency == 1)

    {
        [_mhzVsBandLabel setText:@"Mhz"];
        
        inp = 300.0/inp;
        NSString *temp = [NSString stringWithFormat:@"%.2f", inp];
        
        _inputValue.text = temp;
    }
    else
    {
        [_mhzVsBandLabel setText:@"meter"];

        inp = 300.0/inp;
        NSString *temp = [NSString stringWithFormat:@"%.2f", inp];

        _inputValue.text = temp;
        
        
    }
    
    [self updateEverything];
    
}


-(void)calculate:(float) input
{
    /// calc frequency first ///
    if(meterVsFrequency == 1)
    {
        freq = input;
    }
    else
    {
        freq = 300.0/input;
    }
    
    r = 150.0/freq;
    s = 139.0/freq;
    rs = 0.076 * (300.0 / freq);
    ss = 0.072 * (300.0 / freq);
    a  = 0.125 * (300.0 /freq);
    
    
    if(meterVsFeet  == 1)
    {
        r = 3.28084 * r;
        s = 3.28084 * s;
        rs = 3.28084 * rs;
        ss = 3.28084 * ss;
        a = 3.28084 * a;
    }
    
    x  = rs + ss + a;

    
}


-(void)updateEverything
{
    NSString *inputString = _inputValue.text;
    float inp;
    inp = [inputString floatValue];
    
    
    [self calculate :inp ];
    
    NSString *morf = @"m";
    if(meterVsFeet == 0)
    {
        morf = @"m";
    }
    else
    {
        morf = @"ft";
    }
    
    
    NSString *xString = [NSString stringWithFormat:@"%.2f %@", x,morf];
    NSString *sString = [NSString stringWithFormat:@"%.2f %@", s,morf];
    NSString *ssString = [NSString stringWithFormat:@"%.2f %@", ss,morf];
    NSString *rString = [NSString stringWithFormat:@"%.2f %@", r,morf];
    NSString *rsString = [NSString stringWithFormat:@"%.2f %@", rs,morf];
    NSString *aString = [NSString stringWithFormat:@"%.2f %@", a,morf];
    
    
    [_Rvalue setText: rString];
    [_Svalue setText: sString];
    [_RSvalue setText: rsString];
    [_SSvalue setText: ssString];
    [_Avalue setText: aString];
    [_Xvalue setText: xString];
    
    
}

- (IBAction)tapOnBackgroundFunction:(id)sender
{

    [self dismissKeyboard];
}

-(void)dismissKeyboard
{
    [_inputValue resignFirstResponder];

}



@end
