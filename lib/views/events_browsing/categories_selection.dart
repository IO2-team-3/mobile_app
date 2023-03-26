import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

class CategoriesSelection extends StatefulWidget {
  final Future<Response<BuiltList<Category>>> categoriesFuture;
  const CategoriesSelection({super.key, required this.categoriesFuture});

  @override
  State<CategoriesSelection> createState() => _CategoriesSelectionState();
}

class _CategoriesSelectionState extends State<CategoriesSelection> {
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
          var CategoriesSelection = snapshot.data!.data!;
          return ListView.builder(
            itemCount: CategoriesSelection.length,
            itemBuilder: (context, index) {
              return Consumer<SearchQueryProvider>(
                builder: (context, categoryProvider, child) {
                  bool isSelected = categoryProvider.categories
                      .contains(CategoriesSelection[index]);
                  return CategoryTile(
                    isSelected: isSelected,
                    category: CategoriesSelection[index],
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
