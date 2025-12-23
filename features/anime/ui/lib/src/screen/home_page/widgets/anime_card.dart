import 'package:anime_api/api.dart';
import 'package:anime_ui/src/screen/detail_page/anime_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final AnimeModel anime;
  final bool isHorizontal;

  const AnimeCard.vertical({super.key, required this.anime})
    : isHorizontal = false;

  const AnimeCard.horizontal({super.key, required this.anime})
    : isHorizontal = true;

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? _AnimeCardHorizontal(anime: anime)
        : _AnimeCardVertical(anime: anime);
  }
}

class _AnimeCardVertical extends StatelessWidget {
  final AnimeModel anime;

  const _AnimeCardVertical({required this.anime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AnimeDetailScreen(id: anime.id),
        ),
      ),
      child: SizedBox(
        width: 130,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _AnimePoster(
              imageUrl: anime.imageUrl,
              height: 180,
              width: double.maxFinite,
            ),
            const SizedBox(height: 6),
            _AnimeTitle(title: anime.title),
            _AnimeScore(score: anime.score, type: anime.type),
          ],
        ),
      ),
    );
  }
}

class _AnimeCardHorizontal extends StatelessWidget {
  final AnimeModel anime;

  const _AnimeCardHorizontal({required this.anime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AnimeDetailScreen(id: anime.id),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 96,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            _AnimePoster(imageUrl: anime.imageUrl, height: 120, width: 85),
            const SizedBox(width: 12),
            Expanded(child: _AnimeDetails(anime: anime)),
          ],
        ),
      ),
    );
  }
}

class _AnimePoster extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double? width;

  const _AnimePoster({
    required this.imageUrl,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        filterQuality: FilterQuality.low,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _AnimeTitle extends StatelessWidget {
  final String title;
  final int maxLines;

  const _AnimeTitle({required this.title, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _AnimeDetails extends StatelessWidget {
  final AnimeModel anime;

  const _AnimeDetails({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AnimeTitle(title: anime.title, maxLines: 2),
        if (anime.subtitle != null) ...[
          const SizedBox(height: 4),
          _AnimeSubtitle(subtitle: anime.subtitle!),
        ],
        if (anime.description != null) ...[
          const SizedBox(height: 6),
          _AnimeDescription(description: anime.description!),
        ],
        const Spacer(),
        _AnimeScore(score: anime.score, type: anime.type),
      ],
    );
  }
}

class _AnimeSubtitle extends StatelessWidget {
  final String subtitle;

  const _AnimeSubtitle({required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}

class _AnimeDescription extends StatelessWidget {
  final String description;

  const _AnimeDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}

class _AnimeScore extends StatelessWidget {
  final double score;
  final String type;

  const _AnimeScore({required this.score, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, size: 14, color: Colors.red),
        const SizedBox(width: 4),
        Text(score.toString(), style: const TextStyle(color: Colors.white)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            type,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
