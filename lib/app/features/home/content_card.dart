// lib/app/features/home/content_card.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/app/extensions/extensions.dart';

class ContentCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageAsset;

  const ContentCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    const imageSize = 100.0;

    return InkWell(
      onTap: () {
        // Если появится маршрут /content/:id — раскомментируй ниже:
        // context.push('/content/$id');
      },
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: imageSize,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageAsset,
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => SizedBox(
                  height: imageSize,
                  width: imageSize,
                  child: Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).withPaddingAll(0),
    );
  }
}
