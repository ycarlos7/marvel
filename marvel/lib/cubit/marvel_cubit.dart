import 'package:bloc/bloc.dart';
import 'package:marvel/cubit/marvel_state.dart';

import '../model/marvel_model.dart';
import '../repository/marvel_repository.dart';

class MarvelCubit extends Cubit<MarvelState> {
  final MarvelRepository marvelRepository;
  MarvelCubit(this.marvelRepository) : super(MarvelInitial());

  Future<void> getMarvel() async {
    try {
      emit(MarvelLoading());
      MarvelModel _marvelModel = await marvelRepository.getAll();
      emit(MarvelLoaded(marvelModel: _marvelModel));
    } catch (e) {
      emit(MarvelError(e.toString()));
    }
  }
}
