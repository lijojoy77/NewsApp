# NewsApp README

## Overview

NewsApp is a Swift-based mobile application designed to provide users with up-to-date news articles from various categories and countries. The app allows users to filter news by category and country, view article details, and stay informed about the latest developments worldwide.

## Classes and Usage

### `VCHome` (View Controller - Home)

- **Purpose**: This view controller is the home screen of the NewsApp, responsible for displaying a list of news articles.

- **Usage**:
  - Loads and displays news articles using the `WebService` class.
  - Supports pagination for infinite scrolling.
  - Allows users to filter news by category and country using the `FilterList` popover.
  - Provides pull-to-refresh functionality.
  - Navigates to the `VCHomeDetail` view controller when a news article is selected.
  
### `VCHomeDetail` (View Controller - Article Details)

- **Purpose**: This view controller displays the details of a selected news article, including the title, publication information, source, description, and an associated image.

- **Usage**:
  - Displays the details of a selected news article.
  - Supports navigation back to the home screen.
  - Provides a clean and user-friendly interface for viewing individual news articles.

### `FilterList` (View Controller - Filter List)

- **Purpose**: This view controller presents a list of categories and countries that users can select as filters for news articles.

- **Usage**:
  - Allows users to select categories and countries for filtering news articles.
  - Passes the selected filters back to the calling view controller.
  - Provides a "Done" button to apply selected filters and dismiss the filter list.
  
### `WebService` (Service - Web API Communication)

- **Purpose**: This service class handles communication with the news API to fetch news articles.

- **Usage**:
  - Sends HTTP requests to the news API using URLSession.
  - Decodes JSON responses into Swift objects using the Codable protocol.
  - Provides a `loadService` function for loading data from a URL asynchronously.

### `GlobalFunctions` (Utility Class)

- **Purpose**: This utility class contains various global functions and constants used throughout the app.

- **Usage**:
  - Contains functions for calculating time ago since a date and setting up the custom navigation bar.
  - Defines constants for the API key, base URL, and other global settings.

### Extensions (`UIViewController` and `Extensions+UIView`)

- **Purpose**: These extensions provide additional functionality and UI customization to view controllers and UIViews.

- **Usage**:
  - The `UIViewController` extension customizes the navigation bar appearance.
  - The `Extensions+UIView` extension adds functions for setting up custom navigation bar buttons and other UI enhancements.

## Getting Started

To run NewsApp locally, follow these steps:

1. Clone the repository to your local machine.
2. Open the Xcode project file (`NewsApp.xcodeproj`).
3. Build and run the app on the iOS simulator or a physical device.

## Dependencies

The NewsApp uses the following dependencies:

- SDWebImage: For asynchronous image loading and caching.

## License

This project is licensed under the [MIT License](LICENSE).
