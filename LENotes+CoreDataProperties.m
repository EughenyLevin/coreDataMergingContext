//
//  LENotes+CoreDataProperties.m
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LENotes+CoreDataProperties.h"

@implementation LENotes (CoreDataProperties)

+ (NSFetchRequest<LENotes *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LENotes"];
}

@dynamic title;
@dynamic content;
@dynamic user;

@end
