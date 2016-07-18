# Location Trivia Delegates - Swift

## Goals

1. Replace access to a shared data manager with a delegate protocol.
2. Create and use a custom delegate protocol.
3. Compare different means of communicating between view controllers.


## Review

We've seen Location Trivia in many guises at this point. Most recently, we added the ability for users to create new locations with their own trivia. To do this, we used a singleton data store instance to avoid the difficult problem of passing data back from a view controller to its presenter.

In this lab, we will accomplish this feat by giving the Add Location view controller a delegate.


## Discussion

Think about the Add Location VC for a minute. Conceptually, what is its role? It is a UI for creating a new location, right? That is -- the Add Location VC is some object that, through some series of actions undertaken by the user, creates a new Location object.

We can analogize the role of this VC to that of a method -- it takes in no particular "arguments" and "returns" a Location.

Our goal is to model that behavior with a delegate.


## Analogs

Apple is fond of using delegation for this exact circumstance in its own classes. The Cocoa frameworks have a few examples of view controllers that conceptually result in the creation (or selection) of a particular object. For example, see:

* [`MPMediaPickerController`](https://developer.apple.com/library/ios/documentation/MediaPlayer/Reference/MPMediaPickerController_ClassReference/) -- a UI for selecting music or video from the user's library. Via [`MPMediaPickerControllerDelegate`](https://developer.apple.com/library/ios/documentation/MediaPlayer/Reference/MPMediaPickerControllerDelegate_ProtocolReference/index.html#//apple_ref/doc/uid/TP40008216), it returns the selected item(s).
* [`ABPeoplePickerNavigationController`](https://developer.apple.com/library/ios/documentation/AddressBookUI/Reference/ABPeoplePickerNavigationController_Class/) -- a UI for selecting people from the user's address book. It returns the selected contact(s) via [`ABPeoplePickerNavigationControllerDelegate`](https://developer.apple.com/library/ios/documentation/AddressBookUI/Reference/ABPeoplePickerNavigationControllerDelegate_Protocol/index.html#//apple_ref/occ/intf/ABPeoplePickerNavigationControllerDelegate).
* Many more examples... `UIImagePickerControllerDelegate`, `GKPeerPickerControllerDelegate`, etc.

## Instructions

First, create two view controllers -- a `UITableViewController` with the locations (`LocationsTableViewController`), and a simple `UIViewController` for adding new locations (`AddLocationViewController`). Note that there is no shared data store in this project.

Your goal is to do the following:

1. Create a custom protocol for the delegate of the `AddLocationViewController` class. Name it `AddLocationViewControllerDelegate`. Make sure to include the `class` keyword after the protocol declaration (i.e. `protocol AddLocationViewControllerDelegate: class` . This indicates that the protocol we just created can only be adopted by classes (not structs or enums) - we do this is for memory management reasons that we'll discuss later. It should have three required functions:
    * A function that alerts the delegate that the user has tapped 'Cancel' on the `AddLocationViewController`.
    * A function that asks the delegate if the submitted location name is valid. This function should enforce that there are no duplicate location names.
    * A function that alerts the delegate that the user has confirmed their new location name.
    
    Think about what you would name these functions for a bit. Naming delegate protocol functions is a tricky business -- it's usually best to follow Apple's lead where possible. Check out [their documentation](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIImagePickerControllerDelegate_Protocol/#//apple_ref/occ/intfm/UIImagePickerControllerDelegate/imagePickerController:didFinishPickingMediaWithInfo:) on `UIImagePickerControllerDelegate`. 
    
	Since our `LocationsTableviewController` adopts the `AddLocationViewControllerDelegate` protocol, it could potentially be the delegate for multiple different `AddLocationViewControllers`s.  Due to this, these delegate protocol functions would each ideally take at least one argument - an argument for the sender (in this case, an `AddLocationViewController`. The latter two functions should also take the submitted location name as an argument. Based on these recommendations and Apple's naming standards, I'd recommend these names for the functions above:
    
    * `func addLocationViewControllerDidCancel(viewController: AddLocationViewController)`
    
    * `func addLocationViewController(viewController: AddLocationViewController, shouldAllowLocationNamed name: String) -> Bool`
    
    * `func addLocationViewController(viewController: AddLocationViewController, didAddLocationNamed name: String)`

2. Add a `weak` property of type `AddLocationViewControllerDelegate` to `AddLocationViewController` called `delegate`. For memory management reasons that we won't get into her, delegate properties should almost always be `weak`.

3. Have `AddLocationViewController` call the functions on the delegate when appropriate:
    * When the user types in the text field, check if the location name is valid, and only enable the save button if it is. (Remember: wire the "Editing Did Change" event of the field to an action method to run some code whenever the text of a field changes.)
    * If the user hits the "Cancel" or "Save" buttons, call the appropriate delegate methods.

    Note that it is standard for VCs like this to **not** dismiss themselves upon completion -- rather, that is the responsibility of the delegate. A VC cannot know for certain *how* it was presented (i.e., modally or on a navigation stack), so it is best to leave the details of that up to the presenting VC. Follow that convention in `FISAddLocationViewController` by not having it call any `dismiss...` or `pop...` methods.

4. Make `FISLocationsViewController` conform to your new delegate protocol. This will involve implementing all three methods of the protocol, as well as marking the class as conforming to the protocol in the header or class extension.

    The `... shouldAllowLocationNamed:` method should return `YES` only if the location name is unique. The `... didAddLocationNamed:` method should create a new `FISLocation` object and add it to the array of locations. Both the `...didAddLocationNamed:` and `...didCancel:` methods should dismiss the Add Location VC.

5. Now we need to make our `FISLocationsViewController` the delegate of any new `FISAddLocationViewController` instances! Wire that up in `-prepareForSegue:sender:`.

6. Bask in the glory of your reusable VC!


## Advanced

Make the `... shouldAllowLocationNamed:` delegate method optional (defaulting to `YES`). Make sure your code doesn't crash if the delegate doesn't implement this method (that is the whole point of being optional)!

Make the keyboard pop up automatically in the name field when the Add Item VC appears.

Make the return button on the keyboard do the right thing in the Add Item VC.

Though it would be a little weird, try pushing the Add Location VC onto a navigation stack, rather than presenting it modally. Think about what needs to change in your delegate implementation. But, you shouldn't have to change any code in the Add Location VC itself. Nice!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ios-location-trivia-delegate' title='Location Trivia Delegates'>Location Trivia Delegates</a> on Learn.co and start learning to code for free.</p>