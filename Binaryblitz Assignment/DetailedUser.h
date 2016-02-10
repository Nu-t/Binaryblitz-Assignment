//
//  DetailedUser.h
//  Binaryblitz Assignment
//
//  Created by Nikolay on 10.02.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DetailedUser : JSONModel
@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* surname;
@property (strong, nonatomic) NSString* info;
@property (strong, nonatomic) NSString* created_at;
@end
