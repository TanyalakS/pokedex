import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/model/poke_list_results.dart';
import 'package:pokedex/repositories/poke_list_repository.dart';

part 'poke_list_event.dart';
part 'poke_list_state.dart';

class PokeListBloc extends Bloc<PokeListEvent, PokeListState> {
  final PokeListRepository pokeListRepository;
  PokeListBloc({required this.pokeListRepository})
      : super(PokeListInitialState()) {
    on<PokeGetListEvent>(_pokeListGetEvent);
  }

  _pokeListGetEvent(PokeGetListEvent event, Emitter emit) async {
    emit(PokeListLoadingState());
    try {
      dynamic res = await pokeListRepository.getPokeInfo(pokeId: event.id);

      if (res is PokeListResultsModel) {
        emit(PokeListSuccessState(results: res));
        return;
      }
    } catch (e) {
      emit(
        PokeListErrorState(
          error: e.toString(),
        ),
      );
    }
  }
}
