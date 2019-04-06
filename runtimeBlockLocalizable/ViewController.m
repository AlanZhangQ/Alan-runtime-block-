//
//  ViewController.m
//  runtimeBlockLocalizable
//
//  Created by Alan on 2019/4/2.
//  Copyright © 2019年 Alan. All rights reserved.
//
//
#import "ViewController.h"
#import "MultiLanguageBlockButton.h"
#import <objc/message.h>

static void *toBeBorneAlert = "toBeBorneAlert";
static void *insuredChangeToMother = "insuredChangeToMother";

typedef void (^actionBlock)(NSInteger integer);

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *languageList;

@property (nonatomic, strong) UIButton *showLanguage;

@property (nonatomic, strong) UIButton *showAlert;

@property (nonatomic, strong) UIAlertController *alert;

@property (nonatomic, strong) UIAlertController *alert1;


@end

@implementation ViewController

- (NSArray *)languageList
{
    if (!_languageList)
    {
        _languageList = [NSArray arrayWithObjects:@"English", @"Zh_CN", @"ZH_HK", nil];
    }
    return _languageList;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset=UIEdgeInsetsMake(0,0, 0, 0);
        _tableView.frame = CGRectMake(CGRectGetMinX(self.showLanguage.frame), CGRectGetMaxY(self.showLanguage.frame), CGRectGetWidth(self.showLanguage.frame), 132);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.languageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *brand_region_Cell = @"MyCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:brand_region_Cell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:@"MyCell" ];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor yellowColor];
        NSString *langauge = [self.languageList objectAtIndex:indexPath.row];
        cell.textLabel.text = langauge;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self changeLanguageTo:@"en"];
 
    } else if (indexPath.row == 1)
    {
        [self changeLanguageTo:@"zh-Hans"];
        
    } else if (indexPath.row == 2)
    {
        [self changeLanguageTo:@"zh-Hant"];
        
    }
    [self.tableView removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.showLanguage = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 200, 100)];
    self.showLanguage.backgroundColor = [UIColor redColor];
    self.showLanguage.center = self.view.center;
    [self.showLanguage setTitle:ZQ_LocalizedString(@"switch language") forState:UIControlStateNormal];
    [self.showLanguage addTarget:self action:@selector(showLanguageList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showLanguage];
    self.showAlert = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.showLanguage.frame), CGRectGetMinY(self.showLanguage.frame)- 200, 200, 100)];
    self.showAlert.backgroundColor = [UIColor redColor];
    CGPoint point = self.showAlert.center;
    point.y = self.view.center.y - 200;
    self.showAlert.center= point;
    [self.view addSubview:self.showAlert];
    [self.showAlert setTitle:ZQ_LocalizedString(@"show alert") forState:UIControlStateNormal];
    [self.showAlert addTarget:self action:@selector(showrunTimeBlockAlert:) forControlEvents:UIControlEventTouchUpInside];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UIConfig) name:@"UIConfig" object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //发出通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UIConfig" object:nil];
}

- (void) UIConfig
{
    [self.showLanguage setTitle:ZQ_LocalizedString(@"switch language") forState:UIControlStateNormal];
    [self.showAlert setTitle:ZQ_LocalizedString(@"show alert") forState:UIControlStateNormal];
}

- (void)showrunTimeBlockAlert:(id)sender
{
    NSString *title = ZQ_LocalizedString(@"pop.up.message.title.smart.tips");
    NSString *message = ZQ_LocalizedString(@"insured.yet.to.be.borne");
    UIAlertAction *okAction1 = [self createAction:objc_getAssociatedObject(self.alert, toBeBorneAlert)];
    UIAlertAction *okAction2 = [self createAction:objc_getAssociatedObject(self.alert1, insuredChangeToMother)];
    UIAlertAction *okAction3 = [self createAction:nil];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:ZQ_LocalizedString(@"NO") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        void (^block)(NSInteger) = objc_getAssociatedObject(self.alert, toBeBorneAlert);
        if (block != NULL) {
            block(0);
        }
    }];
    self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self.alert addAction:noAction];
    [self.alert addAction:okAction1];
    [self presentViewController:self.alert animated:YES completion:nil];
    void (^block)(NSInteger) = ^(NSInteger index) {
        if (index == 0) {
            UIAlertController *alert4 = [UIAlertController alertControllerWithTitle:ZQ_LocalizedString(@"pop.up.message.title.smart.tips") message:ZQ_LocalizedString(@"continue.policy") preferredStyle:UIAlertControllerStyleAlert];
            [alert4 addAction:okAction3];
            [self presentViewController:alert4 animated:YES completion:nil];
        } else {
            NSString *message1 = ZQ_LocalizedString(@"change.insuredInfo.to.mother");
            self.alert1 = [UIAlertController alertControllerWithTitle:ZQ_LocalizedString(@"pop.up.message.title.smart.tips") message:message1 preferredStyle:UIAlertControllerStyleAlert];
            [self.alert1 addAction:okAction2];
            [self presentViewController:self.alert1 animated:YES completion:nil];
            void (^block1)(NSInteger) = ^(NSInteger index) {
                UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:ZQ_LocalizedString(@"pop.up.message.title.smart.tips") message:ZQ_LocalizedString(@"renew.select") preferredStyle:UIAlertControllerStyleAlert];
                [alert3 addAction:okAction3];
                [self presentViewController:alert3 animated:YES completion:nil];
            };
            objc_setAssociatedObject(self.alert1, insuredChangeToMother, block1, OBJC_ASSOCIATION_COPY);
        }
    };
    objc_setAssociatedObject(self.alert, toBeBorneAlert, block, OBJC_ASSOCIATION_COPY);
}

- (UIAlertAction *) createAction:(actionBlock)block
{
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:ZQ_LocalizedString(@"YES") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
        block(1);
        }
        
    }];
    return okAction;
}

- (void) showLanguageList:(UIView *) view
{
    [self.view addSubview:self.tableView];
}

- (void)changeLanguageTo:(NSString *)language {
    //对当前语言进行本地存储
    [[NSUserDefaults  standardUserDefaults]setObject:@"en" forKey:@"userLanguage"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //改变bundle  //英文，汉语语言资源文件 en.lproj zh_Hans
    NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
    NSBundle *needBundle = [NSBundle bundleWithPath:path];
    [ZQInternationalManager sharedInternationalManager].languageBunle = needBundle;
    //发出通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UIConfig" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
