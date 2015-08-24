## Show and Tell

* [Kevin Meaney](https://twitter.com/cocoakevin) - frameworks, linking, drawing and IBDesignable
* [Ste Prescott](https://twitter.com/ste_prescott) - porting Swift 2.0 code back to Obj-C
* [Matthew Spear](https://twitter.com/matthew_spear) - What I learnt making his first app Countin’
* [Dominic Wroblewski](https://twitter.com/Domness) - “Hello Sunday Morning" and "Graveyard Dash" apps built in Swift


## Materials


### Matthew Spear

* [Slides](./Matthew Spear/Building my first app - 18.08.15.pdf)
* [10 Resources I found building my first app](./Matthew Spear/Article/README.md)

### Dominic Wroblewski

* [Slides](./Dominic Wroblewski/Hello Sunday Morning & Graveyard Dash.pdf)

### Kevin Meaney

IBDesignable is a recent addition to Interface Builder in Xcode which makes possible the drawing of custom controls and views within the user interface editor in Xcode. Xcode makes this possible by building another copy of your application which it uses to render the view for you in Interface Builder. Having created a framework for iOS and OS X that can be used for drawing custom views and controls I was keen to have this work with IBDesignable.

Getting this to work proved to be more difficult than I expected. On both iOS and OS X the applications I had written were in Swift so I was working with flaky tools and my own lack of experience. This certainly slowed me down when tracking down why the Xcode component that was trying to use the special build IBDesignable application to draw the view kept dying.

The error I was seeing was that the Xcode component was crashing within my swift code when trying to call a function in the framework.

The framework I was keen to show off was not being loaded by the dynamic linker.

The fix was small and simple to do once I new what to do.

#### The long story
An explanation for why this was happening and what the fix was, is this excellent, quite old, but still up to date [blog post by Mike Ash](https://www.mikeash.com/pyblog/friday-qa-2009-11-06-linking-and-install-names.html).

#### The shorter story
By default when you create a framework target in Xcode, Xcode assumes that the framework will be later added to an application in its Framework directory from which it will be loaded and configures the build's linker settings appropriately. Also by default in Xcode when you add a framework to an Application to link against and to be added to the applications package Xcode configures the build's linker settings that assume the running executable that will load the framework is the application. This is nearly always correct. It is however the reason why IBDesignable was not working. The special build Xcode creates of your application to use to draw the controls is not the running executable, instead a component of Xcode is the running application and it runs the code in the application. 

This issue goes beyond trying to get IBDEsignable to work but probably impacts fewer people. You can get the same issue where you can have frameworks within frameworks.

In Xcode the solution is to change the "Deployment" build setting "Installation Directory" for the framework target to @rpath.

In the application target in Xcode that you want to have IBDesignable working for drawing custom controls using code from the framework change the linker setting "Runpath Search Paths" for iOS applications to "@loader_path/Frameworks", and for OS X applications change the setting to "@loader_path/../Frameworks"

