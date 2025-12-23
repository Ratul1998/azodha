import 'package:anime_api/api.dart';
import 'package:anime_ui/src/screen/home_page/cubit/home_cubit.dart';
import 'package:anime_ui/src/screen/home_page/cubit/home_state.dart';
import 'package:anime_ui/src/screen/home_page/widgets/anime_card.dart';
import 'package:anime_ui/src/screen/widgets/shimmer_loading.dart';
import 'package:anime_ui/src/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'featured_anime_banner.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              FeaturedAnimeBanner(
                anime: state.trending.data?.firstOrNull ?? AnimeModel.dummy(),
              ),
              _HomeContent(title: 'Trending Anime', data: state.trending),
              _HomeContent(title: 'Upcoming Anime', data: state.upcoming),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final String title;
  final Data<List<AnimeModel>> data;

  const _HomeContent({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: data.map(
              onLoading: (loading, list) => ShimmerLoading(
                isLoading: loading,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) => AnimeCard.vertical(
                    anime: list?.elementAt(i) ?? AnimeModel.dummy(),
                  ),
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemCount: list?.length ?? 7,
                ),
              ),
              onError: (err, str) => ErrorWidget(err),
              onData: (list) => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) =>
                    AnimeCard.vertical(anime: list.elementAt(i)),
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemCount: list.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
