/* ------------------------------------------------------------------------------------------------------
 GPTableView.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableHeaderDataSource.h"
#import "GPTableHeaderCell.h"

typedef NS_ENUM(NSInteger, GPTableViewHeaderViewDataSourcePages) {
    GPTableViewHeaderViewDataSourceAboutMePage = 0,
    GPTableViewHeaderViewDataSourceResumePage,
    GPTableViewHeaderViewDataSourceNumberOfPages
};

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTableHeaderDataSource ()
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableHeaderDataSource

#pragma mark -
#pragma mark - Init

- (instancetype)init {
    @throw @"Please use <initWithHeaderView:> instead.";
}

- (instancetype)initWithHeaderView:(GPTableHeaderView *)headerView {
    if ((self = [super init])) {
        [headerView registerClass:[GPTableHeaderCell class] forCellWithReuseIdentifier:@"GPTableHeaderCell"];        
        headerView.dataSource = self;
        [headerView reloadData];
    }
    
    return self;
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return GPTableViewHeaderViewDataSourceNumberOfPages;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPTableHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GPTableHeaderCell" forIndexPath:indexPath];

    switch (indexPath.item) {
        case GPTableViewHeaderViewDataSourceAboutMePage: {
            cell.imageView.image = [UIImage imageNamed:@"person01a.jpg"];
            cell.titleLabel.text = @"About me";
        } break;
        case GPTableViewHeaderViewDataSourceResumePage: {
            cell.imageView.image = [UIImage imageNamed:@"person01a.jpg"];
            cell.titleLabel.text = @"Resume";
        } break;
    }
    
    return cell;
}

@end
