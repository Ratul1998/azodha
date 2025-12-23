import 'package:anime_api/api.dart';

abstract class AnimeDetailState {
  final int id;
  const AnimeDetailState(this.id);
}

class AnimeDetailsLoading extends AnimeDetailState {
  AnimeDetailsLoading(super.id);
}

class AnimeDetailsLoaded extends AnimeDetailState {
  final AnimeDetailModel detail;

  AnimeDetailsLoaded(super.id, {required this.detail});
}

class AnimeDetailErrorState extends AnimeDetailState {
  final Object error;
  final StackTrace? trace;

  AnimeDetailErrorState(super.id, {required this.error, this.trace});
}
