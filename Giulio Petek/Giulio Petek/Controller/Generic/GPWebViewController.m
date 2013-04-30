/* ------------------------------------------------------------------------------------------------------
 GCXWebViewController.h
 
 Created by Giulio Petek on 30.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 ------------------------------------------------------------------------------------------------------ */

#import "GPWebViewController.h"

/* ------------------------------------------------------------------------------------------------------
 @interface GPWebViewController
 ------------------------------------------------------------------------------------------------------ */

@interface GPWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *_webView;
@property (nonatomic, strong) NSURL *_url;

@end

/* ------------------------------------------------------------------------------------------------------
 @implementation GPWebViewController
 ------------------------------------------------------------------------------------------------------ */

@implementation GPWebViewController

#pragma mark -
#pragma mark Init

- (instancetype)initWithURL:(NSURL *)url {
    if ((self = [super init])) {
        __url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark View

- (void)loadView {
    UIView *container = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = container.bounds;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scalesPageToFit = YES;
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    webView.delegate = self;
    [container addSubview:webView];
    self._webView = webView;
    
    self.view = container;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:@selector(_donePressed:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    [self._webView loadRequest:[NSURLRequest requestWithURL:self._url]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self._webView stopLoading];
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark -
#pragma mark Actions

- (void)_donePressed:(UIBarButtonItem *)buttonItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self webViewDidFinishLoad:webView];
    
    self.navigationItem.title = @"Error";
}

@end
