/* ------------------------------------------------------------------------------------------------------
 GPTableViewHeaderView.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableViewHeaderView.h"
#import "GPTableViewHeaderViewFlowLayout.h"

static CGFloat const GPTableViewHeaderViewheight = 100.0f;

/* ------------------------------------------------------------------------------------------------------
 @interface GPTableViewHeaderView ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTableViewHeaderView () <UICollectionViewDelegate>

@property (nonatomic, weak) UIPageControl *_pageControl;

- (void)_pageDidChange:(UIPageControl *)sender;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTableViewHeaderView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableViewHeaderView

#pragma mark -
#pragma mark Init

- (instancetype)init {
    return [self initWithFrame:CGRectZero collectionViewLayout:nil];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    layout = [[GPTableViewHeaderViewFlowLayout alloc] init];
    
    if ((self = [super initWithFrame:CGRectZero collectionViewLayout:layout])) {
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [pageControl addTarget:self action:@selector(_pageDidChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pageControl];
        __pageControl = pageControl;
    }
    
    return self;
}

#pragma mark -
#pragma mark Reload

- (void)reloadData {
    [super reloadData];
    
    self._pageControl.numberOfPages = [self.dataSource collectionView:self numberOfItemsInSection:0];
    [self._pageControl sizeToFit];
}

#pragma mark -
#pragma mark Actions

- (void)_pageDidChange:(UIPageControl *)pageControl {
    [self scrollRectToVisible:(CGRect){
        {
            pageControl.currentPage * CGRectGetWidth(self.bounds), 0.0f
        },
        self.bounds.size
    } animated:YES];
}

#pragma mark -
#pragma mark Layout

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    
    self._pageControl.frame = (CGRect){{
            ceilf(CGRectGetWidth(self.bounds) / 2.0f - CGRectGetWidth(self._pageControl.bounds) / 2.0f + contentOffset.x),
            CGRectGetHeight(self.bounds) - CGRectGetHeight(self._pageControl.bounds)
        },
        self._pageControl.frame.size
    };
    
    if ((int)contentOffset.x % (int)CGRectGetWidth(self.bounds) == 0) {
        self._pageControl.currentPage = contentOffset.x / CGRectGetWidth(self.bounds);
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self sizeToFit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
        
    self._pageControl.frame = (CGRect){{
            ceilf(CGRectGetWidth(self.bounds) / 2.0f - CGRectGetWidth(self._pageControl.bounds) / 2.0f + self.contentOffset.x),
            CGRectGetHeight(self.bounds) - CGRectGetHeight(self._pageControl.bounds)
        },
        self._pageControl.frame.size
    };
}

- (CGSize)sizeThatFits:(CGSize)size {
    return (CGSize){CGRectGetWidth(self.superview.frame), GPTableViewHeaderViewheight};
}

@end
