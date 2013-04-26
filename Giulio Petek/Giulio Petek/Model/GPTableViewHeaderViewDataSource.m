/* ------------------------------------------------------------------------------------------------------
 GPTableView.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableViewHeaderViewDataSource.h"

typedef NS_ENUM(NSInteger, GPTableViewHeaderViewDataSourcePages) {
    GPTableViewHeaderViewDataSourceAvatarAndNamePage = 0,
    GPTableViewHeaderViewDataSourceAboutMePage,
    GPTableViewHeaderViewDataSourceSocialPage
};

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTableViewHeaderViewDataSource ()
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableViewHeaderViewDataSource

#pragma mark -
#pragma mark - Init

- (instancetype)init {
    @throw @"Please use <initWithHeaderView:> instead.";
}

- (instancetype)initWithHeaderView:(GPTableViewHeaderView *)headerView {
    if ((self = [super init])) {
        [headerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
    }
    
    return self;
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    switch (indexPath.item) {
        case GPTableViewHeaderViewDataSourceAvatarAndNamePage: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor greenColor];
        } break;
        case GPTableViewHeaderViewDataSourceAboutMePage: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor redColor];
        } break;
        case GPTableViewHeaderViewDataSourceSocialPage: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor blueColor];
        } break;
    }
    
    return cell;
}

@end
