// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'utils/WaitUtils.dart';
import 'utils/AdbUtils.dart';

void main() {
  group('Movie app', () {
    final appBar = find.byValueKey('app_bar');
    final tabBar = find.byValueKey('tab_bar');
    final searchButton = find.byValueKey('search_button');
    final infoButton = find.byValueKey('info_button');
    final movieList = find.byValueKey('movies_list_view');
    final movieList2 = find.byValueKey('movies_list_view2');
    final movieId1 = find.byValueKey('movie_501907');
    final movieId2 = find.byValueKey('movie_475430');
    final movieId3 = find.text("movie_475430");
    final movieId4 = find.text("movie_419704"); // Ad Astra
    final tabNowPlaying = find.text("NOW PLAYING");
    final tabUpcoming = find.text("UPCOMING");
    final tabTopRated = find.text("TOP RATED");
    final tabPopular = find.text("POPULAR");
    final tabGenres = find.text("GENRES");
    final tabSearchMovies = find.text("MOVIES");
    final tabSearchPeople = find.text("PEOPLE");
    final castList = find.byValueKey("cast_list");
    final actorsListView = find.byValueKey("actors_list_view");
    final movieDetailsView = find.byValueKey("movie_details_view");
    final donald = find.byValueKey("Donald Sutherland");
    final donaldPicture = find.byValueKey("actor_image_Donald Sutherland");
    final searchField = find.byValueKey("search_field Sutherland");
    final starTrekMovie = find.text("Star Trek");
    final imdbIcon = find.byValueKey("assets/imdb_icon.png");

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('smoke tests', () async {
      await driver.runUnsynchronized(() async {
        sleep(const Duration(seconds: 2));

        print('App bar');
        expect(await WaitUtils().isPresent(appBar, driver), true);
        expect(await WaitUtils().isPresent(searchButton, driver), true);
        expect(await WaitUtils().isPresent(infoButton, driver), true);

        print('Tab bar');
        expect(await WaitUtils().isPresent(tabBar, driver), true);
        expect(await WaitUtils().isPresent(tabNowPlaying, driver), true);
        expect(await WaitUtils().isPresent(tabUpcoming, driver), true);
        expect(await WaitUtils().isPresent(tabTopRated, driver), true);
        expect(await WaitUtils().isPresent(tabPopular, driver), true);
        expect(await WaitUtils().isPresent(tabGenres, driver), true);

        print('Search tab bar');
        expect(await WaitUtils().isPresent(tabSearchMovies, driver), false);
        expect(await WaitUtils().isPresent(tabSearchPeople, driver), false);

        print('List of movies');
        expect(await WaitUtils().isPresent(movieList, driver), true);
        expect(await WaitUtils().isPresent(movieList2, driver), true);

        print('Movies');
        expect(await WaitUtils().isPresent(movieId1, driver), false);
        expect(await WaitUtils().isPresent(movieId2, driver), true);
        expect(await WaitUtils().isPresent(movieId3, driver), true);
      });
    });

    test('scroll on list of movies', () async {
      await driver.runUnsynchronized(() async {
        await driver.waitFor(movieList, timeout: Duration(seconds: 1));

        await driver.scrollUntilVisible(
          movieList2,
          movieId1,
          dyScroll: -500,
        );

        print(await driver.getText(movieId1));

        expect(await driver.getText(movieId1), "movie_501907");
      });
    });

    test('scroll on list of actors', () async {
      await driver.runUnsynchronized(() async {

        await driver.tap(tabUpcoming);
        sleep(Duration(seconds: 2));

        await driver.tap(tabPopular);
        sleep(Duration(seconds: 2));

        await driver.tap(movieId4);
        sleep(Duration(seconds: 3));

        // swipe down to list of actors
        await driver.scrollUntilVisible(
          movieDetailsView,
          castList,
          dyScroll: -300,
        );

        // swipe right to Donald Sutherland
        await driver.scrollUntilVisible(
          castList,
          donald,
          dxScroll: -200,
        );

        // Tap Donald Sutherland
        await driver.tap(donaldPicture);
        sleep(Duration(seconds: 3));

        // Back
        await AdbUtils().pressBack();

        // Back
        await AdbUtils().pressBack();
      });
    });

    test('Search for a movie', () async {
      await driver.runUnsynchronized(() async {

        await driver.tap(searchButton);
        sleep(Duration(seconds: 1));

        //await driver.tap(searchField);
        //sleep(Duration(seconds: 1));
        await driver.enterText('Star Tr');
        sleep(Duration(seconds: 1));

        await driver.tap(starTrekMovie);
        sleep(Duration(seconds: 1));

        driver.scroll(movieDetailsView, 0, -200, Duration(seconds: 1));

        await driver.tap(imdbIcon);
        sleep(Duration(seconds: 5));
      });
    });
  });
}
