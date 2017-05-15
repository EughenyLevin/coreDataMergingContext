//
//  LERootController.h
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface LERootController : UITableViewController<NSFetchedResultsControllerDelegate>

#pragma propertiesDeclaration 

@property (strong,nonatomic) NSManagedObjectContext*context;
@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;

#pragma methodDeclaration

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath;


@end
