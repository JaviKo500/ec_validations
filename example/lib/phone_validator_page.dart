import 'package:flutter/material.dart';

import 'package:ec_validations/ec_validations.dart';

void main() => runApp(const MyApp());

/// Validation mode chosen in the form.
enum PhoneMode { any, local, international }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'EC Validations Phone',
      debugShowCheckedModeBanner: false,
      home: PhoneValidatorPage(),
    );
  }
}

class PhoneValidatorPage extends StatefulWidget {
  const PhoneValidatorPage({super.key});

  @override
  State<PhoneValidatorPage> createState() => _PhoneValidatorPageState();
}

class _PhoneValidatorPageState extends State<PhoneValidatorPage> {
  final _formKey = GlobalKey<FormState>();

  PhoneMode phoneMode = PhoneMode.any;

  final List<String> phonesAny = [
    '0991234567',
    '099 123 4567',
    '+593991234567',
    '593991234567',
    '+593 (0)99 123 4567',
    '0891234567',
    '+1991234567',
    '09912345',
  ];

  final List<String> phonesLocal = [
    '0991234567',
    '099 123 4567',
    '(099) 123-4567',
    '0891234567',
    '09912345',
    '+593991234567',
  ];

  final List<String> phonesInternational = [
    '+593991234567',
    '00593991234567',
    '593991234567',
    '+593 (0)99 123 4567',
    '+593891234567',
    '+1991234567',
    '0991234567',
  ];

  /// Validates using the method that matches the selected mode.
  PhoneResult validate(String phoneNumber) {
    switch (phoneMode) {
      case PhoneMode.local:
        return PhoneValidator.isValidLocal(phoneNumber);
      case PhoneMode.international:
        return PhoneValidator.isValidInternational(phoneNumber);
      case PhoneMode.any:
        return PhoneValidator.isValid(phoneNumber);
    }
  }

  /// Sample numbers shown for the selected mode.
  List<String> get phonesTest {
    switch (phoneMode) {
      case PhoneMode.local:
        return phonesLocal;
      case PhoneMode.international:
        return phonesInternational;
      case PhoneMode.any:
        return phonesAny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('EC Phone Validator', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form',
                  style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    const SizedBox(height: 6,),
                    DropdownButtonFormField<PhoneMode>(
                      decoration: InputDecoration(
                        labelText: 'Phone format',
                        hintText: 'Phone format',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        )
                      ),
                      initialValue: phoneMode,
                      items: PhoneMode.values.map( (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.toString()),
                      )).toList(),
                      onChanged: (value) {
                        if ( value != null ) {
                          setState(() {
                            phoneMode = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 6,),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: '0991234567',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        errorMaxLines: 3,
                      ),
                      validator: (value) {
                        final result = validate(value ?? '');
                        return result.isValid ? null : result.errorMessage;
                      },
                    ),
                    const SizedBox(height: 10),
                    _formKey.currentState?.validate() == true
                        ? const Text(
                          'Valid phone',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          )
                        )
                        : const SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.validate();
                        setState(() {});
                      },
                      child: const Text('Validate'),
                    ),
                    TextButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      child: const Text('Reset', style: TextStyle(color: Colors.purple,),),
                    )
                  ],
                )),
                const Text(
                  'Examples',
                  style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: phonesTest.length,
                  itemBuilder: (context, index) {
                    final phoneNumber = phonesTest[index];
                    final result = validate(phoneNumber);
                    return Card(
                      child: ListTile(
                        title: Text(phoneNumber),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('isValid: ${result.isValid.toString()}',
                                style: const TextStyle()),
                            Text('Normalized: ${result.normalizedNumber ?? ''}',
                                style: const TextStyle()),
                            Text(
                                'Error code: ${result.typeCodeError?.toString() ?? ''}',
                                style: const TextStyle()),
                            Text('Error message: ${result.errorMessage ?? ''}',
                                style: const TextStyle()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
