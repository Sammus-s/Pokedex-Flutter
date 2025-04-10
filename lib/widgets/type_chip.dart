import 'package:flutter/material.dart';

class TypeChip extends StatelessWidget {
  final String type;

  const TypeChip({
    super.key,
    required this.type,
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: _getTypeColor(type),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}