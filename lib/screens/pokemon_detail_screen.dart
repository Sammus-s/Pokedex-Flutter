import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../widgets/type_chip.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;
  final Function(Pokemon) onFavoriteToggle;

  const PokemonDetailScreen({
    super.key,
    required this.pokemon,
    required this.onFavoriteToggle,
  });

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _getTypeColor(pokemon.types.first),
                      _getTypeColor(pokemon.types.first).withOpacity(0.6),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Hero(
                        tag: 'pokemon-${pokemon.dexNumber}',
                        child: Image.network(
                          pokemon.imageUrl,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: pokemon.isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () => onFavoriteToggle(pokemon),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pokemon.name,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '#${pokemon.dexNumber.toString().padLeft(3, '0')}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: pokemon.types
                        .map((type) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: TypeChip(type: type),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(pokemon.description),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn(
                        context,
                        'Height',
                        '${pokemon.height} m',
                      ),
                      _buildInfoColumn(
                        context,
                        'Weight',
                        '${pokemon.weight} kg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}