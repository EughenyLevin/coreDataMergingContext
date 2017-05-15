//
//  LEUser+CoreDataProperties.m
//  Laba11CoreData
//
//  Created by Evgheny on 23.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "LEUser+CoreDataProperties.h"

@implementation LEUser (CoreDataProperties)

+ (NSFetchRequest<LEUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LEUser"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic notes;

@end
