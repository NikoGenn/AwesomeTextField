//
//  ViewController.m
//  AwesomeTextFieldDemo
//
//  Created by NikoGenn on 22.07.15.
//  Copyright (c) 2015 OneMoreApp. All rights reserved.
//

#import "ViewController.h"
#import "AwesomeTextField.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet AwesomeTextField *aTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_aTextField resignFirstResponder];
}

@end
