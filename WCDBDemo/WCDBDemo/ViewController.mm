//
//  ViewController.m
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import "ViewController.h"
#import "Message+WCTTableCoding.h"
#import "TestModel+WCTTableCoding.h"
#import "WCTSampleFTSData+WCTTableCoding.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic,strong) WCTDatabase *database;
@property (nonatomic,assign) NSInteger count;

@property (nonatomic,strong) WCTDatabase *databaseFTS;
@property (nonatomic,copy) NSString *tableNameFTS;
@property (nonatomic,assign) long long lastInsertedRowID;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.view.backgroundColor = [UIColor whiteColor];
	[self contentTableView];
    self.count = 0;
	self.lastInsertedRowID = 1;
	self.tableNameFTS = NSStringFromClass(WCTSampleFTSData.class);
}

#pragma mark - lazyLoad
- (NSArray *)dataArray {
	if(!_dataArray) {
		_dataArray = @[@"1. 创建数据库",
		               @"2. 创建Message表",
		               @"3. 插入数据",
		               @"4. 删除数据",
		               @"5. 修改数据",
		               @"6. 查询数据",
		               @"7. 数据加密",
		               @"8. 验证线程安全",
		               @"9. 删除table",
		               @"10. 添加列",
		               @"11. 根据需要创建表",
		               @"12. 数据库备份",
		               @"13. 数据库修复模拟",
		               @"14. 创建数据库FTS",
		               @"15. 创建表FTS",
		               @"16. 插入数据FTS",
		               @"17. 查询数据FTS"
		];
	}
	return _dataArray;
}

- (UITableView *)contentTableView {
	if(!_contentTableView) {
		_contentTableView = [[UITableView alloc] initWithFrame:self.view.frame];
		_contentTableView.dataSource =self;
		_contentTableView.delegate = self;
		_contentTableView.tableFooterView = [UIView new];
		[_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
		[self.view addSubview:_contentTableView];
	}
	return _contentTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	cell.textLabel.text = self.dataArray[indexPath.row];
	if(indexPath.row > 12) {
		cell.backgroundColor = UIColor.cyanColor;
	}
	return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
	case 0:
	{
		[self createDataBase];
	}
	break;
	case 1:
	{
		[self createTable];
	}
	break;
	case 2:
	{
		[self insertDataToDB];
	}
	break;
	case 3:
	{
		[self deleteDataToDB];
	}
	break;
	case 4:
	{
		[self updateDataToDB];
	}
	break;
	case 5:
	{
		[self searchDataFromData];
	}
	break;
	case 6:
	{
		[self encryptDBData];
	}
	break;
	case 7:
	{
		[self checkThreadSafe];
	}
	break;
	case 8:
	{
		[self deleteTable];
	}
	break;
	case 9:
	{
		[self addTableColumn];
	}
	break;
	case 10:
	{
		[self createTableViewCondition];
	}
	break;
	case 11:
	{
		[self configBackUpCipher];
	}
	break;
	case 12:
	{
		[self repairDataBase];
	}
	break;
	case 13:
	{
		[self createDataBaseFTS];
	}
	break;
	case 14:
	{
		[self createTableFTS];
	}
	break;
	case 15:
	{
		[self insertDataToDBFTS];
	}
	break;
	case 16:
	{
		[self searchDataFTS];
	}
	break;

	default:
		break;
	}
}

#pragma mark - - - -  创建数据库 - - - -
- (WCTDatabase *)createDataBase {
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
	NSString *path = [NSString stringWithFormat:@"%@/testDB",docDir];
	NSLog(@"DB Path %@",path);
	WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
	return database;
}

- (WCTDatabase *)createDataBaseFTS {
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
	NSString *pathFTS = [NSString stringWithFormat:@"%@/ftsDB.db",docDir];
	NSLog(@"FTSDB Path %@",pathFTS);
	WCTDatabase *databaseFTS = [[WCTDatabase alloc] initWithPath:pathFTS];
	[databaseFTS setTokenizer:WCTTokenizerNameWCDB];

	return databaseFTS;
}

