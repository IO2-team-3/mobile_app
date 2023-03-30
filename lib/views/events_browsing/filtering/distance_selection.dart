import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/providers/location_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class DistanceSelection extends StatefulWidget {
  const DistanceSelection({super.key});

  @override
  State<DistanceSelection> createState() => _DistanceSelectionState();
}

class _DistanceSelectionState extends State<DistanceSelection> {
  final _addressLineEditingController = TextEditingController();
  final _distanceEditingConroller = TextEditingController();

  bool _isAddressCorrect = false;
  bool _isTranslatingAddress = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _addressLineEditingController.dispose();
    _distanceEditingConroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<SearchQueryProvider>().resetLocationQuery();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Consumer<LocationProvider>(
            builder: (context, value, child) {
              return TextButton(
                onPressed: () async {
                  List<Location> locationsFromAddress = [];
                  setState(() {
                    _isTranslatingAddress = true;
                  });
                  try {
                    locationsFromAddress = await value.getLocationsFromAddress(
                        _addressLineEditingController.text);
                  } on NoResultFoundException {
                    // handle later
                  } on Exception {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Connection error!'),
                      ),
                    );
                  }
                  setState(() {
                    _isTranslatingAddress = false;
                    _isAddressCorrect = locationsFromAddress.isNotEmpty;
                  });
                  if (_formKey.currentState!.validate() && context.mounted) {
                    context.read<SearchQueryProvider>().setDistance(
                        double.parse(_distanceEditingConroller.text));
                    context
                        .read<SearchQueryProvider>()
                        .setCurrentLocation(locationsFromAddress[0]);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('APPLY'),
              );
            },
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
                controller: _addressLineEditingController,
                enabled: !_isTranslatingAddress,
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
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(_distanceEditingConroller.text) == null ||
                      double.tryParse(_distanceEditingConroller.text)! <= 0) {
                    return 'Please enter a correct value';
                  }
                  return null;
                },
                controller: _distanceEditingConroller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
