/* ------------------------------------------------------------------------------------------------------
 GPTableHeaderView.m
 
 Created by Giulio Petek on 26.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPTableHeaderView.h"
#import "GPTableHeaderBackgroundImageView.h"

static CGFloat const GPTableHeaderViewHeight = 100.0f;

/* ------------------------------------------------------------------------------------------------------
 @interface GPTableHeaderView ()
 ------------------------------------------------------------------------------------------------------ */

@interface GPTableHeaderView () <UICollectionViewDelegate> {
    BOOL _collectionViewWasScrolled;
}

@property (nonatomic, weak) GPTableHeaderBackgroundImageView *_backgroundImageView;
@property (nonatomic, weak) UIPageControl *_pageControl;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPTableHeaderView
 ------------------------------------------------------------------------------------------------------ */

@implementation GPTableHeaderView

#pragma mark -
#pragma mark Init

- (instancetype)initWithBackgroundImage:(UIImage *)image {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    if ((self = [super initWithFrame:CGRectZero collectionViewLayout:layout])) {
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.delegate = self;
        
        GPTableHeaderBackgroundImageView *backgroundView = [[GPTableHeaderBackgroundImageView alloc] init];;
        backgroundView.image = image;
        self.backgroundView = backgroundView;

        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        [self addSubview:pageControl];
        __pageControl = pageControl;
    }
    
    return self;
}

- (instancetype)init {
    @throw @"Please use <initWithBackgroundImages:> isntead.";
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewFlowLayout *)layout {
    @throw @"Please use <initWithBackgroundImages:> isntead.";
}

#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    _collectionViewWasScrolled = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    _collectionViewWasScrolled = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (_collectionViewWasScrolled) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if (!CGRectContainsPoint(self._pageControl.frame, touchLocation)) {
        return;
    }
    
    touchLocation.x -= self.contentOffset.x;
    touchLocation.x > CGRectGetWidth(self.bounds) / 2.0f ? self._pageControl.currentPage++ : self._pageControl.currentPage--;
    [self scrollRectToVisible:(CGRect){{
            self._pageControl.currentPage * CGRectGetWidth(self.bounds), 0.0f
        },
        self.bounds.size
    } animated:YES];
}

#pragma mark -
#pragma mark Reload

- (void)reloadData {
    self._pageControl.numberOfPages = [self.dataSource collectionView:self numberOfItemsInSection:0];
    [self._pageControl sizeToFit];
    
    [super reloadData];
}

#pragma mark -
#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(self._pageControl.frame));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self._pageControl.frame), 0.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self._pageControl.frame = (CGRect){{
            self.contentOffset.x,
            CGRectGetMinY(self._pageControl.frame)
        },
        self._pageControl.frame.size
    };
    
    if ((int)self.contentOffset.x % (int)CGRectGetWidth(self.bounds) == 0) {
        NSUInteger newPage = roundf(self.contentOffset.x / CGRectGetWidth(self.bounds));
        if (newPage != self._pageControl.currentPage) {
            self._pageControl.currentPage = newPage;
        }
    }
}

#pragma mark -
#pragma mark Layout

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self sizeToFit];
    [((GPTableHeaderBackgroundImageView *)self.backgroundView) startAnimating];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [((GPTableHeaderBackgroundImageView *)self.backgroundView) stopAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self._pageControl.frame = (CGRect){{
            self.contentOffset.x,
            CGRectGetHeight(self.bounds) - CGRectGetHeight(self._pageControl.bounds)
        },
        self._pageControl.frame.size
    };
}

- (CGSize)sizeThatFits:(CGSize)size {
    return (CGSize){CGRectGetWidth(self.superview.frame), GPTableHeaderViewHeight};
}

@end
