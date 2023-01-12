part of 'poke_list_bloc.dart';

abstract class PokeListEvent extends Equatable {
  const PokeListEvent();

  @override
  List<Object> get props => [];
}

class PokeGetListEvent extends PokeListEvent {
  final int id;
  const PokeGetListEvent({required this.id});
}
