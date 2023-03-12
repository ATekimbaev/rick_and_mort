import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/home_page/models/character_model.dart';
import 'package:rick_and_morty/home_page/repositories/get_character_repo.dart';

part 'get_character_state.dart';

class GetCharacterCubit extends Cubit<GetCharacterState> {
  GetCharacterCubit({required this.repo}) : super(GetCharacterInitial());

  final GetCharacterRepo repo;

  Future getCharecter(String? name) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final model = await repo.getCharacterData(name: name ?? '');
      emit(GetCharacterSuccess(model: model, startPposition: true));
    } catch (e) {
      emit(GetCharacterError(errorText1: e.toString()));
    }
  }

  Future nextPage(String path) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final model = await repo.nextPage(path: path);
      emit(GetCharacterSuccess(model: model));
    } catch (e) {
      if (e is DioError) {
        emit(GetCharacterError(errorText1: e.toString()));
      }
      emit(GetCharacterError(errorText1: e.toString()));
    }
  }
}
