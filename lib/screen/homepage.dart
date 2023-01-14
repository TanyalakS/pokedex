import 'package:flutter/material.dart';
import 'package:pokedex/screen/poke_grid_list.dart';
import 'package:pokedex/screen/poke_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onTapb1 = true;
  bool onTapb2 = false;
  bool isTablet = false;

  Widget gridCard() {
    return Expanded(
      child: GridView.builder(
        itemCount: 300,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 4 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          int pokeIndex = index + 1;
          return PokeGridListCard(
            pokeIndex: pokeIndex,
          );
        },
      ),
    );
  }

  Widget listCard() {
    return Expanded(
      child: ListView.builder(
        itemCount: 151,
        itemBuilder: (context, index) {
          int pokeIndex = index + 1;
          return Column(
            children: [
              PokeListCard(
                pokeIndex: pokeIndex,
              ),
              const SizedBox(
                height: 16,
              )
            ],
          );
        },
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokémon',
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                onTapb1 = true;
                onTapb2 = false;
              });
            },
            icon: onTapb1
                ? Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.grid_view_rounded),
                  )
                : const Icon(Icons.grid_view_outlined),
            color: Theme.of(context).backgroundColor,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                onTapb2 = true;
                onTapb1 = false;
              });
            },
            icon: onTapb2
                ? Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.view_list_rounded),
                  )
                : const Icon(Icons.view_list_outlined),
            color: Theme.of(context).backgroundColor,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onTapb1) ...[
              gridCard(),
            ],
            if (onTapb2) ...[
              listCard(),
            ],
          ],
        ),
      ),
    );
  }
}
