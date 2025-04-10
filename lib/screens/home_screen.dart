import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../widgets/pokemon_card.dart';
import '../screens/pokemon_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Pokemon> _pokemonList = [
    Pokemon(
      dexNumber: 1,
      name: 'Bulbasaur',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      types: ['Grass', 'Poison'],
      description: 'A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.',
      height: 0.7,
      weight: 6.9,
    ),
    Pokemon(
      dexNumber: 4,
      name: 'Charmander',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      types: ['Fire'],
      description: 'From the time it is born, a flame burns at the tip of its tail. Its life would end if the flame were to go out.',
      height: 0.6,
      weight: 8.5,
    ),
    Pokemon(
      dexNumber: 7,
      name: 'Squirtle',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
      types: ['Water'],
      description: 'When it retracts its long neck into its shell, it squirts out water with vigorous force.',
      height: 0.5,
      weight: 9.0,
    ),
  ];

  List<Pokemon> _filteredList = [];
  String _searchQuery = '';
  bool _sortByDexNumber = true;

  @override
  void initState() {
    super.initState();
    _filteredList = List.from(_pokemonList);
    _sortList();
  }

  void _sortList() {
    if (_sortByDexNumber) {
      _filteredList.sort((a, b) => a.dexNumber.compareTo(b.dexNumber));
    } else {
      _filteredList.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  void _filterList(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredList = List.from(_pokemonList);
      } else {
        _filteredList = _pokemonList
            .where((pokemon) =>
                pokemon.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      _sortList();
    });
  }

  void _toggleSort() {
    setState(() {
      _sortByDexNumber = !_sortByDexNumber;
      _sortList();
    });
  }

  void _toggleFavorite(Pokemon pokemon) {
    setState(() {
      final index = _pokemonList.indexWhere((p) => p.dexNumber == pokemon.dexNumber);
      if (index != -1) {
        _pokemonList[index] = pokemon.copyWith(isFavorite: !pokemon.isFavorite);
        _filteredList = List.from(_pokemonList);
        _filterList(_searchQuery);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokédex',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(_sortByDexNumber ? Icons.sort : Icons.sort_by_alpha),
            onPressed: _toggleSort,
            tooltip: _sortByDexNumber ? 'Sort by Name' : 'Sort by Number',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              leading: const Icon(Icons.search),
              hintText: 'Search Pokémon...',
              onChanged: _filterList,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _filteredList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailScreen(
                          pokemon: _filteredList[index],
                          onFavoriteToggle: _toggleFavorite,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'pokemon-${_filteredList[index].dexNumber}',
                    child: PokemonCard(pokemon: _filteredList[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}