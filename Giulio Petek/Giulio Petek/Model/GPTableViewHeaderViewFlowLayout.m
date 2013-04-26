/* ------------------------------------------------------------------------------------------------------
 GPTableViewHeaderViewFlowLayout.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableViewHeaderViewFlowLayout.h"

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTableViewHeaderViewFlowLayout ()
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableViewHeaderViewFlowLayout

- (id)init {
    if ((self = [super init])) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0;
    }
    
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
}

@end
