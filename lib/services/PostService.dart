import 'package:dio/dio.dart';
import 'package:favoritos/models/Post.dart';

class PostService {
  
  final String baseUrl = "http://jsonplaceholder.typicode.com/posts";
  final Dio dio = Dio();

  Future<List<Post>> getPost() async {

    try {
      Response response = await dio.get(baseUrl);

      List list = response.data as List;

      List<Post> postList = list.map<Post>((post) => Post.fromJson(post)).toList();
      return postList;

    } catch (e) {
      throw Exception();
    }

  }
}