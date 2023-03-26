import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/views/events_browsing/distance_selection.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'categories_list.dart';

class SearchView extends StatefulWidget {
  final Future<Response<BuiltList<Category>>> categoriesFuture;
  const SearchView({super.key, required this.categoriesFuture});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late String query;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    query = Provider.of<SearchQueryProvider>(context, listen: false).eventName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find event'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<SearchQueryProvider>(context, listen: false)
                .resetSearchQuery();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: textEditingController,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: query == '' ? 'Event name' : query,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_drop_down),
                  label: _getCategoriesText(),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Center(
                          child: CategoriesList(
                            categoriesFuture: widget.categoriesFuture,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 20),
                OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_drop_down),
                  label: _getLocationText(),
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
          ),
          Expanded(
            child: Center(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.manage_search),
                label: Text('Search for "$query"\n& apply filters'),
                onPressed: () {
                  Provider.of<SearchQueryProvider>(context, listen: false)
                      .setEventName(query);
                  //Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed('/events_page/filtered');
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Text _getCategoriesText() {
    var selectedCategories =
        Provider.of<SearchQueryProvider>(context).categories;
    if (selectedCategories.isEmpty) {
      return const Text('Categories');
    } else if (selectedCategories.length == 1) {
      return Text(selectedCategories[0].name!);
    }
    int notShownCount = selectedCategories.length - 1;
    return Text('${selectedCategories[0].name!} +$notShownCount');
  }

  Text _getLocationText() {
    var selectedDistance = Provider.of<SearchQueryProvider>(context).distance;
    if (selectedDistance == null) {
      return const Text('Search radius');
    }
    return Text("in < $selectedDistance km");
  }
}
