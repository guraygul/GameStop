# GameStop
#### An application for game lovers. You can browse through games, like them and access their details easily.

## Table Of Contents
- [Features](#features)
  - [In app Gifs and Screenshots](#in-app-gifs-and-screenshots)
  - [Screens](#screens)
  - [Used Technologies](#used-technologies)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Installation](#installation)
- [Known Issues](#known-issues)
- [Nice to have](#nice-to-have)

# Features
## In app Gifs and Screenshots
| App Gif |
| -------- |
| ![GameStopGif](https://github.com/guraygul/GameStop/assets/58820744/689eed44-a9c7-4162-b250-83fb5ffb3620) |

| Home Screen | Detail Screen |
| -------- | -------- |
| <img width="510" alt="SCR-20240526-tpwu" src="https://github.com/guraygul/GameStop/assets/58820744/a82a5474-e97c-4219-8515-c497402497f8"> | <img width="554" alt="SCR-20240526-tpzz" src="https://github.com/guraygul/GameStop/assets/58820744/0b7be651-60dd-48ba-a323-5f19c5bafb74"> |

| Search Screen | Favorite Screen |
| -------- | -------- |
| <img width="554" alt="SCR-20240526-tqeh" src="https://github.com/guraygul/GameStop/assets/58820744/4143f50f-1633-430e-a7c3-968c897cf4d7"> | <img width="554" alt="SCR-20240526-tqev" src="https://github.com/guraygul/GameStop/assets/58820744/dadcccc5-cdb0-4665-8c77-ec5f7327d25e"> |

## Screens
#### Browse Games:
- Explore the Gaming world.
- The data for the games comes from a real-time database. You may need to retry several times for the app to load as there may be API related issues.

#### Game Details
- Learn more about games with videos, photos, and information.
- Drop a heart for your favorite games.

## Used Technologies
- UIKit
- MVVM
- Programmatic UI
- Kingfisher
- AVKit

## Tech Stack
- Xcode: Version 15.3
- Language: Swift 5.10
- Minimum iOS Version: 17.4
- Dependency Manager: SPM

## Architecture
| MVVM Architecture |
| -------- |
| <img width="900" alt="MVVM" src="https://github.com/guraygul/GameStop/assets/58820744/332583ae-2d7f-4c47-a89b-866bb68444de"> |

In developing GameStop App, the programmatically approuch and MVVM (Modal-View-ViewModel) architecture are being used for these key reasons:

- Separation of Concerns: MVVM cleanly separates the UI (View) from business logic and data (ViewModel), promoting code clarity and ease of maintenance.
- Testability: MVVM enables easy unit testing of ViewModel logic independently of the UI, leading to more robust and reliable code.
- Code Reusability: ViewModel classes in MVVM can be reused across different views, reducing duplication and promoting modular development.
- UI Responsiveness: MVVM's data binding mechanisms ensure that the UI updates automatically in response to changes in underlying data, enhancing user experience.
- Maintainability and Scalability: With its modular design, MVVM simplifies maintenance and enables the addition of new features without disrupting existing functionality.
- Support for Data Binding: MVVM aligns well with data binding frameworks, reducing boilerplate code and improving developer productivity.
- Enhanced Collaboration: MVVM's clear separation of concerns allows developers with different skill sets to work concurrently on different parts of the application.
- Adaptability to Platform Changes: MVVM provides a flexible architecture that can easily adapt to changes in platform requirements or UI frameworks, ensuring long-term viability.

## Getting Started
### Requirements
Before you begin, ensure you have the following:
- Xcode installed

Also, make sure that these dependencies are added in your project's target:
- [Kingfisher](https://github.com/onevcat/Kingfisher): Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web, offering features like asynchronous image loading, smooth scrolling, and a simple API.

### Installation
1. Clone the repository:
```
git clone https://github.com/guraygul/GameStop.git
```
2. Open the project in Xcode::
```bash
cd GameStop
open GameStop.xcodeproj
```
3. Add required dependencies using Swift Package Manager:
```
KingFisher
```
4. Build and run the project.

## Known Issues
- Search screen and favorites screen show an emptyView when loading games

## Nice to have
- It would be better if we add a share button in the detail screen
- More refactoring could be done for the Controllers.