- (void)createTable {
	/*
	   CREATE TABLE messsage (localID INTEGER PRIMARY KEY,
	   content TEXT,
	   createTime BLOB,
	   modifiedTime BLOB)
	 */
	BOOL result = [self.database createTableAndIndexesOfName:@"message"
	               withClass:Message.class];

}

- (void)createTableFTS {
	[self.databaseFTS createVirtualTableOfName:self.tableNameFTS withClass:WCTSampleFTSData.class];
}

#pragma mark - - - - 数据库中插入数据 - - - -
- (void)insertDataToDB {
	self.count++;
	//插入
	Message *message = [[Message alloc] init];
	message.localID = self.count;
	message.content = @"Hello, WCDB!";
	message.createTime = [NSDate date];
	message.modifiedTime = [NSDate date];
	/*
	   INSERT INTO message(localID, content, createTime, modifiedTime)
	   VALUES(1, "Hello, WCDB!", 1496396165, 1496396165);
	 */
	BOOL result = [self.database insertObject:message into:@"message"];
}

- (void)insertDataToDBFTS {
	//插入
	for (int i = 0; i < 100; i++) {
		WCTSampleFTSData *object = [[WCTSampleFTSData alloc] init];
		object.isAutoIncrement = YES; // 主键自增
		object.localID = self.lastInsertedRowID;
		object.name = [NSString stringWithFormat:@"%dYungFan%d", i, i];
		object.content = [NSString stringWithFormat:@"中国安徽芜湖弋江区%d", i];
		object.createTime = [NSDate date];
		// 只需要将数据插入到FTS表中，即可建立FTS索引。插入方式与普通表没有区别
		BOOL result = [self.databaseFTS insertObject:object into:self.tableNameFTS];

        self.lastInsertedRowID = object.lastInsertedRowID + 1; // 将最后一次的插入id赋值给lastInsertedRowID
        // NSLog(@"%ld", (long)self.lastInsertedRowID);
	}

	NSLog(@"插入成功");
}

#pragma mark - - - - 从数据中删除数据 - - - -
- (void)deleteDataToDB {
	BOOL result = [self.database deleteObjectsFromTable:@"message"
	               where:Message.localID > 0];
}

#pragma mark - - - - 更新数据 - - - -
- (void)updateDataToDB {
	Message *message = [[Message alloc] init];
	message.content = @"Hi jack!";

	BOOL result = [self.database updateAllRowsInTable:@"message"
	               onProperties:Message.content
	               withObject:message];
}

#pragma mark - - - - 查询数据 - - - -
- (void)searchDataFromData {
	//查询
	//SELECT * FROM message ORDER BY localID
	NSArray<Message *> *messages = [self.database getObjectsOfClass:Message.class
	                                fromTable:@"message"
	                                orderBy:Message.localID.order()];


	//第二种查询方法
	//    WCTTable *table = [self.database getTableOfName:@"message"
	//                                     withClass:Message.class];
	//    //查询
	//    //SELECT * FROM message ORDER BY localID
	//    NSArray<Message *> *message = [table getObjectsOrderBy:Message.localID.order()];

}

- (void)searchDataFTS {
	// 全部数据
	NSArray<WCTSampleFTSData *> *objects = [self.databaseFTS getObjectsOfClass:WCTSampleFTSData.class fromTable:self.tableNameFTS orderBy:WCTSampleFTSData.localID.order(WCTOrderedDescending) limit:10];
	NSLog(@"FTS all %lu", (unsigned long)objects.count);
	for (WCTSampleFTSData *object in objects) {
		NSLog(@"All localID:%ld name:%@ content:%@ createTime:%@", (long)object.localID,object.name, object.content, object.createTime);
	}

	// 匹配数据
	NSArray<WCTSampleFTSData *> *ftsDatas = [self.databaseFTS getObjectsOfClass:WCTSampleFTSData.class fromTable:self.tableNameFTS where:WCTSampleFTSData.content.match("安徽*") orderBy:WCTSampleFTSData.localID.order(WCTOrderedDescending) limit:10];
	NSLog(@"FTS where %lu", (unsigned long)ftsDatas.count);
	for (WCTSampleFTSData *ftsData in ftsDatas) {
		NSLog(@"Match localID:%ld name:%@ content:%@ createTime:%@", (long)ftsData.localID,ftsData.name, ftsData.content, ftsData.createTime);
	}
}

