//
//  damn_you_form_assist_API.m
//  ForgeModule
//
//

#import "damn_you_form_assist_API.h"

@implementation damn_you_form_assist_API

+ (void)killBar:(ForgeTask*)task {
    
    UIWebView *webView = [ForgeApp sharedApp].webView;
    webView.hidesInputAccessoryView = YES;
    [task success:@"Bar removed."];
    
}

@end

@implementation UIWebView (accessoryHiding)

static const char * const fixClassName = "UIWebBrowserViewMinusAccessoryView";
static Class fixClass = Nil;

- (UIView *)findBrowserView {
    UIScrollView *scrollView = self.scrollView;
    
    UIView *browserView = nil;
    for (UIView *subview in scrollView.subviews) {
        if ([NSStringFromClass([subview class]) hasPrefix:@"UIWebBrowserView"]) {
            browserView = subview;
            break;
        }
    }
    return browserView;
}

- (id)methodReturningNil {
    return nil;
}

- (void)ensureSubclassExistsOfBrowserViewClass:(Class)browserViewClass {
    if (!fixClass) {
        Class newClass = objc_allocateClassPair(browserViewClass, fixClassName, 0);
        IMP nilImp = [self methodForSelector:@selector(methodReturningNil)];
        class_addMethod(newClass, @selector(inputAccessoryView), nilImp, "@@:");
        objc_registerClassPair(newClass);
        
        fixClass = newClass;
    }
}

- (BOOL) hidesInputAccessoryView {
    UIView *browserView = [self findBrowserView];
    return [browserView class] == fixClass;
}

- (void) setHidesInputAccessoryView:(BOOL)value {
    UIView *browserView = [self findBrowserView];
    if (browserView == nil) {
        return;
    }
    [self ensureSubclassExistsOfBrowserViewClass:[browserView class]];
    
    if (value) {
        object_setClass(browserView, fixClass);
    }
    else {
        Class normalClass = objc_getClass("UIWebBrowserView");
        object_setClass(browserView, normalClass);
    }
    [browserView reloadInputViews];
}

@end
