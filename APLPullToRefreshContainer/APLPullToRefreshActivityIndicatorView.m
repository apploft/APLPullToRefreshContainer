//
//  APLPullToRefreshActivityIndicatorView.m
//  APLPullToRefreshContainer
//
//  Created by Nico Schümann on 12.04.19.
//  Copyright (c) 2019 apploft. All rights reserved.
//

#import "APLPullToRefreshActivityIndicatorView.h"

@interface APLPullToRefreshActivityIndicatorView ()

@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end


@implementation APLPullToRefreshActivityIndicatorView


#pragma mark - View Hierarchy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        [self addActivityIndicator];
    }

    return self;
}

- (void)addActivityIndicator {
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView = activityIndicatorView;

    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    activityIndicatorView.hidesWhenStopped = NO;

    [self addSubview:activityIndicatorView];

    [activityIndicatorView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [activityIndicatorView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [activityIndicatorView.topAnchor constraintEqualToAnchor:self.topAnchor constant:22.0].active = YES;
}

#pragma mark - Pull to Refresh Actions

- (void)aplPullToRefreshStartAnimating {
    [_activityIndicatorView startAnimating];
}

- (void)aplPullToRefreshStopAnimating {
    [_activityIndicatorView stopAnimating];
}

@end
