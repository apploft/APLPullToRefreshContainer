//
//  APLPullToRefreshContainerViewController.h
//  APLPullToRefreshContainer
//
//  Created by Nico Schümann on 09.09.15.
//  Copyright (c) 2015 apploft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APLPullToRefreshContainerViewController;
typedef void(^APLPullToRefreshCompletionHandler)(void);

@protocol APLPullToRefreshView <NSObject>

@optional
- (void)aplPullToRefreshStartAnimating;
- (void)aplPullToRefreshStopAnimating;
- (void)aplPullToRefreshProgressUpdate:(CGFloat)progress beyondThreshold:(BOOL)beyondThreshold NS_SWIFT_NAME(aplPullToRefresh(progressUpdate:beyondThreshold:));

@end


@protocol APLPullToRefreshContainerDelegate <NSObject>

- (void)aplPullToRefreshContainer:(nonnull APLPullToRefreshContainerViewController *)container didTriggerPullToRefreshCompletion:(nonnull APLPullToRefreshCompletionHandler)completionHandler NS_SWIFT_NAME(aplPullToRefreshContainer(_:didTriggerPullToRefreshCompletion:));

@optional
- (nullable UIColor *)aplPullToRefreshViewBackgroundColorForContainer:(nonnull APLPullToRefreshContainerViewController *)container NS_SWIFT_NAME(aplPullToRefreshViewBackgroundColorForContainer(_:));
- (nonnull UIView<APLPullToRefreshView> *)aplPullToRefreshPullToRefreshViewForContainer:(nonnull APLPullToRefreshContainerViewController *)container NS_SWIFT_NAME(aplPullToRefreshPullToRefreshViewForContainer(_:));
- (void)aplPullToRefreshContainer:(nonnull APLPullToRefreshContainerViewController *)container didInstallPullToRefreshView:(nonnull UIView<APLPullToRefreshView> *)pullToRefreshView NS_SWIFT_NAME(aplPullToRefreshContainer(_:didInstallPullToRefreshView:));
- (void)aplPullToRefreshContainer:(nonnull APLPullToRefreshContainerViewController *)container didEmbedContentViewController:(nonnull UIViewController *)contentViewController NS_SWIFT_NAME(aplPullToRefreshContainer(_:didEmbedContentViewController:));

@end


@interface APLPullToRefreshContainerViewController : UIViewController

@property (nullable, nonatomic, weak) id<APLPullToRefreshContainerDelegate> delegate;
@property (nullable, nonatomic, weak, readonly) UIViewController *contentViewController;
@property (nonatomic, getter=isPullToRefreshEnabled) BOOL pullToRefreshEnabled;
@property (nonatomic) BOOL alwaysWantsContentInset;

- (void)embedContentViewController:(nonnull UIViewController *)contentViewController;

@end
