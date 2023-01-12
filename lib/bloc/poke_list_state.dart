part of 'poke_list_bloc.dart';

abstract class PokeListState extends Equatable {
  const PokeListState();

  @override
  List<Object> get props => [];
}

class PokeListInitialState extends PokeListState {}

class PokeListLoadingState extends PokeListState {}

class PokeListErrorState extends PokeListState {
  final String error;

  const PokeListErrorState({required this.error});
}

class PokeListSuccessState extends PokeListState {
  final PokeListResultsModel results;

  const PokeListSuccessState({required this.results});
}
