# GameHub

GameHub is your ultimate destination for gaming. With a vast library of games from all genres and platforms, you can
easily discover, browse, and play your favorite games right from your device. Our user-friendly interface makes it easy
to find the games you love, and our powerful search tools help you discover new games that you never knew existed.

<img src="https://github.com/ShabanKamell/GameHub/blob/main/blob/screenshpots/2-home.jpeg?raw=true" alt="Image" width="300" height="600"/>
<img src="https://github.com/ShabanKamell/GameHub/blob/main/blob/screenshpots/3-favorites.jpeg?raw=true" alt="Image" width="300" height="600"/>
<img src="https://github.com/ShabanKamell/GameHub/blob/main/blob/screenshpots/4-favorites_swipe.jpeg?raw=true" alt="Image" width="300" height="600"/>
<img src="https://github.com/ShabanKamell/GameHub/blob/main/blob/screenshpots/5-detail.jpeg?raw=true" alt="Image" width="300" height="600"/>
<img src="https://github.com/ShabanKamell/GameHub/blob/main/blob/screenshpots/1-home_empty.jpeg?raw=true" alt="Image" width="300" height="600"/>

# Important Note

If you come across the "Missing Libs framework" error during the initial build of the application, simply drag and drop
the Libs folder from the root directory into the files section of Xcode.

# Table of contents

