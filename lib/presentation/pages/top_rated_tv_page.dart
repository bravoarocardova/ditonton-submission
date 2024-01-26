import 'package:ditonton/presentation/bloc/top_rated_tv_bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvBloc>(context, listen: false).add(TopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvHasData) {
              final result = state.result;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return TvCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is TopRatedTvError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container(
                key: Key('error_message'),
              );
            }
          },
        ),
      ),
    );
  }
}
