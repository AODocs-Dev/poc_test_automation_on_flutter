Feature: App opening
  Default display at app opening

  Scenario: More than 2 movies are listed
    Given The app is closed
    When I open the app
    Then I can see more than 1 movie(s) in the list

  Scenario: 5 tabs are displayed
    Given The app is closed
    When I open the app
    Then The screen contains the tabs "NOW PLAYING, UPCOMMING, POPULAR, TOP RATED, GENRES"