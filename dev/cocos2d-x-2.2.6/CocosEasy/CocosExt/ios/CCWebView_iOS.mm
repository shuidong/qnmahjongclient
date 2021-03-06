//
//  CCWebView_iOS.m
//
// Created by Vincent on 12-11-27.
// From https://github.com/go3k/CCXWebview
// Modified by zrong on 2014-06-24.
//

#import "CCWebView_iOS.h"
#import "EAGLView.h"

@implementation CCWebView_iOS

- (CGRect)getAdapterFrameFrom:(CGRect)rect
                        scale:(float)scale{
    rect.origin.x /= scale;
    rect.origin.y /= scale;
    rect.size.width /= scale;
    rect.size.height /= scale;
    return rect;
}

- (void)showWebView_x:(float)x
                    y:(float)y
                width:(float)widht
               height:(float)height
{
    if (!m_webview)
    {
        UIView *glView = [EAGLView sharedEGLView];
        CGRect rect = [self getAdapterFrameFrom:CGRectMake(x, y, widht , height)
                                          scale:glView.contentScaleFactor];
        m_webview = [[UIWebView alloc] initWithFrame:rect];
        [m_webview setScalesPageToFit:YES];
        [m_webview setDelegate:self];
        [glView addSubview:m_webview];
        [m_webview release];
        
        m_webview.backgroundColor = [UIColor clearColor];
        m_webview.opaque = NO;
        
        for (UIView *aView in [m_webview subviews])  
        { 
            if ([aView isKindOfClass:[UIScrollView class]])  
            { 
                UIScrollView* scView = (UIScrollView *)aView;
                
                //[(UIScrollView *)aView setShowsVerticalScrollIndicator:YES]; //右侧的滚动条 （水平的类似）
                [scView setShowsHorizontalScrollIndicator:YES];
                //scView.bounces = NO;
                
                for (UIView *shadowView in aView.subviews)  
                {
                    if ([shadowView isKindOfClass:[UIImageView class]]) 
                    { 
                        shadowView.hidden = NO;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                    } 
                } 
            } 
        }  
    }
}

- (void)updateURL:(const char*)url
{
    NSString *request = [NSString stringWithUTF8String:url];
    [m_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request] 
                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
                                        timeoutInterval:60]];
}

- (void)removeWebView
{
    [m_webview removeFromSuperview];
    m_webview = NULL;
}

#pragma mark - WebView
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
