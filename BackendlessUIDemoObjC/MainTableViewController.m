
#import "MainTableViewController.h"
#import "BackendlessUI/BackendlessUI.h"

#define APP_ID @""
#define API_KEY @""

#define SIGN_UP @"Sign up"
#define LOGIN @"Login"
#define SOCIAL_LOGIN @"Social login"
#define LOGOUT @"Logout"
#define RESTORE_PASSWORD @"Restore password"

// **************************************************

#define CREATE_OBJECT @"Create object"
#define UPDATE_OBJECT @"Update object"

#define BASIC_FIND @"Find"
#define ADVANCED_FIND @"Find + QB"
#define FIND_FIRST @"Find first"
#define ADVANCED_FIND_FIRST @"Find first + QB"
#define FIND_LAST @"Find last"
#define ADVANCED_FIND_LAST @"Find last + QB"
#define FIND_BY_ID @"Find by id"
#define ADVANCED_FIND_BY_ID @"Find by id + QB"
#define RETRIEVE_RELATION @"Retrieve relation 1:1"
#define RETRIEVE_RELATIONS @"Retrieve relations 1:N"

@interface MainTableViewController () {
    NSArray<NSString *> *functions;
}
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backendless.hostURL = @"http://api.backendless.com";
    [backendless initApp:APP_ID APIKey:API_KEY];
    [self setupFunctions];
}

