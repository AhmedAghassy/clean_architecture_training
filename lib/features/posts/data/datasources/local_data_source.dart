import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/post_model.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePost(List<PostModel> posts);
}

const baseKeyLocalPosts = 'CACHED_POSTS';

class LocalDataSourceImpSharedPreferences implements LocalDataSource {
  SharedPreferences sharedPreferences;

  LocalDataSourceImpSharedPreferences({required this.sharedPreferences});

  @override
  Future<List<PostModel>> getCachedPosts() {
    final String? jsonString = sharedPreferences.getString(baseKeyLocalPosts);
    if (jsonString != null) {
      final List<dynamic> jsonStringToListMap = json.decode(jsonString);
      final List<PostModel> listMapToPostsModel = jsonStringToListMap
          .map<PostModel>((jsonMap) => PostModel.fromJson(jsonMap))
          .toList();
      return Future.value(listMapToPostsModel);
    } else {
      throw CacheEmptyException();
    }
  }

  @override
  Future<Unit> cachePost(List<PostModel> posts) async {
    final List<Map<String, dynamic>> postsTojson = posts
        .map<Map<String, dynamic>>((post) => post.toJson())
        .toList();
    final String jsonString = json.encode(postsTojson);
    await sharedPreferences.setString(baseKeyLocalPosts, jsonString);
    return Future.value(unit);
  }
}
