# Movie Poster Quiz

**Movie Poster Quiz** is a quiz about movie posters where each question presents you with a movie overview text. Your task is to identify the correct movie poster from a choice of four options. 


## Features
- **Extensive Movie Database**: Questions are sourced from hundreds of thousands of movies provided by  [TheMovieDB.org](https://www.themoviedb.org/).
- **High Score Leaderboard**: Integrated with Apple's Game Center to track scores and enable competitive play.

- **Adjustable Gameplay Feel**: The balance between trivia-like questions and logic-based questions is controlled by popularity parameters. The more the quiz focuses on popular movies, the more it feels like a traditional trivia quiz. Conversely, the more it includes lesser-known and rare movies, the more it becomes a logical problem-solving experience.


## Technologies

- **Programming Language:** Swift
- **Architecture:** MVVM (Model-View-ViewModel)
- **Frameworks:** SwiftUI, Combine, Game Kit
- **APIs:** TheMovieDB API
- **Minimum iOS Version:** iOS 16


## Setup
- **TMDB API Access Token:**  
  To enable fetching movies from the full TMDB catalog, the TMDB API requires an access token. You can obtain an access token by following the instructions [here](https://developer.themoviedb.org/reference/intro/getting-started).  
  Once you have the token, replace the placeholder in the `Info.plist` file with your token under the appropriate key.

  > **Note:** The quiz will still work without an API key because it includes a fallback local movies file for offline or tokenless use.

- **Game Center Leaderboard:**  
  The app uses a shared Game Center leaderboard for experimentation. If you wish to have your own private leaderboard:
  1. Create your own app in App Store Connect with Game Center entitlements.
  2. Create a new leaderboard in App Store Connect.
  3. Replace the `leaderboardID` value in the `Info.plist` file with your new leaderboard ID.

## Popularity Parameters

The **popularity parameters** are defined in the `TMDBMovieQueryHelper` class and include:

- **`minVoteAverage`** 
  - Specifies the minimum average vote a movie must have to be included in the quiz.  
  - Value range: Decimal from `0` to `10`.

- **`minVoteCount`**  
  - Specifies the minimum number of votes a movie must have to be included in the quiz.  
  - Value range: Integer from `0` to infinity.


#### Effect on Quiz and Fetching Time
Increasing these values will result in the quiz containing more popular movies. However, higher values also lengthen the data-fetching process during quiz creation because:
- Movies that do not meet the criteria are filtered out.
- Additional fetches may be required to gather enough movies that satisfy the specified parameters.

## Acknowledgments

This app uses the [TheMovieDB API](https://www.themoviedb.org/documentation/api) to fetch movie data.  

**Disclaimer:** This product is not endorsed or certified by TheMovieDB.