- (void)setupFunctions {
    functions = @[SIGN_UP, LOGIN, SOCIAL_LOGIN, LOGOUT, RESTORE_PASSWORD, CREATE_OBJECT, UPDATE_OBJECT, BASIC_FIND, ADVANCED_FIND, FIND_FIRST, ADVANCED_FIND_FIRST, FIND_LAST, ADVANCED_FIND_LAST, FIND_BY_ID, ADVANCED_FIND_BY_ID, RETRIEVE_RELATION, RETRIEVE_RELATIONS];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [functions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FunctionCell" forIndexPath:indexPath];
    cell.textLabel.text = [functions objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *function = [functions objectAtIndex:indexPath.row];
    if ([function isEqualToString:SIGN_UP]) {
        BackendlessSignUpViewController *signUpVC = [BackendlessSignUpViewController new];
        [self.navigationController pushViewController:signUpVC animated:YES];
    }
    else if ([function isEqualToString:LOGIN]) {
        BackendlessLoginViewController *loginVC = [BackendlessLoginViewController new];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else if ([function isEqualToString:SOCIAL_LOGIN]) {
        BackendlessSocialLoginViewController *socialLoginVC = [BackendlessSocialLoginViewController new];
        [socialLoginVC configureWithFacebookLogin:YES googleLogin:YES twitterLogin:YES];
        [self.navigationController pushViewController:socialLoginVC animated:YES];
    }
    else if ([function isEqualToString:LOGOUT]) {
        BackendlessLogoutViewController *logoutVC = [BackendlessLogoutViewController new];
        [self.navigationController pushViewController:logoutVC animated:YES];
    }
    else if ([function isEqualToString:RESTORE_PASSWORD]) {
        BackendlessRestorePasswordViewController *restorePasswordVC = [BackendlessRestorePasswordViewController new];
        [self.navigationController pushViewController:restorePasswordVC animated:YES];
    }
    
    // **************************************************
    
    else if ([function isEqualToString:CREATE_OBJECT]) {
        BackendlessAddObjectViewController *createObjectVC = [BackendlessAddObjectViewController new];
        [createObjectVC configureWithTableName:@"TestTable" previousViewController:self];
        [self.navigationController pushViewController:createObjectVC animated:YES];
    }
    else if ([function isEqualToString:UPDATE_OBJECT]) {
        [[backendless.data ofTable:@"TestTable"] findFirst:^(NSDictionary *object) {
            BackendlessObjectDetailsViewController *updateObjectVC = [BackendlessObjectDetailsViewController new];
            [updateObjectVC configureWithTableName:@"TestTable" object:object previousViewController:self];
            [self.navigationController pushViewController:updateObjectVC animated:YES];
        } error:^(Fault *fault) {
            [[AlertViewController shared] showErrorAlert:fault :nil :self];
        }];
    }
    else if ([function isEqualToString:BASIC_FIND]) {
        BackendlessTableViewController *basicFindVC = [BackendlessTableViewController new];
        [basicFindVC configureWithTableName:@"TestTable"];
        [self.navigationController pushViewController:basicFindVC animated:YES];
    }
    else if ([function isEqualToString:ADVANCED_FIND]) {
        DataQueryBuilder *queryBuilder = [DataQueryBuilder new];
        [queryBuilder setSortBy:@[@"stringVal"]];
        BackendlessTableViewController *advancedFindVC = [BackendlessTableViewController new];
        [advancedFindVC configureWithTableName:@"TestTable" dataQueryBuilder:queryBuilder];
        [self.navigationController pushViewController:advancedFindVC animated:YES];
    }
    else if ([function isEqualToString:FIND_FIRST]) {
        BackendlessTableViewController *findFirstVC = [BackendlessTableViewController new];
        [findFirstVC configureWithTableName:@"TestTable" findFirst:YES];
        [self.navigationController pushViewController:findFirstVC animated:YES];
    }
    else if ([function isEqualToString:ADVANCED_FIND_FIRST]) {
        DataQueryBuilder *queryBuilder = [DataQueryBuilder new];
        [queryBuilder setRelationsDepth:1];
        BackendlessTableViewController *advancedFindFirstVC = [BackendlessTableViewController new];
        [advancedFindFirstVC configureWithTableName:@"TestTable" findFirst:YES dataQueryBuilder:queryBuilder];
        [self.navigationController pushViewController:advancedFindFirstVC animated:YES];
    }
    else if ([function isEqualToString:FIND_LAST]) {
        BackendlessTableViewController *findLastVC = [BackendlessTableViewController new];
        [findLastVC configureWithTableName:@"TestTable" findLast:YES];
        [self.navigationController pushViewController:findLastVC animated:YES];
    }
    else if ([function isEqualToString:ADVANCED_FIND_LAST]) {
        DataQueryBuilder *queryBuilder = [DataQueryBuilder new];
        [queryBuilder setRelationsDepth:1];
        BackendlessTableViewController *advancedFindLastVC = [BackendlessTableViewController new];
        [advancedFindLastVC configureWithTableName:@"TestTable" findLast:YES dataQueryBuilder:queryBuilder];
        [self.navigationController pushViewController:advancedFindLastVC animated:YES];
    }
    else if ([function isEqualToString:FIND_BY_ID]) {
        BackendlessTableViewController *findByIdVC = [BackendlessTableViewController new];
        [findByIdVC configureWithTableName:@"TestTable" findById:@"D09FB99F-2987-2127-FFAA-CA451C55DE00"];
        [self.navigationController pushViewController:findByIdVC animated:YES];
    }
    else if ([function isEqualToString:ADVANCED_FIND_BY_ID]) {
        DataQueryBuilder *queryBuilder = [DataQueryBuilder new];
        [queryBuilder setRelationsDepth:1];
        BackendlessTableViewController *advancedFindByIdVC = [BackendlessTableViewController new];
        [advancedFindByIdVC configureWithTableName:@"TestTable" findById:@"D09FB99F-2987-2127-FFAA-CA451C55DE00" dataQueryBuilder:queryBuilder];
        [self.navigationController pushViewController:advancedFindByIdVC animated:YES];
    }
    else if ([function isEqualToString:RETRIEVE_RELATION]) {
        [[backendless.data ofTable:@"TestTable"] findFirst:^(NSDictionary *object) {
            BackendlessRelationsViewController *retrieveRelationVC = [BackendlessRelationsViewController new];
            [retrieveRelationVC configureWithTableName:@"TestTable" relationsColumnName:@"user" parentObject:object];
            [self.navigationController pushViewController:retrieveRelationVC animated:YES];
        } error:^(Fault *fault) {
            [[AlertViewController shared] showErrorAlert:fault :nil :self];
        }];
    }
    else if ([function isEqualToString:RETRIEVE_RELATIONS]) {
        [[backendless.data ofTable:@"TestTable"] findFirst:^(NSDictionary *object) {
            BackendlessRelationsViewController *retrieveRelationsVC = [BackendlessRelationsViewController new];
            [retrieveRelationsVC configureWithTableName:@"TestTable" relationsColumnName:@"players" parentObject:object];
            [self.navigationController pushViewController:retrieveRelationsVC animated:YES];
        } error:^(Fault *fault) {
            [[AlertViewController shared] showErrorAlert:fault :nil :self];
        }];
    }
}

@end
