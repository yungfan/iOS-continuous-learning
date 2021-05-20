//
//  PhotosViewController.m
//  objc.io example project (issue #1)
//

#import "PhotosViewController.h"
#import "Photo.h"
#import "PhotoCell.h"
#import "ArrayDataSource.h"
#import "PhotoCell+ConfigureForPhoto.h"


static NSString * const PhotoCellIdentifier = @"PhotoCell";


@interface PhotosViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ArrayDataSource *photosArrayDataSource;

@end


@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Photos";
    [self setupTableView];
}

- (void)setupTableView
{
    //Block
    TableViewCellConfigureBlock configureCell = ^(PhotoCell *cell, Photo *photo) {
        [cell configureForPhoto:photo];
    };
    
    //setup dataSource
    self.photosArrayDataSource = [[ArrayDataSource alloc] initWithItems:[Photo photos]
                                                         cellIdentifier:PhotoCellIdentifier
                                                     configureCellBlock:configureCell];
    
    self.tableView.dataSource = self.photosArrayDataSource;
    
    //registerNib
    [self.tableView registerNib:[PhotoCell nib] forCellReuseIdentifier:PhotoCellIdentifier];
}

@end
