//
//  LECurrentNoteController.m
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LECurrentNoteController.h"

@interface LECurrentNoteController ()<UITextFieldDelegate>

@property (strong,nonatomic) UITextView  *contentView;
@property (strong,nonatomic) UITextField *titleField;
@property (strong,nonatomic) NSManagedObjectContext *myContext;
@property (strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation LECurrentNoteController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize context = _context;

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    [self naviBarSetup];
    
    _context = [[LEDataManager sharedManager]getCurrenContext];
    
    self.myContext =[[LEDataManager sharedManager]getCurrenContext];

    self.titleField.text  = self.note.title;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 130, 30)];
    titleLabel.text = @"Current title:";
    [self.view addSubview:titleLabel];
    
    self.titleField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-30, 5, 150, 100)];
    self.titleField.text = [NSString stringWithFormat:@"%@",self.note.title];
    self.titleField.returnKeyType = UIReturnKeyDone;
    self.titleField.delegate = self;
    
    [self.titleField.layer setBorderColor:[[[UIColor yellowColor]colorWithAlphaComponent:0.4]CGColor]];
    [self.titleField.layer setBorderWidth:1.4];
    self.titleField.layer.cornerRadius = 10;
    self.titleField.clipsToBounds = YES;
    
    [self.view addSubview:self.titleField];
      
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTouch)];
    [self.view addGestureRecognizer:tap];
    
   _contentView = [[UITextView alloc]initWithFrame:CGRectMake(20, 120, CGRectGetMaxX(self.view.bounds)-40, 300)];
    self.contentView.text = self.note.content;
     self.contentView.alpha = 1;
     self.contentView.font =  [UIFont boldSystemFontOfSize:20.0];
     self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView.layer setBorderColor:[[[UIColor greenColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.contentView.layer setBorderWidth:2.0];
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = YES;
    
    [self.view addSubview: self.contentView];
    
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextDidSaveNotification object:_myContext];
}



-(void)contextChanged:(NSNotification*)note{
    
    SEL selector = @selector(mergeChangesFromContextDidSaveNotification:);
    //NSManagedObjectContext *moc = [self createNewManagedObjectContext];
    
   // [moc performSelectorOnMainThread:selector withObject:note waitUntilDone:YES];
    [self.context performSelectorOnMainThread:selector withObject:note waitUntilDone:YES];
}

- (NSManagedObjectContext*)createNewManagedObjectContext
{
    _myContext = [[LEDataManager sharedManager]getCurrenContext];
   // self.myContext.persistentStoreCoordinator = [[LEDataManager sharedManager]getCurrentCoordinator];
    [self.myContext setUndoManager:nil];
    //self.myContext.parentContext = self.context;
    return self.myContext;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

-(void)onSave{
    
    self.note.title = self.titleField.text;
    self.note.content = self.contentView.text;
    [self.myContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (resultString.length>15) {
        [[[UIAlertView alloc]initWithTitle:@"Attention" message:@"Too long title!"
                                  delegate:self
                         cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        return NO;
       
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.titleField]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark Touches

-(void)onTouch{
    [self.titleField resignFirstResponder];
}

-(void)naviBarSetup{
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onSave)];
    self.navigationItem.rightBarButtonItem = save;
}


-(void)changeTitle:(UITextField*)sender{
    
  /*  NSLog(@"Change!");
    self.note.title = sender.text;
    self.note.content = @"BLA_BAL";
   [self.myContext save:nil];
    [self createNewManagedObjectContext];
   */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     //   [self.context save:nil];
}


@end
