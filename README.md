# TV Maze Test API

[![OS Version: iOS 13.0](https://img.shields.io/badge/iOS-13.0-green.svg)](https://www.apple.com/es/ios/ios-13/)
[![Build Status](https://app.bitrise.io/app/5450f7e0cea55034/status.svg?token=sQv4V01buaiKr2JLluNpmg&branch=master)](https://app.bitrise.io/app/5450f7e0cea55034)
[![Coverage Status](https://coveralls.io/repos/github/davilinho/tvmazetechtest/badge.svg?branch=master)](https://coveralls.io/github/davilinho/tvmazetechtest?branch=master)

In this manuscript we explain and discuss the changes that have been implemented, along with some additional tools that have been added to the project or the repository.

## Table of contents

- [TV Maze Test API](#tvmazetechtest)
  * [Table of contents](#table-of-contents)
  * [Code refactor](#code-refactor)
    + [Code styling](#code-styling)
    + [Architecture and design pattern](#architecture-and-design-pattern)
      - [Service and repository layers](#service-and-repository-layers)
      - [Model-View-ViewModel architecture](#model-view-viewmodel-architecture)
      - [A comment on reactive programming](#a-comment-on-reactive-programming)
    + [Storyboards and XIB files](#storyboards-and-xib-files)
    + [Dependency injection](#dependency-injection)
  * [Tests](#tests)
    + [Unit tests](#unit-tests)
    + [Snapshot tests](#snapshot-tests)
    + [UI tests](#ui-tests)
      - [MockServer](#mockserver)
  * [Third-party frameworks](#third-party-frameworks)
    + [AlamofireImage](#alamofireimage)
    + [SnapshotTesting](#snapshottesting)
  * [Tools](#tools)
    + [Continuous Integration server](#continuous-integration-server)
    + [Code coverage reports](#code-coverage-reports)
  * [Branching strategy](#branching-strategy)
  
## Tests

Although both the unit tests and the UI tests target were already included in the original code base, there were no tests implemented besides the default empty tests that are created when the test bundles are added to a Xcode project. We extensively expanded both testing targets to raise code coverage to nearly 100% and cover several user journeys when using this section of the app.

### Unit tests

Unit tests are tests of isolated components or business logic using mock objects. Therefore, as a general basis, at the very least every view model should include unit tests when using the MVVM architecture. Furthermore, when using repositories in Android Clean Architecture, all of the repositories should include unit tests too. Therefore we have implemented unit tests for the following components:
* Mappers from server model object `SearchResponse` to domain model objects `Artist` and `Track`
* Repository `SearchRepository`
* View models `HomeViewModel`, `SearchResultCollectionViewModel`, `SearchResultTableViewModel`, `TrackDetailsViewModel` and `TrackPlayerViewModel`.

As usual, all of these tests use mock objects to pass data or receive delegate calls and perform validations.

### Snapshot tests

By means of the framework **SnapshotTesting** (see [the corresponding section](#snapshottesting) below) we included snapshot tests of almost every view in the app, from the simplest cell to a whole view controller. In particular, we implemented snapshot tests for the following classes:
* `HomeViewController`
* `TrackDetailsViewController`
* `SearchResultCollectionCell`
* `SearchResultTableCell`
* `EdgeInsetLabel`

The only view without snapshot tests is the `TrackPlayerViewController` since it is a straighforward subclass of `AVPlayerViewController` and we considered unnecessary: it's usage is already covered by UITests.

Snapshots can be found in the subfolders of `ABA MusicTests/Source/Views tests/__Snapshots__/`.

## Third-party frameworks

Since the frameworks were not included in the original repository, one of the first things we had to do is perform a `pod install --repo-update` in the root folder to install dependencies. After that, we reviewed all the dependencies included in the `Podfile` and their usage in the code. As a consequence, we remove all of the dependencies except for `AlamofireImage`, which was the only one under use.

During the implementation of the search feature and the tests we decided to use some additional dependencies, which we discuss in the following.

**Note:** The `Pods/` folder in now checked into the repository, so that we can just download and press `Run` to execute the app in the simulator.

### AlamofireImage

`AlamofireImage` is a library that enables to easily manage downloading and setting images from the internet. It has a simple and clear API, and includes a built-in cache system to avoid downloading the same image again and again.

**Source:** [https://github.com/Alamofire/AlamofireImage](https://github.com/Alamofire/AlamofireImage)

### PromiseKit

`PromiseKit` simplify asynchronous programming, freeing you up to focus on the more important things. They are easy to learn, easy to master and result in clearer, more readable code.

PromiseKit is a thoughtful and complete implementation of promises for any platform that has a swiftc. It has excellent Objective-C bridging and delightful specializations for iOS, macOS, tvOS and watchOS. It is a top-100 pod used in many of the most popular apps in the world.

**Source:** [https://github.com/mxcl/PromiseKit](https://github.com/mxcl/PromiseKit)

### SnapshotTesting

`SnapshotTesting` is a library similar to [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case) (formerly maintained by Facebook, now maintained by Uber) developed by the awesome team of Point-Free. Contratry to `iOSSnapshotTestCase`, `SnapshotTesting` is written purely in Swift and is compatible with [Nimble](https://github.com/Quick/Nimble) using a plugin.

This library enables us to snapshot test views, server responses and more in several formats, from images to plain text files, which makes it outstandingly versatile.

**Source:** [https://github.com/pointfreeco/swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)

## Tools

In addition to the feature implementation, the code refactor and the tests implementation, we added several tools to the repository which helped us during this assignment.

### Continuous Integration server

Since this repository is *public* (since it's forked from a *public* repository), we created a Travis CI instance attached to it to run tests and perform additional tasks automatically when several conditions met. In combination with our [Branching strategy](#branching-strategy) and some protection rules on `master` and `develop`, we ensure that no code was ever merged to these branches without passing the proper tests.

The current jobs and triggers are the following:
- **Compile**: Just compiles the app. This job is executed when a pull request to `master` or `develop` is opened, to prevent merging any change that breaks the app build. If this job fails, no further jobs are executed.
- **Run unit tests**: Runs the unit tests suite. This job is executed when a pull request to `master` or `develop` is opened.
- **Run UI tests**: Runs the UI tests suite. This job is executed when a pull request to `master` or `develop` is opened.
- **Gather code coverage data**: Runs the complete tests suites. If all test succeed, the coverage data is uploaded to Coveralls using Slather (see [Code coverage reports](#code-coverage-reports) below). This job is executed when a commit is pushed to either `master` or `develop`. Note that since both branches are protected and only pushes by means of pull requests are allowed, tests should always succeed (since they must succeed to enable merging).

### Code coverage reports

Since this repository is *public* (since it's forked from a *public* repository), we created a Coveralls instance attached to it to gather code coverage data and display it as a report. This code coverage data is generated automatically by Xcode command line tools when running tests if properly set, and gathered and uploaded to Coveralls using [Slather](https://github.com/SlatherOrg/slather).

You may take a look at the code coverage reports for `master` in Coveralls by following this link:

[https://coveralls.io/github/davilinho/tvmazetechtest](https://coveralls.io/github/davilinho/tvmazetechtest)
