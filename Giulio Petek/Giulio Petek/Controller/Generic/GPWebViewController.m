/* ------------------------------------------------------------------------------------------------------
 
 GCXWebViewController.h
 
 Created by Giulio Petek on 30.04.13.
 Copyright 2013 Giulio Petek. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
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

#pragma mark -
#pragma mark Actions

- (void)_donePressed:(UIBarButtonItem *)buttonItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.navigationItem.title = @"Loading...";

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.navigationItem.title = @"Error";
}

@end
