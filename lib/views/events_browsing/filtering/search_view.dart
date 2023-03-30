import 'package:flutter/material.dart';
import 'package:mobile_app/providers/location_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/views/events_browsing/filtering/distance_selection.dart';
import 'package:provider/provider.dart';

import 'categories_selection.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _queryEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _queryEditingController.text =
        Provider.of<SearchQueryProvider>(context, listen: false).eventName;
    _queryEditingController.addListener(_getSearchButtonText);
    _queryEditingController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _queryEditingController.dispose();
    super.dispose();
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
              controller: _queryEditingController,
              decoration: InputDecoration(
                hintText: 'Event name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
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
                          builder: (context) => const CategoriesSelection(),
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
                          builder: (context) =>
                              ChangeNotifierProvider<LocationProvider>(
                            create: (context) => LocationProvider(),
                            child: const DistanceSelection(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.manage_search),
                label: _getSearchButtonText(),
                onPressed: () {
                  Provider.of<SearchQueryProvider>(context, listen: false)
                      .setEventName(_queryEditingController.text);
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
    var selectedDistance =
        Provider.of<SearchQueryProvider>(context).distanceInKm;
    if (selectedDistance == null) {
      return const Text('Search radius');
    }
    return Text("< $selectedDistance km");
  }

  Text _getSearchButtonText() {
    return Text(
        'Search for "${_queryEditingController.text}"\n& apply filters');
  }
}
