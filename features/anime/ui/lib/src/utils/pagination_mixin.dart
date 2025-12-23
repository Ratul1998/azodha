import 'package:flutter/material.dart';

mixin PaginationScrollMixin<T extends StatefulWidget> on State<T> {
  late final ScrollController scrollController;

  void onLoadMore();

  bool get hasMore;

  bool get isPaginating;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!scrollController.hasClients || !hasMore || isPaginating) return;

    final threshold = scrollController.position.maxScrollExtent * 0.8;

    if (scrollController.position.pixels >= threshold) {
      onLoadMore();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
