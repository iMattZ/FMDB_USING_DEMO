//
//  PersonViewController.m
//  FMDB_USING_DEMO
//
//  Created by 张博文 on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import "PersonViewController.h"
#import "DataBase.h"
#import "Person.h"
#import "Card.h"
#import "CardViewController.h"
#import "PersonCardsViewController.h"
@interface PersonViewController ()

/**
 *  数据源
 */
@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addData)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"卡包" style:UIBarButtonItemStylePlain target:self action:@selector(watchCards)];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataArray = [[DataBase sharedDataBase] getAllPerson];
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    Person *person = self.dataArray[indexPath.row];
    if (person.number == 0) {
        cell.textLabel.text = person.name;
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@(第%ld次更新)",person.name,person.number];
    }
    
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"age: %ld",person.age];
    
    
    return cell;
    
    
    
}



/**
 *  设置删除按钮
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        Person *person = self.dataArray[indexPath.row];
        
        [[DataBase sharedDataBase] deletePerson:person];
        [[DataBase sharedDataBase] deleteAllCardsFromPerson:person];
        
        
        self.dataArray = [[DataBase sharedDataBase] getAllPerson];
        
        [self.tableView reloadData];
        
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PersonCardsViewController *pcvc = [[PersonCardsViewController alloc] init];
    pcvc.person = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:pcvc animated:YES];
    
    
    
    
    //    Person *person = self.dataArray[indexPath.row];
    //
    //    person.name = [NSString stringWithFormat:@"%@",person.name];
    //
    //    person.age = arc4random_uniform(100) + 1;
    //    [[DataBase sharedDataBase] updatePerson:person];
    //
    //    self.dataArray = [[DataBase sharedDataBase] getAllPerson];
    //
    //    [self.tableView reloadData];
    
}



#pragma mark - Action
/**
 *  添加数据到数据库
 */
- (void)addData{
    
    NSLog(@"addData");
    
    int nameRandom = arc4random_uniform(1000);
    NSInteger ageRandom  = arc4random_uniform(100) + 1;
    
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"张三",@"李四",@"王五",@"赵六",@"刘七",@"孙八", nil];
    NSInteger index = arc4random_uniform((int)nameArray.count);
    NSString *name = [nameArray objectAtIndex:index];//[NSString stringWithFormat:@"person_%d号",nameRandom];
    NSInteger age = ageRandom;
    
    Person *person = [[Person alloc] init];
    person.name = name;
    person.age = age;
    
    
    [[DataBase sharedDataBase] addPerson:person];
    
    self.dataArray = [[DataBase sharedDataBase] getAllPerson];
    
    
    
    
    
    [self.tableView reloadData];
    
    
}
- (void)watchCards{
    
    CardViewController *carVc = [[CardViewController alloc] init];
    
    [self.navigationController pushViewController:carVc animated:YES];
}


#pragma mark - Getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
    
}




@end
