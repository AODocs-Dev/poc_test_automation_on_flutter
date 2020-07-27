import 'dart:async';

import 'package:cine_reel/api/tmdb_api.dart';
import 'package:cine_reel/bloc/bloc_provider.dart';
import 'package:cine_reel/ui/search_screen/search_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchMoviesBloc extends BlocBase {
  final Sink<String> onTextChanged;
  final Stream<SearchState> state;
  static TMDBApi tmdbApi;

  factory SearchMoviesBloc(TMDBApi api) {
    final onTextChanged = PublishSubject<String>();
    final state = onTextChanged
        // If the text has not changed, do not perform a new search
        .distinct()
        // Wait for the user to stop typing for 250ms before running a search
        .debounce(const Duration(milliseconds: 250))
        // Call the TMDB api with the given search term and convert it to a
        // State. If another search term is entered, switchMap will ensure
        // the previous search is discarded so we don't deliver stale results
        // to the View.
        .switchMap<SearchState>((String query) => _search(query, api))
        // The initial state to deliver to the screen.
        .startWith(SearchNoTerm());

    return SearchMoviesBloc._(onTextChanged, state);
  }

  SearchMoviesBloc._(this.onTextChanged, this.state);

  static Stream<SearchState> _search(String query, TMDBApi api) async* {
    if (query.isEmpty) {
      yield SearchNoTerm();
    } else {
      yield SearchLoading();
      try {
        final result = await api.searchMovie(title: query);

        if (result.isEmpty) {
          yield SearchEmpty();
        } else {
          yield SearchPopulated(movies: result.results);
        }
      } catch (e) {
        yield SearchError();
      }
    }
  }

  @override
  void dispose() {
    onTextChanged.close();
  }
}
