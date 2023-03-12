import 'package:dio/dio.dart';
import 'package:rick_and_morty/home_page/models/character_model.dart';

class GetCharacterRepo {
  final Dio dio;
  CharacterModel model = CharacterModel();
  GetCharacterRepo({required this.dio});

  Future<CharacterModel> getCharacterData({required String name}) async {
    final response = await dio.get('character/?name=$name');
    model.results = [];
    model.fromJson(response.data);
    return model;
  }

  Future<CharacterModel> nextPage({required String path}) async {
    final response = await dio.get(path);
    model.fromJson(response.data);
    return model;
  }
}
