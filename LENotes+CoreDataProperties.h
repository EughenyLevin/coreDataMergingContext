//
//  LENotes+CoreDataProperties.h
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LENotes+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LENotes (CoreDataProperties)

+ (NSFetchRequest<LENotes *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, retain) LEUser *user;

@end

NS_ASSUME_NONNULL_END
