//
//  LEUserController.m
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LEUserController.h"
#import "LEDataManager.h"
#import "LENotesController.h"
#import "LENewUserController.h"

@interface LEUserController ()

@end

@implementation LEUserController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize context = _context;

- (void)viewDidLoad {
    [super viewDidLoad];
    _context = [[LEDataManager sharedManager]getCurrenContext];
  
    UIBarButtonItem *addBur = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addObject:)];
    self.navigationItem.rightBarButtonItem =  addBur;
    self.navigationItem.title = @"Users:";
}
-(void)addObject:(id)sender{
    
    /*LEUser *user = [NSEntityDescription insertNewObjectForEntityForName:@"LEUser" inManagedObjectContext:self.context];
   user.firstName = @"New";
   user.lastName = @"User";
    
    [self.context save:nil];
      */
   // LEUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    LENewUserController *vc = [[LENewUserController alloc]init];
   // vc.user = user;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (NSFetchedResultsController*)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    _fetchedResultsController  = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"LEUser" inManagedObjectContext:self.context];
    
    [fetchRequest setEntity:description];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:NULL cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
      
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    return _fetchedResultsController;
}
#pragma mark - UITableViewDataSource

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    LEUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",user.notes.count];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LEUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    LENotesController *vc = [[LENotesController alloc]init];
    vc.user = user;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }


@end
