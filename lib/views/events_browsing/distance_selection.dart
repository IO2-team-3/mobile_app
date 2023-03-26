import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class DistanceSelection extends StatefulWidget {
  const DistanceSelection({super.key});

  @override
  State<DistanceSelection> createState() => _DistanceSelectionState();
}

class _DistanceSelectionState extends State<DistanceSelection> {
  //TextEditingController addressController = TextEditingController();
  String? _addressLine;
  Location? _location;
  bool _isAddressCorrect = false;
  // bool _isTranslatingAddress = false;
  double? _distance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<SearchQueryProvider>(context, listen: false)
                .resetLocationQuery();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              bool isAddressCorrect = await _getLocationFromAddress();
              setState(() {
                _isAddressCorrect = isAddressCorrect;
              });
              if (_formKey.currentState!.validate() && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Filters applied!'),
                  ),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  // TODO for testing purposes
                  Provider.of<SearchQueryProvider>(context, listen: false)
                      .setDistance(
                          _distance!); // TODO _CastError (Null check operator used on a null value)
                  Provider.of<SearchQueryProvider>(context, listen: false)
                      .setCurrentLocation(_location!);
                  Navigator.of(context).pop();
                });
              }
            },
            child: const Text('APPLY'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                //controller: addressController,
                onChanged: (value) => setState(() {
                  _addressLine = value;
                }),
                decoration: const InputDecoration(
                  hintText: 'e.g. 1600 Amphiteatre Parkway, Mountain View',
                  border: UnderlineInputBorder(),
                  label: Text('Your address'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }

                  if (!_isAddressCorrect) {
                    _isAddressCorrect = true;
                    return 'Please re-enter the address in correct format';
                  }

                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'e.g. 25',
                  suffixText: 'km',
                  label: Text('Search radius'),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _distance = double.parse(value);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _getLocationFromAddress() async {
    if (_addressLine == null) {
      return false;
    }
    List<Location> locations = await locationFromAddress(_addressLine!);
    if (locations.isEmpty) {
      return false;
    }

    _location = locations[0];
    return true;
  }
}
