import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/poke_list_bloc.dart';
import 'package:pokedex/model/poke_list_results.dart';
import 'package:pokedex/repositories/poke_list_repository.dart';
import 'package:pokedex/utilities/capitalize.dart';
import 'package:pokedex/utilities/pokeTypeColor.dart';

class PokeDetailScreen extends StatefulWidget {
  final int pokeIndex;
  final Color color1;
  final Color color2;
  const PokeDetailScreen(
      {super.key,
      required this.pokeIndex,
      required this.color1,
      required this.color2});

  @override
  State<PokeDetailScreen> createState() => _PokeDetailScreenState();
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  final BlocProvider pokeListProvider = BlocProvider<PokeListBloc>(
    create: (BuildContext context) =>
        PokeListBloc(pokeListRepository: PokeListRepository()),
  );
  PokeListBloc? pokeListBlocContext;
  final PokeListRepository pokeListRepository = PokeListRepository();
  PokeListResultsModel? poke;
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

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.color1.withOpacity(0.7),
            widget.color2.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: isTablet
              ? const Radius.circular(400)
              : const Radius.circular(200),
          bottomRight: isTablet
              ? const Radius.circular(400)
              : const Radius.circular(200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: isTablet
                ? const EdgeInsets.fromLTRB(60, 16, 24, 16)
                : const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalize(poke?.name ?? ""),
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    poke != null
                        ? "#${poke!.order.toString().padLeft(3, '0')}"
                        : "",
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: isTablet
                ? const EdgeInsets.only(bottom: 40, right: 100)
                : const EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.network(
                poke?.sprites?.frontDefault ?? "",
                fit: BoxFit.cover,
                height: isTablet ? 400 : 250,
                width: isTablet ? 400 : 250,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyDetail() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          SizedBox(
            height: isTablet ? 16 : 0,
          ),
          SizedBox(
            height: isTablet ? 80 : 60,
            width: poke!.types!.length > 1
                ? isTablet
                    ? 340
                    : 270
                : isTablet
                    ? 150
                    : 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: poke?.types?.length,
              itemBuilder: (context, index) {
                Color colour =
                    typeColor(type: poke?.types?[index].type?.name ?? "");
                return Row(
                  children: [
                    Container(
                      height: isTablet ? 60 : 40,
                      width: isTablet ? 150 : 130,
                      color: colour,
                      child: Center(
                        child: Text(
                          poke != null
                              ? poke!.types![index].type!.name!.toUpperCase()
                              : "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 14 : 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isTablet ? 32 : 16,
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: isTablet ? 32 : 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Order:",
                style: TextStyle(
                  fontSize: isTablet ? 18 : 12,
                ),
              ),
              SizedBox(
                width: isTablet ? 32 : 24,
              ),
              Text(
                poke != null ? poke!.order!.toString() : "",
                style: TextStyle(
                  fontSize: isTablet ? 18 : 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: isTablet ? 24 : 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Height:",
                style: TextStyle(
                  fontSize: isTablet ? 18 : 12,
                ),
              ),
              SizedBox(
                width: isTablet ? 32 : 24,
              ),
              Text(
                poke != null ? poke!.height!.toString() : "",
                style: TextStyle(
                  fontSize: isTablet ? 18 : 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: isTablet ? 24 : 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Weight:",
                style: TextStyle(
                  fontSize: isTablet ? 18 : 12,
                ),
              ),
              SizedBox(
                width: isTablet ? 32 : 24,
              ),
              Text(
                poke != null ? poke!.weight!.toString() : "",
                style: TextStyle(
                  fontSize: isTablet ? 18 : 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  header(),
                  bodyDetail(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
