import 'package:flutter/material.dart';

class FavoriKalp extends StatefulWidget {
  final bool isFavorited;
  final Function(bool isFavorited) onFavoriteChanged;

  FavoriKalp({required this.isFavorited, required this.onFavoriteChanged});

  @override
  _FavoriKalpState createState() => _FavoriKalpState();
}

class _FavoriKalpState extends State<FavoriKalp> {
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _isFavorited = widget.isFavorited;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorited ? Icons.favorite : Icons.favorite_border,
        color: _isFavorited ? Colors.red : null,
      ),
      onPressed: () {
        setState(() {
          _isFavorited = !_isFavorited;
          widget.onFavoriteChanged(_isFavorited);
        });
      },
    );
  }
}
