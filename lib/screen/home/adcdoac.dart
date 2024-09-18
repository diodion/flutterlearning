import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halley/widgets/button.dart';
import 'package:halley/widgets/scaffoldappbar.dart';

class AddDoac extends StatefulWidget {
  const AddDoac({super.key});

  @override
  _AddDoacState createState() => _AddDoacState();
}

class _AddDoacState extends State<AddDoac> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _skuController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _weightController = TextEditingController();
  final _brandController = TextEditingController();
  final _focusNodeSku = FocusNode();
  final _focusNodeName = FocusNode();
  final _focusNodePrice = FocusNode();
  final _focusNodeWeight = FocusNode();
  final _focusNodeBrand = FocusNode();
  String _selectedCategory = 'Bebida';

  @override
  void dispose() {
    _skuController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _weightController.dispose();
    _brandController.dispose();
    _focusNodeSku.dispose();
    _focusNodeName.dispose();
    _focusNodePrice.dispose();
    _focusNodeWeight.dispose();
    _focusNodeBrand.dispose();
    super.dispose();
  }

  Future<void> _addItem() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          final DateTime now = DateTime.now();
          await _firestore.collection('doacoes').add({
            'SKU': _skuController.text,
            'Nome do item': _nameController.text,
            'Preço': _priceController.text.isNotEmpty
                ? int.tryParse(_priceController.text)
                : null,
            'Categoria': _selectedCategory,
            'Peso': int.tryParse(_weightController.text),
            'Marca': _brandController.text,
            'createdAt': now,
            'updatedAt': now,
            'createdBy': user.uid,
          });

          if (!mounted) return;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sucesso'),
                content: const Text('Doação catalogada com sucesso!'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          _skuController.clear();
          _nameController.clear();
          _priceController.clear();
          _weightController.clear();
          _brandController.clear();
        } catch (e) {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro ao catalogar doação'),
                content: Text('Erro para debug: ${e.toString()}'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro de permissão'),
              content: const Text('Usuário não autenticado'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
        title: 'Halley - Adicionar itens doados',
        auth: _auth,
        body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                              controller: _skuController,
                              focusNode: _focusNodeSku,
                              decoration: const InputDecoration(
                                  hintText: 'SKU',
                                  prefixIcon: Icon(Icons.barcode_reader))),
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: _nameController,
                              focusNode: _focusNodeName,
                              decoration: const InputDecoration(
                                  hintText: 'Nome do item',
                                  prefixIcon: Icon(Icons.label))),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                              value: _selectedCategory,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Bebida', child: Text('Bebida')),
                                DropdownMenuItem(
                                    value: 'Alimento perecível',
                                    child: Text('Alimento perecível')),
                                DropdownMenuItem(
                                    value: 'Alimento não-perecível',
                                    child: Text('Alimento não-perecível')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value!;
                                });
                              },
                              borderRadius: BorderRadius.circular(3),
                              decoration: InputDecoration(
                                  hintText: 'Categoria',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.category),
                                  prefixIconColor:
                                      WidgetStateColor.resolveWith((states) {
                                    if (states.contains(WidgetState.focused)) {
                                      return Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.grey.shade100
                                          : Colors.grey.shade100;
                                    }
                                    return Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.grey.shade900
                                        : Colors.grey.shade100;
                                  }))),
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: _priceController,
                              focusNode: _focusNodePrice,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Preço',
                                prefixIcon: Icon(Icons.attach_money),
                              )),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _weightController,
                            focusNode: _focusNodeWeight,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Peso',
                              prefixIcon: Icon(Icons.balance),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: _brandController,
                              focusNode: _focusNodeBrand,
                              decoration: const InputDecoration(
                                hintText: 'Marca',
                                prefixIcon: Icon(Icons.branding_watermark),
                              )),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: 40,
                              width: 500,
                              child: ButtonHalley(
                                  text: 'Adicionar', onPressed: _addItem))
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
