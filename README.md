# QuestionApp-iOS

###1. About

This app is a native variant of a webapplication, more info on this webapp. can be found here: [Question](https://github.com/JeroenBe/Question), please take into account that this is a private repo, if you want to take a look just send me a message!

The purpose of this app is to gain a better understanding of Cocoa Touch, iOS, DDP & Meteor, MVVM & ReactiveCocoa.

#####_1.1 Technical_

The [Question](https://github.com/JeroenBe/Question) webapp is built using [the Meteor Framework](https://meteor.com), since Meteor uses [DPP](https://meteor.com/ddp) as their default protocol for sending data over the net (as an alternative to http), it wasn't possible to use a REST api (however, adding the right package to our meteor app would make this possble). Instead I used the [Meteor-iOS](https://github.com/martijnwalraven/meteor-ios) library, which in essence creates a new DDP client. This is very special since we now enjoy the same asynchronity, we implemented in our webapp, nativly. Whenever you Answer a question, the answers get updated live on other peoples screen.

The [MiniMongoDB](https://www.meteor.com/mini-databases) is realised nativly via Apple's [Core Data Framework](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html#//apple_ref/doc/uid/TP30001200-SW1), a steep learning curve at first, but a nice way to improve performance of your app.

###2. Reading material
* [DDP](https://www.meteor.com/ddp)
* [MVVM in iOS](http://www.teehanlax.com/blog/model-view-viewmodel-for-ios/)
* [ReactiveCocoa on GitHub](https://github.com/ReactiveCocoa/ReactiveCocoa)
* [ReactiveCocoa and Swift](http://blog.scottlogic.com/2014/07/24/mvvm-reactivecocoa-swift.html)

###3. Libraries & Dependencies
* [Meteor-iOS](https://github.com/martijnwalraven/meteor-ios)
* ~~[JawBone: ChartView](https://github.com/Jawbone/JBChartView)~~ _(not used anymore, made my own charts)_



_Jeroen Berrevoets_

