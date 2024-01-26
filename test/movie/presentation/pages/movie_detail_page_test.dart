import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movies_detail_bloc/movies_detail_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockMoviesDetailBloc
    extends MockBloc<MoviesDetailEvent, MoviesDetailState>
    implements MoviesDetailBloc {}

class MoviesDetailEventFake extends Fake implements MoviesDetailEvent {}

class MoviesDetailStateFake extends Fake implements MoviesDetailState {}

void main() {
  late MockMoviesDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockMoviesDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MoviesDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Detail Movie Page should display Progressbar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      MoviesDetailState.initial().copyWith(
        movieDetailState: RequestState.Loading,
      ),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MoviesDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      movieRecommendationState: RequestState.Loaded,
      movieRecommendations: testMovieList,
      isAddedToWatchlist: false,
    ));
    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MoviesDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      movieRecommendationState: RequestState.Loaded,
      movieRecommendations: testMovieList,
      isAddedToWatchlist: true,
    ));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
