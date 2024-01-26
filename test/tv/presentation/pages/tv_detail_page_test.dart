import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class TvDetailStateFake extends Fake implements TvDetailState {}

void main() {
  late MockTvDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockTvDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Detail Tv Page should display Progressbar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      TvDetailState.initial().copyWith(
        tvDetailState: RequestState.Loading,
      ),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvDetailState.initial().copyWith(
      tvDetailState: RequestState.Loaded,
      tvDetail: testTvDetail,
      tvRecommendationState: RequestState.Loaded,
      tvRecommendations: testTvList,
      isAddedToWatchlist: false,
    ));
    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvDetailState.initial().copyWith(
      tvDetailState: RequestState.Loaded,
      tvDetail: testTvDetail,
      tvRecommendationState: RequestState.Loaded,
      tvRecommendations: testTvList,
      isAddedToWatchlist: true,
    ));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
