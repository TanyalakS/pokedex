import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/poke_list_bloc.dart';
import 'package:pokedex/model/poke_list_results.dart';
import 'package:pokedex/repositories/poke_list_repository.dart';
import 'package:pokedex/screen/poke_detail.dart';
import 'package:pokedex/utilities/capitalize.dart';
import 'package:pokedex/utilities/pokeTypeColor.dart';

class PokeGridListCard extends StatefulWidget {
  final int pokeIndex;
  const PokeGridListCard({super.key, required this.pokeIndex});

  @override
  State<PokeGridListCard> createState() => _PokeGridListCardState();
}

class _PokeGridListCardState extends State<PokeGridListCard> {
  final BlocProvider pokeListProvider = BlocProvider<PokeListBloc>(
    create: (BuildContext context) =>
        PokeListBloc(pokeListRepository: PokeListRepository()),
  );
  PokeListBloc? pokeListBlocContext;
  final PokeListRepository pokeListRepository = PokeListRepository();
  PokeListResultsModel? poke;
  Color? cardColor;
  Color? cardColor2;
  bool isTablet = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pokeListBlocContext?.add(
        PokeGetListEvent(id: widget.pokeIndex),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      isTablet = true;
    } else {
      isTablet = false;
    }
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
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).backgroundColor,
              ),
            );
          }
          if (poke == null) {
            return Container();
          }
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    poke?.sprites?.frontDefault ?? "",
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    poke != null ? capitalize(poke!.name!) : "",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokeDetailScreen(
                    pokeIndex: widget.pokeIndex,
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
