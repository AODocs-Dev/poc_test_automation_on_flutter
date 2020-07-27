import 'package:cine_reel/bloc/bloc_provider.dart';
import 'package:flutter/material.dart';

enum TabKey {
  kNowPlaying,
  kUpcoming,
  kTopRated,
  kPopular,
  kGenres,
  kSearchMovies,
  kSearchPeople
}

const Map<TabKey, String> tabs = {
  TabKey.kNowPlaying: "NOW PLAYING",
  TabKey.kUpcoming: "UPCOMING",
  TabKey.kTopRated: "TOP RATED",
  TabKey.kPopular: "POPULAR",
  TabKey.kGenres: "GENRES",
  TabKey.kSearchMovies: "MOVIES",
  TabKey.kSearchPeople: "PEOPLE"
};

class TabObject {
  Tab tab;
  BlocProvider provider;

  TabObject(TabKey tabKey, BlocProvider blocProvider) {
    tab = Tab(
      text: tabs[tabKey],
      key: Key(tabKey.toString()),
    );
    provider = blocProvider;
  }
}
