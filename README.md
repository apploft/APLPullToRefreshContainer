APLPullToRefreshContainer
=========




## Installation
Install via cocoapods by adding this to your Podfile:

	pod "APLPullToRefreshContainer"

## Usage
The APLPullToRefreshViewController is intended to be used as a view controller
that embeds the view controller you want to add a pull to refresh view to.

### Storyboard
Open the Storyboard and create a new View Controller. Set this view controller's
class to _APLPullToRefreshContainerViewController_.

Drag a Container View into this view controller and create an embed segue to your
actual content view controller. Name this segue _aplContent_. You may want to constrain
the Container View to (0, 0, 0, 0) so it fills all available space. Do not constrain to margins or to safe areas, but to the superview!

Set up the _APLPullToRefreshContainerViewController_'s delegate and implement the required method _aplPullToRefreshContainer:didTriggerPullToRefreshCompletion:_.

Pro tip: Make sure to set your content view controller's _Automatically Adjust Scroll View Insets_
property. We'll make sure all insets work as expected.

### Programmatically

Use _APLPullToRefreshContainerViewController_'s _embedContentViewController:_ method to add your content view controller programatically.

You have to own the UIViewController instance you pass because the container takes a weak reference.

### Your Content View Controller
	
Your content view controller embeded via the segue named _aplContent_ or added via the _embedContentViewController:_  has to provide a _scrollView_ property that is observed by the container. To work out-of-the-box with _UITableView_ etc., it will work, too, if you view controller's view __is__ a _UIScrollView_. If it is not, please provide the _scrollView_ property.


* If you do not like the default Pull to Refresh view (which is just a transparent view with a UIActivityIndicatorView), you can either implement _aplPullToRefreshContainer:didInstallPullToRefreshView:_ in your delegate to customize the default appearence.

For more sophisticated layouts, please provide a custom view via _-aplPullToRefreshPullToRefreshViewForContainer:_. It may optionally conform to the _APLPullToRefreshView_ protocol. __Make sure to set a height constraint for the view you provide (or make it have an intrinsic height) or it will have no height.__

* When the user triggers Pull to Refresh, _-aplPullToRefreshContainer:didTriggerPullToRefreshCompletion:_ will be called on the main thread. You _must_ call the provided, non-nil completionHandler once your refresh is finished so we can remove the Pull to Refresh view for you and restore the contentInset etc.


### Your Pull to Refresh View

You can provide any view that has a height constraint (or an intrinsic height). It will be added at full width.

Conforming to the _APLPullToRefreshView_ might turn out to be useful, because:

* Once your pull to refresh view becomes visible, _-aplPullToRefreshProgressUpdate:beyondThreshold:_ gets called on your view any time its visible portion changes. You may find this useful to animate some kind of rotation, color change etc. during the pull process. The parameter's value range is 0...1 to be interpreted as a linear percentage value. The parameter beyondThreshold indicates whether or not releasing the pull to refresh view at this point would trigger the pull to refresh.

* If the user triggered the pull to refresh, _-aplPullToRefreshStartAnimating_ is called. Use this to start an Activity Indicator or such.

* Once the refreshed content is there (and the content view controller calls the completion handler), _-aplPullToRefreshStopAnimating_ is called right before the pull to refresh view is animated away. You can ignore this because you are being animated away soon, anyway, or stop any kind of animation still running.


#### Lifecycle

Once a pan gesture reaches the over-scroll region, a fresh view instance is acquired
from the content view controller and immediately put on display. It is removed if

* the pan gesture stopped and the pull to refresh was not triggered

* or, if the pull to refresh was triggered, once the completionHandler is called and the view is animated away.

It is guaranteed that there is at most one pull to refresh view and one pull to request hanging around. Because we are nice to you, be nice to us and call the provided _completionHandler_ __exactly once__. A useful pattern to call the completionHandler asynchronously could be:

    - (void)aplPullToRefreshContainer:(nonnull APLPullToRefreshContainerViewController *)container didTriggerPullToRefreshCompletion:(nonnull APLPullToRefreshCompletionHandler)completionHandler {
        _pendingPullToRefreshCompletionHandler = completionHandler;
        [_webView reload];
    }

    - (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        if (_pendingPullToRefreshCompletionHandler) {
            _pendingPullToRefreshCompletionHandler();
            _pendingPullToRefreshCompletionHandler = nil;
        }
    }

Calling the completion handler multiple times is undefined behaviour that could lead to threat to life etc.


# Frequently Asked Questions

## How can I temporarily disable Pull to Refresh?

Use the container's _pullToRefreshEnabled_ property.


# Changelog

## Version 1.0
- All delegate methods have been renamed and annotated so they work perfectly from Swift, too.
- Returning nil from the delegate's _aplPullToRefreshPullToRefreshViewForContainer:_ method is now unsupported. Use the container's _pullToRefreshEnabled_ property, instead.
