# Silofit
Silofit is a small demo project with Firebase Authentication and Realtime Database.

## Dependency Management:
Two dependency management tools are used in this project: `CocoaPods` and `Swift Package Manager`.

Swift Package manager is my prefered dependency management tool, mainly becuase:
1. It's natively integrated into Xcode. This could be a potential advantage for CI/CD purpose, because it basically removes an extra dependency, which is the dependency management tool itself.
2. Xcode automatically manages when packages is compiled, how they are cached and how they are linked. This could improve the compile time (for a clean build, without any extra script, pods are built along with the app) and app launch time (for this project, packages are built into libraries, which are statically linked to the app).
3. There are several exciting new features that are coming soon to Swift Package Manager, such as [SE-0271](https://github.com/apple/swift-evolution/blob/master/proposals/0271-package-manager-resources.md) and [SE-0272](https://github.com/apple/swift-evolution/blob/master/proposals/0272-swiftpm-binary-dependencies.md). With the community working hard to bring all those useful features to it, I think Swift Package Manager could become mainstream pretty soon.

For this project, CocoaPods is used only for Firebase.

## Architecture:
This project uses `MVVM` architecture. Besides, protocol-oriented programming is also widely used in this project.

## Design Framework:
This poject includes a simple "design framework": UI elements are standardized with subclasses of its corresponding UIKit classes; "magic number" for layout are centralized as `Style`; colors and fonts are also managed by corresponding utilities (`StyleFont` & `StyleColor`. The app actually supports dark mode, and it bascially comes free because of `StyleColor`.).

## Unit Test:
Because of the MVVM architecture, `dependency injection` is fairly easy in this project: each view model has all of its dependencies injected through its initializer, so they can be substituted with mock ones easily during unit test. Similar idea can also be used for UI testing: by initializing with a mock view model, the UI of a view controller can be tested without communicating with back-end at all.

As an example, unit test for `MapViewModel` is implemented. It used 2 mock services, which provides "local" authentication and `Space` data. This way, the unit test doesn't rely on Firebase at all. For simplicity, it focuses on testing positive cases (i.e. most of the error cases for request is not tested), and has code coverage of 94.5%.

## Known issues:
1. On the `GalleryViewController`, during rotation, there's a "unnatural" scrolling on the collection view.
2. Also on `GalleryViewController`, at run-time, there are several "constraint breaking" warnings. It's all related to something like `UIView-Encapsulated-Layout-Width' UIView:0x7ff9bcfc3a00.width == 50`, which is the default width/height constraint for UICollectionViewCell. It's a "common" thing for self-sizing collection view cells, which I've encountered several times cross different projects. Sometimes, it could be fixed by setting high priorities on certain constraints. However, I tried multiple ways this time, but cannot find a fix. It's quite annoying but doesn't break the layout on screen.


