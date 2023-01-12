import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/poke_list_bloc.dart';
import 'package:pokedex/model/poke_list_results.dart';
import 'package:pokedex/repositories/poke_list_repository.dart';
import 'package:pokedex/screen/poke_detail.dart';
import 'package:pokedex/utilities/capitalize.dart';
import 'package:pokedex/utilities/pokeTypeColor.dart';

class PokeListCard extends StatefulWidget {
  final int pokeId;
  const PokeListCard({super.key, required this.pokeId});

  @override
  State<PokeListCard> createState() => _PokeListCardState();
}

class _PokeListCardState extends State<PokeListCard> {
  final BlocProvider pokeListProvider = BlocProvider<PokeListBloc>(
    create: (BuildContext context) =>
        PokeListBloc(pokeListRepository: PokeListRepository()),
  );
  PokeListBloc? pokeListBlocContext;
  final PokeListRepository pokeListRepository = PokeListRepository();
  PokeListResultsModel? poke;
  Color? cardColor;
  Color? cardColor2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pokeListBlocContext?.add(
        PokeGetListEvent(id: widget.pokeId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        pokeListProvider,
      ],
      child: BlocBuilder<PokeListBloc, PokeListState>(
        buildWhen: (previous, current) {
          if (current is PokeListLoadingState) {
            return true;
          }
          if (current is PokeListErrorState) {
            return true;
          }
          if (current is PokeListSuccessState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          pokeListBlocContext = context.read<PokeListBloc>();
          if (state is PokeListSuccessState) {
            poke = state.results;

            cardColor = typeColor(
              type: poke?.types?[0].type?.name ?? "",
            );

            cardColor2 = typeColor(
              type: poke!.types!.length > 1
                  ? poke!.types![1].type!.name!
                  : poke!.types![0].type!.name!,
            );
          }
          if (state is PokeListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (poke == null) {
            return Container();
          }
          return InkWell(
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.grey,
                //   width: 0.7,
                // ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    cardColor!.withOpacity(0.7),
                    cardColor2!.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          poke != null ? capitalize(poke!.name!) : "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          poke != null
                              ? "#${poke!.order.toString().padLeft(3, '0')}"
                              : "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Image.network(
                      poke?.sprites?.frontDefault ?? "",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokeDetailScreen(
                    pokeId: widget.pokeId,
                    color1: cardColor!,
                    color2: cardColor2!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
