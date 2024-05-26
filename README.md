# GameStop
#### An application for game lovers. You can browse through games, like them and access their details easily.

## Table Of Contents
- [Features](#features)
  - [In app Gifs](#in-app-gifs)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Installation](#installation)
- [Known Issues](#known-issues)
- [Nice to have](#nice-to-have)

## Features
#### Browse Games:
- Explore the Gaming world.
- The data for the games comes from a real-time database. You may need to retry several times for the app to load as there may be API related issues.

#### Game Details
- Learn more about games with videos, photos, and information.
- Drop a heart for your favorite games.

## In app Gifs and Screenshots
| App Gif |
| -------- |
| <img src="https://github.com/guraygul/GameStop/assets/58820744/d655cef4-0bad-4bbf-b597-2eea1c1b216d" alt="GameStopGif" width="300" height="380"> |

| Home Screen | Detail Screen |
| -------- | -------- |
| <img src="https://github.com/guraygul/GameStop/assets/58820744/dd4fd054-fbd7-4188-aa2b-ce1865bbdd0f" alt="HomeScreen" width="300" height="380"> | <img src="https://github.com/guraygul/GameStop/assets/58820744/6e876955-a802-484d-a006-1d4cc032d7d5" alt="DetailScreen" width="300" height="380"> |

| Search Screen | Favorite Screen |
| -------- | -------- |
| <img src="https://github.com/guraygul/GameStop/assets/58820744/0a698bb8-c262-4491-a468-11e96b91bc96" alt="SearchScreen" width="1075" height="2048"> | <img src="https://github.com/guraygul/GameStop/assets/58820744/dc62cd7c-d9b3-474f-b6c4-718acfa0b932" alt="FavoriteScreen" width="300" height="380"> |

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
