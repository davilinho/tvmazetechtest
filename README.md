# TV Maze Test API

[![OS Version: iOS 13.0](https://img.shields.io/badge/iOS-13.0-green.svg)](https://www.apple.com/es/ios/ios-13/)
[![Build Status](https://app.bitrise.io/app/5450f7e0cea55034/status.svg?token=sQv4V01buaiKr2JLluNpmg&branch=master)](https://app.bitrise.io/app/5450f7e0cea55034)
[![codecov](https://codecov.io/gh/davilinho/tvmazetechtest/branch/master/graph/badge.svg?token=DENCY7C34X)](https://codecov.io/gh/davilinho/tvmazetechtest)

In this document, the main details of the development, carried out under the Swift language, are exposed.

## Table of contents

- [TV Maze Test API](#tvmazetechtest)
  * [Table of contents](#table-of-contents)
  * [Project target](#project-target)
    + [Architecture and design pattern](#architecture-and-design-pattern)
    + [Storyboards and navigation](#storyboards-and-navigation)
    + [Dependency injection](#dependency-injection)
    + [Local storage](#local-storage)
  * [Tests](#tests)
    + [Unit tests](#unit-tests)
    + [Snapshot tests](#snapshot-tests)
    + [UI tests](#ui-tests)
  * [Third-party frameworks](#third-party-frameworks)
    + [AlamofireImage](#alamofireimage)
    + [SDWebImage](#sdwebImage)
    + [Nimble](#nimble)
    + [SnapshotTesting](#snapshottesting)
    + [SwiftLint](#swiftlint)
    + [Lottie](#lottie)
  * [Tools](#tools)
    + [Continuous Integration server](#continuous-integration-server)
    + [Code coverage reports](#code-coverage-reports)
  * [Branching strategy](#branching-strategy)

## Project target

The main objective of the project is to show a clean, tested and simple architecture, based on a [TV Maze API](https://www.tvmaze.com/api#show-main-information), where a simple master-detail will be shown, with basic functions such as: list, paginate, search and show detail.

![Demo](https://github.com/davilinho/tvmazetechtest/blob/develop/demo.gif)

## Architecture and design pattern

As the main architecture of the project, we have used the MVVM pattern.

As usual in MVVM pattern, the views notify their view models of any user interaction, the view models perform the corresponding actions and request the views to refresh via delegate (if necessary). 

To allow this communication between the View and the VieW Model, an `Observable` object has been created, which allows the View to subscribe to the changes that occur in the ViewModel, in such a way that it can be totally independent from the view, if need to know how it is formed.

## Storyboards and navigation

The views have been created with Auto-Layout.

To allow communication between them, a neutral element called `Wireframe` has been created, which is responsible for communicating the scenes without the need for their controllers to know how it works.

## Dependency injection

To solve the dependency injection, a propertywrapper called `Inject` has been created, which is in charge of storing the dependency graph.

By using the `Resolver` class, you can get these dependencies, by making use of `@Inject`.

## Local storage

The app allow to enter and run on offline mode futher local storage. To use it, there are the `StoreDatasource` that implements a generic `Store` object witch inheritance from Codable object.

Through `@Store` propertyWrapper, can manage the basic operations like (retrieve, save and clear) to work with it.
  
## Tests

### Unit tests

Unit tests are tests of isolated components or business logic using mock objects. Therefore, as a general basis, at the very least every view model should include unit tests when using the MVVM architecture. 

Extensive unit testing coverage (> 90%) has been performed.

![Coverage](https://github.com/davilinho/tvmazetechtest/blob/develop/coverage.png)

As usual, all of these tests use mock objects to pass data or receive delegate calls and perform validations.

### Snapshot tests

By means of the framework **SnapshotTesting** (see [the corresponding section](#snapshottesting) below) we included snapshot tests of almost every view in the app, from the simplest cell to a whole view controller. In particular, we implemented snapshot tests for the following classes:
* `ListViewController`
* `DetailViewController`

Snapshots can be found in the subfolders of:
* `tvmazetechtest/tvmazetechtestTests/Source/Features/List/Presentation/__Snapshots__`
* `tvmazetechtest/tvmazetechtestTests/Source/Features/Detail/Presentation/__Snapshots__`

## Third-party frameworks

Since the frameworks were not included in the original repository, one of the first things we had to do is perform a `pod install --repo-update` in the root folder to install dependencies. After that, we reviewed all the dependencies included in the `Podfile` and their usage in the code. As a consequence, we remove all of the dependencies except for `AlamofireImage`, which was the only one under use.

During the implementation of the search feature and the tests we decided to use some additional dependencies, which we discuss in the following.

**Note:** The `Pods/` folder in now checked into the repository, so that we can just download and press `Run` to execute the app in the simulator.

### AlamofireImage

`AlamofireImage` is a library that enables to easily manage downloading and setting images from the internet. It has a simple and clear API, and includes a built-in cache system to avoid downloading the same image again and again.

**Source:** [https://github.com/Alamofire/AlamofireImage](https://github.com/Alamofire/AlamofireImage)

### SDWebImage

`SDWebImage` provides an async image downloader with cache support.

**Source:** [https://github.com/SDWebImage/SDWebImage](https://github.com/SDWebImage/SDWebImage)

### Nimble

`Nimble` is a library that allows you to express expectations using a natural, easily understood language, for make unit testing.

**Source:** [https://github.com/Quick/Nimble](https://github.com/Quick/Nimble)

### SnapshotTesting

`SnapshotTesting` is a library similar to [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case) (formerly maintained by Facebook, now maintained by Uber) developed by the awesome team of Point-Free. Contratry to `iOSSnapshotTestCase`, `SnapshotTesting` is written purely in Swift and is compatible with [Nimble](https://github.com/Quick/Nimble) using a plugin.

This library enables us to snapshot test views, server responses and more in several formats, from images to plain text files, which makes it outstandingly versatile.

**Source:** [https://github.com/pointfreeco/swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)

### SwiftLint

`SwiftLint` A tool to enforce Swift style and conventions, loosely based on the now archived [GitHub Swift Style Guide](https://github.com/github/swift-style-guide).

SwiftLint enforces the style guide rules that are generally accepted by the Swift community. These rules are well described in popular style guides like [Ray Wenderlich's Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).

**Source:** [https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint)

### Lottie

Lottie is a mobile library for Android and iOS that natively renders vector based animations and art in realtime with minimal code.

Lottie loads and renders animations and vectors exported in the bodymovin JSON format.

**Source:** [https://github.com/airbnb/lottie-ios](https://github.com/airbnb/lottie-ios)

## Tools

In addition to the feature implementation and the tests implementation, we added several tools to the repository which helped us during this assignment.

### Continuous Integration server

This repository is *public*, we created a Bitrise CI instance attached to it to run tests and perform additional tasks automatically when several conditions met. In combination with our [Branching strategy](#branching-strategy) and some protection rules on `master` and `develop`, we ensure that no code was ever merged to these branches without passing the proper tests.

The current jobs and triggers are the following:
- **compile_app**: Just compiles the app. This job is executed when a pull request to `master` or `develop` is opened, to prevent merging any change that breaks the app build. If this job fails, no further jobs are executed.
- **unit_test**: Runs the unit tests suite. This job is executed when a pull request to `master` or `develop` is opened.
- **ui_test**: Runs the UI tests suite. This job is executed when a pull request to `master` or `develop` is opened.

### Code coverage reports

This repository is *public*, we created a CodeCov instance attached to it to gather code coverage data and display it as a report. This code coverage data is generated automatically by Xcode command line tools when running tests if properly set, and gathered and uploaded to CodeCov using Birtise CI.

You may take a look at the code coverage reports for `master` in CodeCov by following this link:

[https://app.codecov.io/gh/davilinho/tvmazetechtest](https://app.codecov.io/gh/davilinho/tvmazetechtest)

## Branching strategy

In order to illustrate our usage of good practices in Git, we used a variant of [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) during this assignment. In pure GitFlow, a feature is implemented in a single branch named `feature/name-of-feature`.

I always merged my changes using pull requests, which in turn triggered builds in Bitrise CI that prevented me from merging any breaking changes.
