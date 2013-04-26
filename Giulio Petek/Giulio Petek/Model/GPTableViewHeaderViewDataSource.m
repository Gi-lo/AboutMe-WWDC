/* ------------------------------------------------------------------------------------------------------
 GPTableView.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableViewHeaderViewDataSource.h"
#import "GPAvatarAndNameCollectionViewCell.h"

typedef NS_ENUM(NSInteger, GPTableViewHeaderViewDataSourcePages) {
    GPTableViewHeaderViewDataSourceAvatarAndNamePage = 0,
    GPTableViewHeaderViewDataSourceAboutMePage,
    GPTableViewHeaderViewDataSourceSocialPage,
    GPTableViewHeaderViewDataSourceNumberOfPages
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
        [headerView registerClass:[GPAvatarAndNameCollectionViewCell class] forCellWithReuseIdentifier:@"GPTableViewHeaderViewDataSourceAvatarAndNamePage"];
        [headerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
    }
    
    return self;
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return GPTableViewHeaderViewDataSourceNumberOfPages;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
        case GPTableViewHeaderViewDataSourceAvatarAndNamePage: {
            GPAvatarAndNameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GPTableViewHeaderViewDataSourceAvatarAndNamePage"
                                                                                                forIndexPath:indexPath];
            cell.avatarImageView.image = [UIImage imageNamed:@""];
            cell.nameLabel.text = @"Giulio Petek";
            
            return cell;
        } break;
        case GPTableViewHeaderViewDataSourceAboutMePage: {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
        } break;
        case GPTableViewHeaderViewDataSourceSocialPage: {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
        } break;
    }
    
    return nil;
}

@end
