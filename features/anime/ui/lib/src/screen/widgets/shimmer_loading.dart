import 'package:flutter/cupertino.dart';

class SlidingGradientTransform extends GradientTransform {
  const SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  LinearGradient get shimmerGradient => LinearGradient(
    colors: const [
      Color(0xFF555555),
      Color(0xFF777777),
      Color(0xFF999999),
      Color(0xFF777777),
      Color(0xFF666666),
    ],
    stops: const [0.1, 0.3, 0.5, 0.7, 0.8],
    begin: const Alignment(-1.0, -0.3),
    end: const Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
    transform: SlidingGradientTransform(slidePercent: _shimmerController.value),
  );

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));

    _shimmerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant ShimmerLoading oldWidget) {
    if (oldWidget.isLoading != widget.isLoading) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return shimmerGradient.createShader(bounds);
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }
}
