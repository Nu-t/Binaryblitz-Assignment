//
//  Users.h
//  Binaryblitz Assignment
//
//  Created by Nikolay on 09.02.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Users : JSONModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* surname;
@property (assign, nonatomic) NSInteger id;

@end
