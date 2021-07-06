# GemCommonsKit

Most common features that are commonly used and/or reusable can be found in this repo.

## Getting Started

GemCommonsKit requires Swift 5.1.

### Setup for integration:

-   **Carthage:** Put this in your `Cartfile`:

        github "gematik/ref-GemCommonsKit" ~> 1.0

### Setup for development

You will need [Bundler](https://bundler.io/), [XcodeGen](https://github.com/yonaskolb/XcodeGen)
and [fastlane](https://fastlane.tools) to conveniently use the established development environment.

1.  Checkout (and build) dependencies and generate the xcodeproject

        $ make setup

2.  Build the project

        $ make cibuild

## Use

Logging with `DLog()`:

    DLog("Any message")
