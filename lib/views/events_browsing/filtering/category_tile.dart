import 'package:flutter/material.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

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
