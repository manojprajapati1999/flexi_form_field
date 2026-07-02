
import 'image_loader/image_loader_platform.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium full-screen image slider widget.
///
/// [FlexiImageSlider] provides a high-quality carousel experience for viewing 
/// multiple images with smooth transitions and interactive dot indicators.
class FlexiImageSlider extends StatefulWidget {
  /// List of image sources (URLs or local file paths).
  final List<String> images;

  /// Whether the images are remote URLs (true) or local files (false).
  final bool isLive;

  /// The initial page to display (default: 0).
  final int initialPage;

  /// Whether the carousel should auto-play.
  final bool autoPlay;

  /// Optional theme override.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiImageSlider] widget.
  const FlexiImageSlider({
    super.key,
    required this.images,
    this.isLive = true,
    this.initialPage = 0,
    this.autoPlay = false,
    this.theme,
  });

  /// Displays the image slider in a full-screen dialog.
  static Future<void> show(
    BuildContext context, {
    required List<String> images,
    bool isLive = true,
    int initialPage = 0,
    FlexiFormTheme? theme,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => FlexiImageSlider(
          images: images,
          isLive: isLive,
          initialPage: initialPage,
          theme: theme,
        ),
      ),
    );
  }

  @override
  State<FlexiImageSlider> createState() => _FlexiImageSliderState();
}

class _FlexiImageSliderState extends State<FlexiImageSlider> {
  late int _currentIndex;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    final appliedFlexiTheme = widget.theme ?? const FlexiFormTheme();
    final primaryColor = appliedFlexiTheme.primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Filter out empty strings
    final validImages = widget.images.where((img) => img.trim().isNotEmpty).toList();

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "${_currentIndex + 1} / ${validImages.length}",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                initialPage: widget.initialPage,
                autoPlay: widget.autoPlay,
                enlargeCenterPage: true,
                viewportFraction: 0.92,
                aspectRatio: 1.0,
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
              items: validImages.map((image) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: widget.isLive
                        ? Image.network(
                            image,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: progress.expectedTotalBytes != null
                                      ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                                      : null,
                                  color: primaryColor,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.white10,
                              child: const Icon(Icons.broken_image, color: Colors.white38, size: 64),
                            ),
                          )
                        : getFileImageWidget(image, fit: BoxFit.contain),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: validImages.asMap().entries.map((entry) {
                final isSelected = _currentIndex == entry.key;
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isSelected ? 24.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isSelected ? primaryColor : Colors.white24,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
