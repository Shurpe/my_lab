import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContentCard extends StatelessWidget {
  final int id;
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
        // теперь открываем экран деталей
        context.push('/details/$id');
      },
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: imageSize,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imageAsset,
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 4),
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
      ),
    );
  }
}