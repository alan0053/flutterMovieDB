import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movieprovider.dart';
import '../data/movie.dart';

class SearchDialog extends StatefulWidget {
  final BuildContext parentContext;
  //home page context
  final void Function(Future<List<Movie>> future, String keyword) onSearch;
  //callback after search
  const SearchDialog({
    super.key,
    required this.parentContext,
    required this.onSearch,
  });

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    // dialog's context
    return AlertDialog(
      title: const Text('Search Movie'),
      content: TextField(
        controller: searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'E.g. Batman',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              searchController.clear();
            },
            child: Text('Cancel',
                style:
                    textTheme.bodyMedium?.copyWith(color: colorTheme.error))),
        TextButton(
          onPressed: () {
            final keyword = searchController.text.trim();
            if (keyword.isNotEmpty) {
              final future = Provider.of<MovieProvider>(widget.parentContext,
                      listen: false)
                  .search(keyword);
              widget.onSearch(future,
                  keyword); // passing the future and keyword to homepage
            }
            searchController.clear();
            Navigator.of(context).pop();
          },
          child: Text('Search',
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
        ),
      ],
    );
  }
}
