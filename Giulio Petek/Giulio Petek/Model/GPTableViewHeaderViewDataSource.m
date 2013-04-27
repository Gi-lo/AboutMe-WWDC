/* ------------------------------------------------------------------------------------------------------
 GPTableView.h
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableViewHeaderViewDataSource.h"
#import "GPAvatarAndNameCollectionViewCell.h"
#import "GPAboutTextCollectionViewCell.h"

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
        [headerView registerClass:[GPAboutTextCollectionViewCell class] forCellWithReuseIdentifier:@"GPAboutTextCollectionViewCell"];
        [headerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
        
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
    switch (indexPath.item) {
        case GPTableViewHeaderViewDataSourceAvatarAndNamePage: {
            GPAvatarAndNameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GPTableViewHeaderViewDataSourceAvatarAndNamePage"
                                                                                                forIndexPath:indexPath];
            cell.avatarImageView.image = [UIImage imageNamed:@"person01a.jpg"];
            cell.nameLabel.text = @"Giulio Petek";
            
            return cell;
        } break;
        case GPTableViewHeaderViewDataSourceAboutMePage: {
            GPAboutTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GPAboutTextCollectionViewCell"
                                                                                            forIndexPath:indexPath];
            cell.aboutMeTextLabel.text = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.";
            
            return cell;
        } break;
        case GPTableViewHeaderViewDataSourceSocialPage: {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
        } break;
    }
    
    return nil;
}

@end
