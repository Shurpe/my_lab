import 'package:dio/dio.dart';
import 'package:flutter_application_1/domain/repositories/content/model/content.dart';
import 'content_repository_interface.dart';

class ContentRepository implements ContentRepositoryInterface {
  ContentRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Content>> getContent() async {
    try {
      // Получаем список постов (JSON массив)
      final Response response = await dio.get('/posts');
      final dataList = (response.data as List).cast<Map<String, dynamic>>();
      // Преобразуем в Content
      return dataList.map((e) {
        return Content(
          id: e['id'] as int,
          title: e['title'] as String,
          author: e['userId'].toString(),
          description: e['body'] as String,
          image: 'assets/test_image.jpg', // локальная заглушка
        );
      }).toList();
    } on DioException catch (e) {
      throw Exception('Ошибка сети: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка парсинга: $e');
    }
  }
}
