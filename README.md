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
actual content view controller. Name this segue _aplContent_.

Pro tip: Make sure you set your content view controller's _Adjust Scroll View Insets_
property. We make sure all insets work as expected.

### Your Content View Controller

Import header file:

	#import "APLPullToRefreshViewController.h"
	
Your content view controller embeded via the segue named _aplContent_ has to
conform to the _APLPullToRefreshContainerDelegate_ protocol.

* Please provide your content scroll view via _-aplPullToRefreshContentScrollView_. This will most likely be self.scrollView, self.webView.scrollView or self.collectionView.

* Provide your actual Pull to Refresh view via _-aplPullToRefreshPullToRefreshView_. It may optionally conform to the _APLPullToRefreshView_ protocol. __Make sure to set a height constraint for the view you provide or it will have 0 height.__

* When the user triggers Pull to Refresh, _-aplDidTriggerPullToRefreshCompletion:_ will be called on the main thread. You _must_ call the provided, non-nil completionHandler once your refresh is finished so we can remove the Pull to Refresh view and restore the contentInset etc.


### Your Pull To Refresh view

You can provide any view that has a height constraint. It will be added at full width and the height its constraints suggest.

Conforming to the _APLPullToRefreshView_ might turn out to be useful, because:

* Once your pull to refresh view becomes visible, _-aplPullToRefreshProgressUpdate:beyondThreshold:_ gets called on your view any time its visible portion changes. You may find this useful to animate some kind of rotation, color change etc. during the pull process. The parameter's value range is 0...1 The parameter beyondThreshold indicates whether or not releasing the pull to refresh view at this point would trigger the pull to refresh.

* If the user triggered the pull to refresh, _-aplPullToRefreshStartAnimating_ is called. Use this to start an Activity Indicator or such.

* Once the refreshed content is there (and the content view controller calls the completion handler), _-aplPullToRefreshStopAnimating_ is called right before the pull to refresh view is animated away.


#### Lifecycle

Once a pan gesture reaches the over-scroll region, a fresh view instance is acquired
from the content view controller and immediately put on display. It is removed if

* the pan gesture stopped and the pull to refresh was not triggered

* or, if the pull to refresh was triggered, once the completionHandler is called and the view is animated away.
