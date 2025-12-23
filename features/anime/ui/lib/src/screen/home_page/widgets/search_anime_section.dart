import 'dart:async';

import 'package:anime_api/api.dart';
import 'package:anime_ui/src/screen/home_page/cubit/home_cubit.dart';
import 'package:anime_ui/src/screen/home_page/cubit/home_state.dart';
import 'package:anime_ui/src/screen/home_page/widgets/anime_card.dart';
import 'package:anime_ui/src/screen/widgets/shimmer_loading.dart';
import 'package:anime_ui/src/utils/pagination_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAnimeSection extends StatefulWidget {
  const SearchAnimeSection({super.key});

  @override
  State<SearchAnimeSection> createState() => _SearchAnimeSectionState();
}

class _SearchAnimeSectionState extends State<SearchAnimeSection>
    with PaginationScrollMixin {
  final TextEditingController _controller = TextEditingController();

  Timer? _debounce;

  late final HomeCubit cubit;

  @override
  void initState() {
    cubit = context.read();
    cubit.onSearchAnime();
    super.initState();
  }

  @override
  void onLoadMore() => cubit.onSearchAnime(
    query: _controller.text,
    pageNumber: (cubit.state.searchResults.data?.pageNumber ?? 0) + 1,
  );

  void _debounceSearch(String query) {
    _debounce?.cancel();
    _debounce = Timer(
      Duration(milliseconds: 400),
      () => cubit.onSearchAnime(query: _controller.text, pageNumber: 1),
    );
  }

  @override
  bool get hasMore => cubit.state.hasMoreSearchResult;

  @override
  bool get isPaginating => cubit.state.searchResults.loading;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        _SearchField(controller: _controller, onChanged: _debounceSearch),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final page = state.searchResults;
              final list = page.data?.searchResult ?? [];
              return ShimmerLoading(
                isLoading: page.isLoading && list.isEmpty,
                child: _SearchList(
                  controller: scrollController,
                  items: list,
                  isLoadingMore:
                      isPaginating &&
                      (state.searchResults.data?.pageNumber ?? 1) > 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}

class _SearchList extends StatelessWidget {
  final ScrollController controller;
  final List<AnimeModel> items;
  final bool isLoadingMore;

  const _SearchList({
    required this.controller,
    required this.items,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .9,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return const Center(child: CircularProgressIndicator());
        }

        return AnimeCard.vertical(anime: items[index]);
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search Anime',
          filled: true,
          fillColor: Colors.grey[900],
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
