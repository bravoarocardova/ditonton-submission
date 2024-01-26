import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/tv_list_bloc/tv_list_bloc.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<NowPlayingTvListBloc>(context, listen: false).add(TvListE());
      Provider.of<PopularTvListBloc>(context, listen: false).add(TvListE());
      Provider.of<TopRatedTvListBloc>(context, listen: false).add(TvListE());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'TV Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingTvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvStateHasData) {
                    final result = state.result;
                    return TvList(result);
                  } else if (state is TvStateError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'TV Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvStateHasData) {
                    final result = state.result;
                    return TvList(result);
                  } else if (state is TvStateError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'TV Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvStateHasData) {
                    final result = state.result;
                    return TvList(result);
                  } else if (state is TvStateError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl:
                      '$BASE_IMAGE_URL${tv.posterPath ?? tv.backdropPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
