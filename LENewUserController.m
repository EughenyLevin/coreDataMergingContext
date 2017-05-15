//
//  LENewUserController.m
//  Laba11CoreData
//
//  Created by Evgheny on 28.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LENewUserController.h"
#import "LEDataManager.h"

@interface LENewUserController ()<UITextFieldDelegate>
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) LEUser *user;
@property (strong,nonatomic) UITextField *nameField;
@property (strong,nonatomic) UITextField *sonameField;
@end

@implementation LENewUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _context = [[LEDataManager sharedManager]getCurrenContext];
    
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(120, 80, 160, 50)];
    _nameField.returnKeyType = UIReturnKeyNext;
    _nameField.delegate = self;
    _nameField.backgroundColor = [UIColor whiteColor];
    _nameField.clipsToBounds = NO;
    _nameField.layer.masksToBounds = NO;
    _nameField.layer.shadowColor = [UIColor redColor].CGColor;
    _nameField.layer.shadowOffset = CGSizeMake(1, 1);
    _nameField.layer.shadowOpacity =1;
    _nameField.layer.shadowRadius = 2;
    [self.view addSubview:_nameField];
    
    
    _sonameField = [[UITextField alloc]initWithFrame:CGRectMake(120, 140, 160, 50)];
    _sonameField.returnKeyType = UIReturnKeyDone;
    _sonameField.backgroundColor = [UIColor whiteColor];
    _sonameField.clipsToBounds = NO;
    _sonameField.layer.masksToBounds = NO;
    _sonameField.layer.shadowColor = [UIColor orangeColor].CGColor;
    _sonameField.layer.shadowOffset = CGSizeMake(1, 1);
    _sonameField.layer.shadowOpacity =1;
    _sonameField.layer.shadowRadius = 2;
    [self.view addSubview:_sonameField];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 80, 70, 70)];
    nameLabel.text = @"Name:";
    [self.view addSubview:nameLabel];
    
    UILabel *sonameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, 70,70)];
    sonameLabel.text = @"Soname:";
    [self.view addSubview:sonameLabel];
    
    _user = [NSEntityDescription insertNewObjectForEntityForName:@"LEUser" inManagedObjectContext:self.context];
    
    [_nameField addTarget:self action:@selector(saveValue:) forControlEvents:(UIControlEvents)UITextFieldTextDidChangeNotification];
    [_sonameField addTarget:self action:@selector(saveSoname:) forControlEvents:(UIControlEvents)UITextFieldTextDidChangeNotification];
}


-(void)saveValue:(UITextField*)sender{
    
    self.user.firstName = sender.text;
    [self.context save:nil];
}

-(void)saveSoname:(UITextField*)sender{
    self.user.lastName = sender.text;
    [self.context save:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.nameField]) {
        self.user.firstName = textField.text;
        [self.context save:nil];
        [self.sonameField becomeFirstResponder];
        return NO;
    }
    else if ([textField isEqual:self.sonameField]){
        self.user.lastName = textField.text;
        [self.context save:nil];
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
