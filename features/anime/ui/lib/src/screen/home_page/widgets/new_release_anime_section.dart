import 'package:anime_api/api.dart';
import 'package:anime_ui/src/screen/home_page/cubit/home_cubit.dart';
import 'package:anime_ui/src/screen/home_page/cubit/home_state.dart';
import 'package:anime_ui/src/screen/home_page/widgets/anime_card.dart';
import 'package:anime_ui/src/screen/widgets/shimmer_loading.dart';
import 'package:anime_ui/src/utils/pagination_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewReleasesSection extends StatefulWidget {
  const NewReleasesSection({super.key});

  @override
  State<NewReleasesSection> createState() => _NewReleasesSectionState();
}

class _NewReleasesSectionState extends State<NewReleasesSection>
    with PaginationScrollMixin {
  late final HomeCubit cubit;

  @override
  void initState() {
    cubit = context.read();
    cubit.onLoadNewReleases(1);
    super.initState();
  }

  @override
  void onLoadMore() => cubit.onLoadNewReleases(
    (cubit.state.newReleases.data?.pageNumber ?? 0) + 1,
  );

  @override
  bool get hasMore => cubit.state.hasMoreNewReleases;

  @override
  bool get isPaginating => cubit.state.newReleases.loading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(16.0),
          height: kMinInteractiveDimension,
          child: Text(
            'New Releases',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final list = state.newReleases.data?.searchResult ?? [];
              return ShimmerLoading(
                isLoading: isPaginating && list.isEmpty,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount:
                      list.length + (isPaginating && list.isEmpty ? 7 : 0),
                  itemBuilder: (_, i) {
                    final item = list.elementAtOrNull(i);

                    return AnimeCard.horizontal(
                      anime: item ?? AnimeModel.dummy(),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
