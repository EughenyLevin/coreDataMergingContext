//
//  LEDataManager.h
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LEUser+CoreDataClass.h"
#import "LENotes+CoreDataClass.h"

@interface LEDataManager : NSObject

+(instancetype)sharedManager;
-(NSManagedObjectContext*)getCurrenContext;
-(void)deleteObject:(id)obj;
- (void)saveContext;
-(NSPersistentStoreCoordinator*)getCurrentCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
@end
