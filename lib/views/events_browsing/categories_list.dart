import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatefulWidget {
  final Future<Response<BuiltList<Category>>> categoriesFuture;
  const CategoriesList({super.key, required this.categoriesFuture});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
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
        future: widget.categoriesFuture,
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

class CategoryTile extends StatelessWidget {
  final bool isSelected;
  final Category category;
  const CategoryTile(
      {super.key, required this.isSelected, required this.category});

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final TextStyle? style = isSelected
        ? TextStyle(
            color: selectedColor,
            fontWeight: FontWeight.bold,
          )
        : null;
    return ListTile(
      title: Text(category.name!, style: style),
      trailing: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(_getColor),
        value: isSelected,
        onChanged: (value) {
          if (!isSelected) {
            Provider.of<SearchQueryProvider>(context, listen: false)
                .addCategory(category);
          } else {
            Provider.of<SearchQueryProvider>(context, listen: false)
                .removeCategory(category);
          }
        },
      ),
    );
  }

  Color _getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Colors.amber;
  }
}
