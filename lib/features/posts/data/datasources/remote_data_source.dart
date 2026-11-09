import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel post);
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostModel post);
}

const baseUrlRemotePosts = 'jsonplaceholder.typicode.com';
const baseHeadersRemotePosts = {'Content-Type': 'application/json'};

class RemoteDataSourceImpHTTP implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpHTTP({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final http.Response response = await client.get(
      Uri.https(baseUrlRemotePosts, '/posts/'),
      headers: baseHeadersRemotePosts,
    );
    if (response.statusCode == 200) {
      final String jsonString = response.body;
      final List<dynamic> jsonStringDecode = json.decode(jsonString);
      final List<PostModel> jsonToPostModel = jsonStringDecode
          .map((json) => PostModel.fromJson(json))
          .toList();
      return jsonToPostModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final Map<String, dynamic> body = {'title': post.title, 'body': post.body};
    final http.Response response = await client.post(
      Uri.https(baseUrlRemotePosts, '/posts/'),
      headers: baseHeadersRemotePosts,
      body: json.encode(body),
    );
    if (response.statusCode == 201) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final http.Response response = await client.delete(
      Uri.https(baseUrlRemotePosts, '/posts/${id.toString()}'),
      headers: baseHeadersRemotePosts,
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final Map<String, dynamic> body = {'title': post.title, 'body': post.body};
    final http.Response response = await client.put(
      Uri.https(baseUrlRemotePosts, '/posts/${post.id.toString()}'),
      headers: baseHeadersRemotePosts,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