- [Technologies & Frameworks](#technologies--frameworks)
- [Architecture](#architecture)
- [App Modules](#app-modules)
- [App Layers](#app-layers)
- [MVVM, Repository, and Data Sources](#mvvm-repository-and-data-sources)
- [MVVM Abstractions](#mvvm-abstractions)
- [Caching Strategy](#caching-strategy)
- [Reusable Components](#reusable-components)
- [Threading](#threading)
- [Asynchronous Operations Handling](#asynchronous-operations-handling)
- [Error Handling](#error-handling)
- [Network](#network)
- [Resources](#resources)
- [Caching](#caching)
- [Swift Package Manager Dependencies](#swift-package-manager-dependencies)
- [Third-Party Dependencies Integration](#third-party-dependencies-integration)
- [Project Dependencies](#dependencies)
- [Unit Tests](#unit-tests)
- [CI/CD, Fastlane](#cicd-fastlane)
- [Build Configurations](#build-configurations)
- [Crash Reporting](#crash-reporting)

# Technologies & Frameworks

- Swift
- SwiftUI
- Combine
- Async/Await
- Moya
- MVVM
- Repository and data sources patterns
- Modular Architecture

# Architecture

<img src="https://lh3.googleusercontent.com/drive-viewer/AFGJ81p4DmIvlILC6NelzQnBHWldi2tJgpEcnpiME0xp22UhOKM5EU6u_9ByQ_czLQwJ2eswUthakZUQHCLGnGMFAY0Ttxg-XA=s2560" alt="Image" width="550" height="400"/>

There are a lot of trade-offs to implement the app architecture. But we chose to go with
[The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) for the following
reasons:

**The Dependency Rule**: The most fundamental principle of clean architecture is the Dependency Rule, which states that
the dependencies between modules should flow inward, toward higher-level policy modules, and not outward, toward
lower-level implementation details. This allows for loose coupling between modules, which makes the code more modular
and easier to maintain.

**The Architecture**: The architecture of a clean system is divided into four layers: the Entities layer, which contains
the business objects; the Use Cases layer, which contains the application-specific business rules; the Interface
Adapters layer, which contains the adapters that convert data from the external world to the internal world and vice
versa; and the Frameworks and Drivers layer, which contains the external tools and libraries that the application uses.

**The SOLID Principles**: The **SOLID** principles are a set of principles for writing clean, maintainable code. They
stand for Single Responsibility, Open-Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion.
These principles provide guidance on how to write code that is modular, testable, and easy to maintain.

**The Clean Code**: The code in a clean architecture should be clean, readable, and easy to understand. This
means following good coding practices such as using meaningful variable and function names, writing clear and concise
comments, and avoiding duplication and unnecessary complexity.

**Testing**: Testing is an important part of clean architecture. The code should be designed in a way that makes it easy
to write unit tests, and automated tests should be run frequently to ensure that the code behaves as expected.

# App Modules

Our app is designed with a modular architecture, consisting of four main modules: **Screens**, **Core**, **Data**,
and **Presentation**. Each module is completely independent of the others, and can be added as a framework for increased
reusability and
modularity.

The **Screens** module contains all the screens of the app, while the **Presentation** module includes all shared and
reusable
UI components that can be used throughout the app. The **Data** module contains all files related to data, such as
network,
user defaults, caching, and other data files. Finally, the **Core** module contains all code that is not related to
**Presentation** or **Data**, such as business logic, algorithms, and other core functionalities.

To illustrate the benefits of this modular architecture, we have implemented a similar approach in another project,
where each module is available as a separate framework. This approach enables us to easily maintain and update each
module individually, without affecting the rest of the app. It also allows us to reuse modules in other projects,
resulting in faster build, development and improved overall code quality. To gain a better understanding of the modular
architecture of our app, we invite you to take a look at this project, https://github.com/ShabanKamell/Contacts-SwiftUI.

## App Layers

<img src="https://lh3.googleusercontent.com/drive-viewer/AFGJ81oxsttkYzf8NWd4Kf5-iLve7gqOmsRI7dKzH2Qefq3xoEsjedv2fjKiaeqexs7oQLCO9_KULxXMmtwIlbatM3XskmXZjA=s1600" alt="Image" width="350" height="300"/>


The app has a well-designed architecture that follows the principles of separation of concerns, which allows for
maintainability, scalability, and testability. It is divided into multiple layers, each with a specific responsibility:

**Presentation Layer**
This layer is responsible for displaying the user interface and handling user interactions. It
includes UI components such as SwiftUI views.

**ViewModel Layer**
This layer acts as an intermediary between the presentation layer and the data layer. It contains the
business logic of the app and manages the state of the UI. It also communicates with the repository layer to retrieve
and update data.

**Repository Layer**
This layer is responsible for providing data to the **ViewModel**. It abstracts the data source layer and
provides a clean, consistent interface for accessing data. It also handles caching and local storage.

**Data Source Layer**
This layer is responsible for communicating with external data sources such as a database or web service.
It provides an interface for the repository to retrieve data.

**Network Layer**
This layer is responsible for handling network requests and responses. It's communicated with the data source
layer to retrieve data from external APIs.

**Caching Layer**
This layer serves the purpose of caching data to facilitate offline usage and managing expired objects to ensure
efficient memory utilization.

**User Defaults Layer**
This layer is responsible for storing small amounts of data such as user preferences and settings. It
provides a simple interface for storing and retrieving data.

By separating the app into these layers, it is easier to maintain, test, and scale the app over time.

# MVVM, Repository, and Data Sources

MVVM, Repository pattern, and Data Sources are 3 essential concepts that can be used together to build modern and
maintainable iOS applications.

MVVM is an architectural design pattern that separates an application's concerns into three distinct layers: **Model**,
**View**, and **ViewModel**. The **Model** represents the data and business logic of the application, the View is
responsible for
displaying the user interface, and the **ViewModel** acts as an intermediary between the **Model** and the View,
providing data
to the View and handling user input from the View.

The **Repository** pattern is a design pattern that provides a layer of abstraction between the application and the data
persistence layer. It helps to isolate the data access logic from the rest of the application, making it easier to
maintain and test.

For example, the **SwiftUI** View might use **Combine** to subscribe to a data stream from the **ViewModel**. The **
Repository** is
responsible for fetching the data from a remote API or a local database and providing it to the **ViewModel**. The **
ViewModel**
can then subscribe to this publisher and update its own properties accordingly.

Overall, using **MVVM**, **Repository** pattern, and **Data Sources** together can help to create a clear separation of
concerns
in the application, making it easier to maintain and test. It can also provide a more reactive and declarative approach
to handling asynchronous data streams and user input events, which can lead to more concise and readable code.

# MVVM Abstractions

When implementing MVVM, it's important to abstract the basic components of the architecture to improve code reusability
and maintainability. One way to do this is by creating abstractions for the view, view model, and asynchronous
operations.

The **AppScreen** can be thought of as an abstraction for the view component in **MVVM**. It encapsulates the logic and
behavior of the view, making it easier to modify and reuse across different screens and components.

Similarly, the **AppViewModel** is an abstraction for the **ViewModel** component in **MVVM**. It acts as an
intermediary
between the view and the model, handling user input and updating the view based on changes in the model.

Finally, the **AsyncMan** abstraction is used to manage asynchronous operations in the application. It encapsulates the
logic for handling **Async/Await** calls, making it easier to manage and debug these operations throughout the codebase.

Overall, by abstracting these basic components in **MVVM**, you can create a more modular and maintainable application
with
improved code quality and reusability.

# Reusable Components

To ensure that our application is both scalable and maintainable, it is important to follow the "Don't Repeat
Yourself" (DRY) principle and maximize code reuse wherever possible.

One way to achieve this is by using reusable components throughout the application. For instance, we use
**AppTextField** as a component that can be reused in different parts of the application wherever a text field is
needed.
Similarly, we can use **PlainList** component that can be used in place of a regular list wherever appropriate.

By using such reusable components, we can not only reduce the amount of code we need to write but also make it easier to
maintain and update the application in the future. Additionally, it can also improve the consistency and coherence of
the application, as the same components are used throughout.

# Threading

The implementation of threading in our project utilizes **Async/Await**, which is an excellent addition from Apple.
Using this approach makes our code more concise, readable, and maintainable. By leveraging the power of **Async/Await**,
we
can easily write asynchronous code that is easier to understand and debug. This approach also helps us avoid complex and
error-prone code that can occur with traditional threading approaches. Overall, **Async/Await** provides a streamlined
and
efficient way to handle concurrency in our project, helping us to deliver a high-quality and reliable product.

# Asynchronous Operations Handling

In the **Threading** section discussed earlier, the project utilizes the powerful **Async/Await** feature to handle
asynchronous
operations. To streamline the management of these operations throughout the codebase, the project also employs an
abstraction called **AsyncMan**. This abstraction encapsulates the necessary logic for handling **Async/Await** calls,
which simplifies debugging and management of the asynchronous operations. By using this approach, the codebase becomes
more organized and maintainable, while also reducing the potential for errors and improving overall code quality.

# Error Handling

To effectively handle errors that occur during asynchronous operations, the project implements a strategy pattern using
the **ErrorHandler** protocol. This protocol can be adopted by any struct or class to add error handling for specific
types of errors. By leveraging the **ErrorHandler** protocol, the project can handle errors more efficiently and
effectively, reducing the potential for disruptions to user experience and improving overall app stability.

> For instance, the UnauthorizedErrorHandler is an example of an error handler that addresses token expiration issues.
> When a token expires, this error handler refreshes the token and retries the failed request, preventing the need for
> the user to manually log back in.

# Network

The network layer in our app is implemented using the [Moya](https://github.com/Moya/Moya.git) library, which provides a
simplified interface for networking with Alamofire. Moya abstracts away the complexities of Alamofire and makes it
easier to define and consume APIs using enums. With Moya, we can define our API endpoints as a set of cases in an enum,
making our networking code more readable, maintainable, and testable. This approach also helps to decouple our
networking layer from our business logic, making it easier to make changes to our network requests without affecting the
rest of our app.

# Resources

One significant limitation of iOS resources is that they rely on String identifiers to reference them, which can lead
to bugs when these identifiers are changed without updating all references. To mitigate this issue, I'm using
[SwiftGen](https://github.com/SwiftGen/SwiftGen) to generate strongly-typed classes for the resources. This approach
allows us to refer to resources using code rather than strings, which can improve both readability and
maintainability of our code.

> The SwiftGen code is located in `/etc/swiftgen` and in the project's build phase, it's invoked through the script
> `/etc/scripts/CommonTargetScripts.sh`. When SwiftGen runs, it generates several classes, including Assets.swift,
> Strings.swift, Colors.swift, and Fonts.swift. These generated classes are typically placed in the App/resources folder
> of the project.

# Caching

Although there are various options available for implementing offline caching, such as NSCache, CoreData, and Realm, we
have decided to use a cache library. While each approach has its own trade-offs, we believe that
the [Cache](https://github.com/hyperoslo/Cache) library will be the most suitable solution for my particular use case.
The [Cache](https://github.com/hyperoslo/Cache) library is a powerful caching solution that provides many benefits,
including:

- Compatibility with Swift Codable, making it easy to save and load any object that conforms to the Codable protocol
  using the Storage feature.
- Hybrid storage with both memory and disk options, allowing for efficient use of resources and fast access to
- cached data.
- Customizable options for disk and memory storage through the DiskConfig and MemoryConfig classes.
- Built-in support for object expiry and cleanup, ensuring that expired objects are automatically removed from the
  cache.
- Thread safety, allowing for concurrent access to the cache from multiple queues or threads.
- Synchronous access by default, with support for asynchronous APIs for more complex use cases.
- Extensive unit testing and documentation, ensuring that the library is reliable and easy to use.

# Caching Strategy

Our app adopts an **offline-first approac**h, which means that we prioritize serving data from the local cache. When a
user
requests data, we first check if it's available in the cache. If the data is present, we retrieve and display it
immediately to ensure a smooth user experience. If the data is not available in the cache, we fetch it from the remote
server and update the cache accordingly. Once the cache is updated, we reflect the changes on the user interface,
ensuring that the user always sees the latest data.

> The cache is set to expire after 30 minutes and is subsequently deleted when a request for the cache is made at any
> time.

# Swift Package Manager Dependencies

The **Swift Package Manager** is the preferred dependency manager for the app. To manage dependencies, we have chosen to
use a
Package.swift file instead of relying on Xcode's default approach. This decision was made for several reasons. Firstly,
adding packages with Package.swift is straightforward and intuitive. Secondly, having all packages listed in a single
file makes it easier to track changes to dependencies in the Git history. Additionally, using Package.swift allows for
greater flexibility in managing dependencies outside of Xcode. Overall, using the **Swift Package Manager** with a
**Package.swift** file has proven to be a reliable and efficient approach for managing dependencies in my app.

# Third-Party Dependencies Integration

The third-Party dependencies can introduce complexity into our codebase. If they are not isolated properly,
they can make our code more difficult to maintain and upgrade.

To isolate third-party libraries, we use design patterns like the **Adapter** or **Facade pattern**. These
patterns allow to create a layer of abstraction between the app code and the third-party library, so that the app
only interacts with a simplified interface. This can make it easier to change or replace the underlying library without
affecting the rest of your code.

As an example, I have implemented an interface for reporting messages to the user in our app. The **Reportable**
protocol
defines the contract for reporting messages, and it depends on the SwiftMessages library for displaying the messages.
By using this interface, we can easily swap out the SwiftMessages library with another library that provides the same
functionality, without affecting the app code. This is because the interface remains the same, and only the underlying
implementation needs to be changed.

# Dependencies

## [SwiftUINavigator](https://github.com/Open-Bytes/SwiftUINavigator) (My own library)

SwiftUINavigator is an on-the-fly approach for handling navigation in SwiftUI. It provides a familiar way of handling
navigation similar to UIKit, where you can push or present a view controller without the need to declare links or
local
state variables. This approach is more flexible and allows for dynamic navigation, making it easier to build more
complex navigation flows in your SwiftUI app. Unlike traditional navigation patterns in SwiftUI, SwiftUINavigator
offers
a more intuitive and straightforward way of managing your app's navigation hierarchy.

## [SwiftMessages](https://github.com/SwiftKickMobile/SwiftMessages)

SwiftMessages is a very flexible view and view controller presentation library for iOS.
Message views and view controllers can be displayed at the top, bottom, or center of the screen, or behind navigation
bars and tab bars. There are interactive dismiss gestures including a fun, physics-based one. Multiple background
dimming modes. And a lot more!

## [Moya](https://github.com/Moya/Moya.git)

You're a smart developer. You probably use Alamofire to abstract away access to URLSession and all those nasty details
you don't really care about. But then, like lots of smart developers, you write ad hoc network abstraction layers.
They are probably called "APIManager" or "NetworkModel", and they always end in tears.

## [Cache](https://github.com/hyperoslo/Cache.git)

Cache doesn't claim to be unique in this area, but it's not another monster library that gives you a god's power. It
does nothing but caching, but it does it well. It offers a good public API with out-of-box implementations and great
customization possibilities. Cache utilizes Codable in Swift 4 to perform serialization.

## [SwiftGen](https://github.com/SwiftGen/SwiftGen)

SwiftGen is a tool to automatically generate Swift code for resources of your projects (like images, localised
strings, etc), to make them type-safe to use.

## [Kingfisher](https://github.com/onevcat/Kingfisher.git)

Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. It provides you a chance
to use a pure-Swift way to work with remote images in your next app.

## [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager.git)

While developing iOS apps, we often run into issues where the iPhone keyboard slides up and covers the
UITextField/UITextView. IQKeyboardManager allows you to prevent this issue of keyboard sliding up and covering
UITextField/UITextView without needing you to write any code or make any additional setup. To use IQKeyboardManager
you simply need to add source files to your project.

# Unit Tests

**Unit tests** have been implemented for several components of the business logic, including **HomeVM**, **
GamesRepo**,
**GamesLocalDataSrc**, and **GamesRemoteDataSrc**. Unit tests have been implemented for the aforementioned
components
using **XCTest**, and mock and stub techniques have been employed without relying on any third-party libraries.

# CI/CD, Fastlane

The integration of **Fastlane** CI/CD enables automated builds, testing, and deployment of the app. This
reduces the time and effort required for manual testing and deployment. Additionally, Fastlane implementation supports
uploading the app to TestFlight and Firebase App Distribution, which provides a streamlined and efficient way to
distribute the app to beta testers and stakeholders.

> The implementation is located in `/fastlane/Fastfile` and other files in the folder.

# Build Configurations

There are four different build configurations that are used to manage the product lifecycle: **Debug**, **Testing**,
**Staging**, and **Release**. Each build configuration serves a specific purpose in the development process.

The **Debug** build configuration is used exclusively for development purposes, allowing developers to test and debug
their code.

The **Testing** build configuration is used for testing the product by quality assurance (QA) testers. This build is
more stable than the Debug build, but not yet ready for release.

The **Staging** build configuration is used for preparing the product for release. This build is more polished and
stable than the **Testing** build, and is used for final testing and reviews.

The **Release** build configuration is used for production purposes, and is the final version of the product that is
released to the public.

Each configuration has its unique bundle name to enable installing all of them on the same device.

And each build configuration has its own app name with a suffix that indicates the build configuration, such as
"NAME-debug" or "NAME-testing". This naming convention helps to differentiate between the different build
configurations.

Similarly, each build configuration has its own unique icon that indicates the build configuration.

By using different build configurations, developers can streamline the development process and ensure that the product
is thoroughly tested and reviewed before being released to the public.

# Crash Reporting

The **AppCrashytics** class serves as an essential interface for **Crashlytics**, a tool that helps track and analyze
app
behavior. It allows for the recording of any caught exceptions that occur within the app, providing valuable insights
into potential issues and areas for improvement. By leveraging the **AppCrashytics** interface, developers can better
understand how their app is behaving in real-world scenarios and take proactive measures to address any issues that may
arise. This ultimately leads to a more stable and reliable app for users.

## License

**Apache License**, Version 2.0

<details>
    <summary>
        click to reveal License
    </summary>

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

</details>