#pragma mark - - - - 加密数据 - - - -
- (void)encryptDBData {
	NSData *password = [@"MyPassword" dataUsingEncoding:NSASCIIStringEncoding];
	[self.database setCipherKey:password];
}

#pragma mark - - - - 验证是否线程安全 - - - -
- (void)checkThreadSafe {
	_database=nil;
	dispatch_async(dispatch_get_main_queue(), ^{
		[self createDataBase];
		dispatch_async(dispatch_get_global_queue(0, 0), ^{
			[self searchDataFromData];
		});
	});

}

#pragma mark - - - - 删除表
- (void)deleteTable {
	[self.database dropTableOfName:@"message"];
}

#pragma mark - - - - 添加列 - - - -
- (void)addTableColumn {
	[self.database addColumn:Message.age.def(WCTColumnTypeInteger64) forTable:@"message"];

}

#pragma mark - - - - 根据需要创建表 - - - -
- (void)createTableViewCondition {

	[self.database createTableOfName:@"TestModel" withColumnDefList:{TestModel.modelID.def(WCTColumnTypeInteger64)}];
	NSString *indexSubfix = @"_index";
	NSString *indexName = [@"TestModel" stringByAppendingString:indexSubfix];
	[self.database createIndexOfName:@"TestModel_index" withIndexList:{TestModel.modelID.index()} forTable:@"TestModel"];

}

#pragma mark - - - - 开始备份操作 - - - -
- (void)configBackUpCipher {
	NSData *backupCipher = [@"backupCipher" dataUsingEncoding:NSASCIIStringEncoding];
	[self.database backupWithCipher:backupCipher];
}

#pragma mark - - - - 恢复数据库操作 - - - -
- (void)repairDataBase {
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
	NSString *path = [NSString stringWithFormat:@"%@/testDB",docDir];
	[self.database close:^{//模拟数据库损坏的操作
	         FILE *file = fopen(path.UTF8String, "rb+");
	         unsigned char *zeroPage = new unsigned char[100];
	         memset(zeroPage, 0, 100);
	         fwrite(zeroPage, 100, 1, file);
	         fclose(file);
	 }];

	NSLog(@"The count of objects corrupted: %lu", [self.database getAllObjectsOfClass:Message.class fromTable:@"message"].count);

	NSData *password = [@"MyPassword" dataUsingEncoding:NSASCIIStringEncoding];
	NSData *backupCipher = [@"backupCipher" dataUsingEncoding:NSASCIIStringEncoding];


	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

		NSString *recoverPath = [NSString stringWithFormat:@"%@/recoverDB",docDir];
		WCTDatabase * recover = [[WCTDatabase alloc] initWithPath:recoverPath];
		NSData * password = [ @"MyPassword"  dataUsingEncoding:NSASCIIStringEncoding];
		NSData * backupPassword = [ @"MyBackupPassword"  dataUsingEncoding:NSASCIIStringEncoding];
		int pageSize = 4096; // iOS上的默认值为4096，macOS上的默认值为1024。
		[self.database close:^ {
		         BOOL status = [recover recoverFromPath:path
		                        withPageSize:pageSize
		                        backupCipher:backupCipher
		                        databaseCipher:password];

		         NSLog(@"The count of objects reCovered: %lu", [recover getAllObjectsOfClass:Message.class fromTable:@"message"].count);

		 }];
	});


}

#pragma mark - - - - lazyLoad - - - -
- (WCTDatabase *)database {
	if (!_database) {
		_database = [self createDataBase];
	}
	return _database;
}

- (WCTDatabase *)databaseFTS {
	if (!_databaseFTS) {
		_databaseFTS = [self createDataBaseFTS];
	}
	return _databaseFTS;
}

@end

