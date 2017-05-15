//
//  LEUser+CoreDataProperties.h
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LEUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LEUser (CoreDataProperties)

+ (NSFetchRequest<LEUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, retain) NSSet<LENotes *> *notes;

@end

@interface LEUser (CoreDataGeneratedAccessors)

- (void)addNotesObject:(LENotes *)value;
- (void)removeNotesObject:(LENotes *)value;
- (void)addNotes:(NSSet<LENotes *> *)values;
- (void)removeNotes:(NSSet<LENotes *> *)values;

@end

NS_ASSUME_NONNULL_END
