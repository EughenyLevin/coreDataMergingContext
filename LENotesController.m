//
//  LENotesController.m
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LENotesController.h"
#import "LEDataManager.h"
#import "LEUserController.h"
#import "LECurrentNoteController.h"

@interface LENotesController ()

@end



@implementation LENotesController
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize context = _context;



- (void)viewDidLoad {
    [super viewDidLoad];
    _context = [[LEDataManager sharedManager]getCurrenContext];
    UIBarButtonItem *addBur = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addObject:)];
    self.navigationItem.rightBarButtonItem =  addBur;
}

-(void)addObject:(id)sender{
    
    LENotes *note = [NSEntityDescription insertNewObjectForEntityForName:@"LENotes" inManagedObjectContext:self.context];
    note.title = @"New note";
    
    [self.user addNotesObject:note];
    [self.context save:nil];
    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.user.notes.count;
}
- (NSFetchedResultsController*)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    _fetchedResultsController  = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"LENotes" inManagedObjectContext:self.context];
    
    [fetchRequest setEntity:description];
    
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user == %@",self.user];
    [fetchRequest setPredicate:predicate];
    
    // NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:NULL cacheName:nil];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:NULL cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    return _fetchedResultsController;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LENotes *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    LECurrentNoteController *uc = [LECurrentNoteController new];
    uc.note =note;
    
    [self.navigationController pushViewController:uc animated:YES];
    
    
}

#pragma mark - UITableViewDataSource

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath{
    LENotes *note    = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = nil;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
