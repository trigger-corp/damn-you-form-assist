//
//  damn_you_form_assist_API.h
//  ForgeModule
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface UIWebView (accessoryHiding)

@property (nonatomic, assign) BOOL hidesInputAccessoryView;

@end

@interface damn_you_form_assist_API : NSObject

@end