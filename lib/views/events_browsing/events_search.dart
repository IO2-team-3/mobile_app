import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/views/events_browsing/categories_selection.dart';
import 'package:mobile_app/views/events_browsing/distance_selection.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';
import 'package:provider/provider.dart';

class EventsSearch extends SearchDelegate {
  Future<Response<BuiltList<Category>>> categoriesFuture;
  Category? userSelection;

  EventsSearch(this.categoriesFuture);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OutlinedButton.icon(
            icon: const Icon(Icons.arrow_drop_down),
            label: const Text('Categories'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Center(
                    child:
                        CategoriesSelection(categoriesFuture: categoriesFuture),
                  ),
                ),
              );
            },
          ),
          OutlinedButton.icon(
            icon: const Icon(Icons.arrow_drop_down),
            label: const Text('Location'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DistanceSelection(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return FutureBuilder<Response<BuiltList<Category>>>(
    //     future: categoriesFuture,
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       var CategoriesSelection = snapshot.data!.data!;
    //       List<Category> suggestions =
    //           CategoriesSelection.asList().where((searchResult) {
    //         final result = searchResult.name!.toLowerCase();
    //         final input = query.toLowerCase();

    //         return result.contains(input);
    //       }).toList();
    //       return ListView.builder(
    //         itemCount: suggestions.length,
    //         itemBuilder: (_, index) {
    //           final suggestion = suggestions[index];
    //           return ListTile(
    //             title: Text(suggestion.name!),
    //             onTap: () {
    //               query = suggestion.name!;
    //               close(context, suggestion);
    //             },
    //           );
    //         },
    //       );
    //     });

    if (query.isEmpty) {
      return const Center(child: Text('No search history available'));
    }
    return Center(
      child: OutlinedButton.icon(
        onPressed: () => close(context, query),
        icon: const Icon(Icons.manage_search),
        label: Text('Search for "$query"'),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
