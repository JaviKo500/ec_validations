import 'package:flutter/material.dart';

import 'package:ec_validations/ec_validations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'EC Validations DNI',
      debugShowCheckedModeBanner: false,
      home: DniValidatorPage(),
    );
  }
}

class DniValidatorPage extends StatefulWidget {
  const DniValidatorPage({super.key});

  @override
  State<DniValidatorPage> createState() => _DniValidatorPageState();
}

class _DniValidatorPageState extends State<DniValidatorPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> identifications = [
    '0195566046',
    '0105566039',
    '0105566046',
    '01A5566046',
    '3212121212',
    '3212121212',
    '2712121212',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'EC DNI Validator',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'DNI',
                              hintText: '0100000000',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              errorMaxLines: 3,
                          ),
                          validator: (value) {
                            final result = DniValidator.isValid(value ?? '');
                            return result.isValid ? null : result.errorMessage;
                          },
                        ),
                        const SizedBox(height: 10),
                        _formKey.currentState?.validate() == true
                        ? const Text(
                          'Valid Dni',
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
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                        )
                      ],
                    )),
                const Text(
                  'Examples',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  itemCount: identifications.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final identification = identifications[index];
                    final result = DniValidator.isValid(identification);
                    return Card(
                      child: ListTile(
                        title: Text(identification),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('isValid: ${result.isValid.toString()}',
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
