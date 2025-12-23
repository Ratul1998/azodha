import 'package:anime_api/api.dart';
import 'package:anime_ui/src/screen/detail_page/cubit/anime_detail_cubit.dart';
import 'package:anime_ui/src/screen/detail_page/cubit/anime_detail_state.dart';
import 'package:anime_ui/src/screen/home_page/widgets/anime_card.dart';
import 'package:anime_ui/src/screen/widgets/shimmer_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, BlocBuilder, ReadContext;
import 'package:get_it/get_it.dart';

class AnimeDetailScreen extends StatelessWidget {
  final int id;

  const AnimeDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final di = GetIt.instance;

    return BlocProvider(
      create: (_) => di.get<DetailCubit>(param1: id)..load(),
      child: const _AnimeDetailView(),
    );
  }
}

class _AnimeDetailView extends StatelessWidget {
  const _AnimeDetailView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailCubit>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          color: Colors.white,
          icon: Icon(Icons.arrow_left),
        ),
      ),
      body: BlocBuilder<DetailCubit, AnimeDetailState>(
        builder: (context, state) => switch (state) {
          AnimeDetailsLoading _ => const Center(
            child: CircularProgressIndicator(),
          ),
          AnimeDetailErrorState _ => Center(child: Text(state.id.toString())),
          AnimeDetailsLoaded _ => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailHeader(anime: state.detail),
                _SynopsisSection(synopsis: state.detail.synopsis),
                _TrendingSection(items: cubit.getTrendingAnime()),
              ],
            ),
          ),
          _ => const SizedBox(),
        },
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  final AnimeDetailModel anime;

  const _DetailHeader({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: anime.imageUrl,
          filterQuality: FilterQuality.low,
          height: 360,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          height: 360,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withValues(alpha: 0.2), Colors.black],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailPoster(imageUrl: anime.imageUrl),
              const SizedBox(width: 12),
              Expanded(child: _DetailInfo(anime: anime)),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailPoster extends StatelessWidget {
  final String imageUrl;

  const _DetailPoster({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        height: 160,
        width: 110,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _SynopsisSection extends StatelessWidget {
  final String synopsis;

  const _SynopsisSection({required this.synopsis});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Anime Synopsis',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(synopsis, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _DetailInfo extends StatelessWidget {
  final AnimeDetailModel anime;

  const _DetailInfo({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          anime.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'year: ${anime.year}\nAnime Rating ${anime.score}',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(
          '[${anime.genres.join(', ')}]',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(anime.studio, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 12),
        _TrailerButton(url: anime.trailerUrl),
      ],
    );
  }
}

class _TrailerButton extends StatelessWidget {
  final String? url;

  const _TrailerButton({this.url});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: url == null ? null : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      child: const Text('Play Trailer'),
    );
  }
}

class _TrendingSection extends StatelessWidget {
  final Future<List<AnimeModel>> items;

  const _TrendingSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending Anime',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: FutureBuilder(
              future: items,
              builder: (context, snapshot) {
                final trendingList = snapshot.data ?? [];

                return ShimmerLoading(
                  isLoading: !snapshot.hasData,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) =>
                        AnimeCard.vertical(anime: trendingList[i]),
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemCount: trendingList.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
