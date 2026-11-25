import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/config.dart';

/// Loads a backend or external image and shows a useful placeholder on failure.
class RemoteImage extends StatelessWidget {
  const RemoteImage({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.borderRadius = 0,
    this.fallbackIcon = Icons.image_not_supported_outlined,
    super.key,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final imageUri = resolvePortfolioImageUri(url);
    final placeholder = _placeholder(context);
    if (imageUri == null) return placeholder;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUri.toString(),
        width: width,
        height: height,
        fit: fit,
        webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return placeholder;
        },
        errorBuilder: (context, error, stackTrace) => placeholder,
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        fallbackIcon,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
