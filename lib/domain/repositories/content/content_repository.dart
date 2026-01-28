import 'package:dio/dio.dart';
import 'package:flutter_application_1/domain/repositories/content/model/content.dart';
import 'content_repository_interface.dart';

class ContentRepository implements ContentRepositoryInterface {
  ContentRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Content>> getContent() async {
    try {
      // Пытаемся получить данные из сети
      final Response response = await dio.get('/posts');

      final dataList = (response.data as List)
          .cast<Map<String, dynamic>>();

      return dataList.map((e) {
        return Content(
          id: e['id'] as int,
          title: e['title'] as String,
          author: e['userId'].toString(),
          description: e['body'] as String,
          image: 'assets/test_image.jpg',
        );
      }).toList();
    } catch (_) {
      // ⬇️ Фолбэк: мок-данные (для стабильной работы)
      return _mockContent();
    }
  }

  List<Content> _mockContent() {
    return List.generate(
      5,
      (i) => Content(
        id: i + 1,
        title: 'Заголовок ${i + 1}',
        author: 'Автор ${i + 1}',
        description: 'Описание элемента ${i + 1}',
        image: 'assets/test_image.jpg',
      ),
    );
  }
}
