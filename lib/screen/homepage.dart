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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Text(
            'Pokédex',
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
            ),
          ),
          onTap: (){
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => SplashScreen(),
            //     ),
            //   );
          },
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
              Expanded(
                child: GridView.builder(
                  itemCount: 151,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    int id = index + 1;
                    return PokeGridListCard(
                      pokeId: id,
                    );
                  },
                ),
              ),
            ],
            if (onTapb2) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: 151,
                  itemBuilder: (context, index) {
                    int id = index + 1;
                    return Column(
                      children: [
                        PokeListCard(
                          pokeId: id,
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
