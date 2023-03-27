import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/categories_cache_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/views/events_browsing/filtering/category_tile.dart';

class CategoriesSelection extends StatefulWidget {
  const CategoriesSelection({super.key});

  @override
  State<CategoriesSelection> createState() => _CategoriesSelectionState();
}

class _CategoriesSelectionState extends State<CategoriesSelection> {
  late Future<Response<BuiltList<Category>>> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories =
        context.read<CategoriesCacheProvider>().getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<SearchQueryProvider>(context, listen: false)
                .removeAllCategories();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('APPLY'),
          )
        ],
      ),
      body: FutureBuilder<Response<BuiltList<Category>>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var categoriesList = snapshot.data!.data!;
          return ListView.builder(
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              return Consumer<SearchQueryProvider>(
                builder: (context, categoryProvider, child) {
                  bool isSelected = categoryProvider.categories
                      .contains(categoriesList[index]);
                  return CategoryTile(
                    isSelected: isSelected,
                    category: categoriesList[index],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
