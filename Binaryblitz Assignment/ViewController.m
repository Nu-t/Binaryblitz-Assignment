//
//  ViewController.m
//  Binaryblitz Assignment
//
//  Created by Nikolay on 09.02.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import "ViewController.h"
#import <JSONModelLib.h>
#import <AFNetworking.h>
#import "Users.h"
#import "DetailedUser.h"


@interface ViewController ()
@property (strong, nonatomic) NSArray * userList;
@property (assign, nonatomic) NSInteger indexpath;
@property (strong, nonatomic) DetailedUser * detailedUserList;

@end

@implementation ViewController

- (void)viewDidLoad {
    //[self postRequest];
    [super viewDidLoad];
    [self.UITableView reloadData];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)getUserDetail:(id)sender {

    Users * user = [_userList objectAtIndex:_indexpath];
    NSLog(@"row %ld, with id: %ld" , (long)_indexpath, (long)user.id);
    
    _detailedUserList = [[DetailedUser alloc] initFromURLWithString:[NSString stringWithFormat:@"http://test.binaryblitz.ru/users/%ld.json",(long)user.id] completion:^(JSONModel *model, JSONModelError *err) {
        
        NSString *currentDate = [NSString stringWithFormat:@"%@", _detailedUserList.created_at];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
        NSDate *neededDate = [dateFormatter dateFromString:currentDate];
        NSLog(@"%@", neededDate);
        
        NSString* userInfo = [NSString stringWithFormat:@"Name: %@\n Surname: %@\n Info: %@\n Created at: %@",_detailedUserList.name, _detailedUserList.surname, _detailedUserList.info, neededDate];
        
        
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Detailed info"
                                      message:userInfo
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* done = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:done];
        [self presentViewController:alert animated:YES completion:nil];

    }];

    
    
}




- (IBAction)fetchData:(id)sender {
    [self fetchUsers];
    
}

-(void)postRequest{
    NSURL *baseURL = [NSURL URLWithString:@"http://test.binaryblitz.ru/"];
    NSString *path = @"uploads";
    NSString *UDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%@",UDID] forKey:@"imei"];
    [parameters setObject:@"hello world" forKey:@"message"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [manager POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

- (void)fetchUsers {
    NSURL* url = [NSURL URLWithString:@"http://test.binaryblitz.ru/users.json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            self.userList = [Users arrayOfModelsFromData:data error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.UITableView reloadData];
        });
    
    }] resume];
    
}

#pragma mark Table-View Data

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_userList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _indexpath= indexPath.row;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Users * user = [_userList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.name, user.surname];
    return cell;

}

@end
