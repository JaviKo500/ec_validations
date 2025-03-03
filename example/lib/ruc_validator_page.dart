import 'package:flutter/material.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/ec_validations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'EC Validations RUC',
      debugShowCheckedModeBanner: false,
      home: RucValidatorPage(),
    );
  }
}

class RucValidatorPage extends StatefulWidget {
  const RucValidatorPage({super.key});

  @override
  State<RucValidatorPage> createState() => _RucValidatorPageState();
}

class _RucValidatorPageState extends State<RucValidatorPage> {
  final _formKey = GlobalKey<FormState>();

  TypeIdentification typeIdentification = TypeIdentification.ruc;

  final List<String> identifications = [
    '0105566046000',
    '3095566046001',
    '95566046001',
    '0105566039001',
    '0105566046001',
  ];

  final List<String> identificationsPrivate = [
    '1790011674001',
    '09A2256230001',
    '3092256230001',
    '0992256230000',
    '0982256230001',
    '0992256230001',
    '1790450635001',
    '0992256234001',
    '1790450637001',
  ];

  final List<String> identificationsPublic = [
    '1760004650001',
    '1760001120001',
    '1760001120000',
    '1770001120001',
    '3060001120001',
    '17600011200',
    '1760004680001',
    '1760001110001',
  ];

  final List<String> listRuc = [
    '0105566046001',
    '1760004650001',
    '0992256230001',
    '0105566001',
    '1760004611001',
    '0992256223001',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> listRucTest = [...listRuc];
    return Scaffold(
        appBar: AppBar(
          title: const Text('EC RUC Validator', style: TextStyle(color: Colors.white),),
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
                    DropdownButtonFormField<TypeIdentification>(
                      decoration: InputDecoration(
                        labelText: 'Identification type',
                        hintText: 'Identification type',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        )
                      ),
                      value: typeIdentification,
                      items: TypeIdentification.values.where( (item) => item != TypeIdentification.dni ).map( (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.toString()),
                      )).toList(),
                      onChanged: (value) {
                        if ( value != null ) {
                            setState(() {
                              typeIdentification = value;
                              switch (typeIdentification) {
                                case TypeIdentification.rucPersonNatural:
                                  listRucTest = identifications;
                                  break;
                                case TypeIdentification.rucSocietyPrivate:
                                  listRucTest = identificationsPrivate;
                                  break;
                                case TypeIdentification.rucPublicSociety:
                                  listRucTest = identificationsPublic;
                                  break;
                                default:
                                  listRucTest = listRuc;
                              }
                            });
                        }
                      },
                    ),
                    const SizedBox(height: 6,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'RUC',
                        hintText: '0100000000001',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        errorMaxLines: 3,
                      ),
                      validator: (value) {
                        if( typeIdentification != TypeIdentification.ruc ) {
                          final result = RucValidator.validateRucByType(value ?? '', typeIdentification);
                          return result.isValid ? null : result.errorMessage;
                        } else {
                          final result = RucValidator.validateRuc(value ?? '');
                          return result.isValid ? null : result.errorMessage;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    _formKey.currentState?.validate() == true
                        ? const Text(
                          'Valid RUC',
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
                itemCount: listRucTest.length,
                itemBuilder: (context, index) {
                  final identification = listRucTest[index];
                  IdentificationResult result;
                  if ( typeIdentification != TypeIdentification.ruc ) {
                    result = RucValidator.validateRucByType(identification, typeIdentification);
                  } else {
                    result = RucValidator.validateRuc(identification);
                  }
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
