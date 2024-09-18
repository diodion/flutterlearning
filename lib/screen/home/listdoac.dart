import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halley/widgets/scaffoldappbar.dart';
import 'package:intl/intl.dart';

class DoacoesScreen extends StatefulWidget {
  const DoacoesScreen({super.key});

  @override
  _DoacoesScreenState createState() => _DoacoesScreenState();
}

class _DoacoesScreenState extends State<DoacoesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _doacoes = [];
  List<Map<String, dynamic>> _filteredDoacoes = [];
  bool _sortAsc = true;
  int _sortColumnIndex = 0;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fetchDoacoes();
  }

  Future<void> _fetchDoacoes() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('doacoes')
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> doacoes = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        doacoes.add(data);
      }

      setState(() {
        _doacoes = doacoes;
        _filteredDoacoes = doacoes;
      });
    } catch (e) {
      _showErrorDialog("Erro para buscar doações. Debug: $e");
    }
  }

  void _search(String query) {
    setState(() {
      _filteredDoacoes = _doacoes.where((doacao) {
        return doacao.entries.any((entry) =>
            entry.value.toString().toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  void _sort<T>(Comparable<T> Function(Map<String, dynamic> doacao) getField) {
    setState(() {
      _filteredDoacoes.sort((a, b) {
        if (!_sortAsc) {
          final temp = a;
          a = b;
          b = temp;
        }
        return Comparable.compare(getField(a), getField(b));
      });
      _sortAsc = !_sortAsc;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(String id) {
    final doacao = _filteredDoacoes.firstWhere((item) => item['id'] == id);
    final TextEditingController skuController =
        TextEditingController(text: doacao['SKU'].toString());
    final TextEditingController nomeController =
        TextEditingController(text: doacao['Nome do item']);
    final TextEditingController precoController =
        TextEditingController(text: doacao['Preço']?.toString() ?? '');
    final TextEditingController pesoController =
        TextEditingController(text: doacao['Peso']?.toString() ?? '');
    final TextEditingController marcaController =
        TextEditingController(text: doacao['Marca']);
    String selectedCategoria = doacao['Categoria'] ?? 'Bebida';

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar doação'),
          content: SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: skuController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'SKU',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome do item',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: precoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Preço',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: selectedCategoria,
                      decoration: InputDecoration(
                        labelText: 'Categoria',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
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
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategoria = newValue!;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: pesoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Peso',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: marcaController,
                      decoration: InputDecoration(
                        labelText: 'Marca',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                try {
                  final DateTime now = DateTime.now();
                  final updatedData = {
                    'SKU': int.parse(skuController.text),
                    'Nome do item': nomeController.text,
                    'Preço': int.tryParse(
                            precoController.text.replaceAll(',', '.')) ??
                        0.0,
                    'Categoria': selectedCategoria,
                    'Peso': int.tryParse(pesoController.text) ?? 0.0,
                    'Marca': marcaController.text,
                    'updatedAt': now,
                    'updatedBy': user?.uid
                  };

                  await _firestore
                      .collection('doacoes')
                      .doc(id)
                      .update(updatedData);

                  setState(() {
                    _fetchDoacoes();
                  });

                  Navigator.of(context).pop();
                } catch (e) {
                  _showErrorDialog("Erro ao atualizar doação. Debug: $e");
                }
              },
              child: const Text('Salvar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _firestore.collection('doacoes').doc(id).delete();

                  setState(() {
                    _fetchDoacoes();
                  });

                  Navigator.of(context).pop();
                } catch (e) {
                  _showErrorDialog("Erro ao deletar doação. Debug: $e");
                }
              },
              child: const Text(
                'Deletar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
      title: 'Halley - Itens doados',
      auth: _auth,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                constraints: const BoxConstraints(maxWidth: 500),
                child: TextFormField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: _search,
                    decoration: const InputDecoration(
                        hintText: 'Search', prefixIcon: Icon(Icons.search))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortAscending: _sortAsc,
                sortColumnIndex: _sortColumnIndex,
                columns: [
                  DataColumn(
                    label: const Text('SKU'),
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                      });
                      _sort((doacao) => doacao['SKU']);
                    },
                  ),
                  DataColumn(
                    label: const Text('Nome do item'),
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                      });
                      _sort((doacao) => doacao['Nome do item']);
                    },
                  ),
                  DataColumn(
                    label: const Text('Preço'),
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                      });
                      _sort((doacao) => doacao['Preço']);
                    },
                  ),
                  DataColumn(
                    label: const Text('Categoria'),
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                      });
                      _sort((doacao) => doacao['Categoria']);
                    },
                  ),
                  DataColumn(
                    label: const Text('Peso'),
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                      });
                      _sort((doacao) => doacao['Peso']);
                    },
                  ),
                  DataColumn(
                    label: const Text('Marca'),
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                      });
                      _sort((doacao) => doacao['Marca']);
                    },
                  ),
                  const DataColumn(
                    label: Text('Ação'),
                  ),
                ],
                rows: _filteredDoacoes.map((doacao) {
                  return DataRow(
                    cells: [
                      DataCell(Text(doacao['SKU']?.toString() ?? '')),
                      DataCell(Text(doacao['Nome do item'] ?? '')),
                      DataCell(Text(
                          _formatAsBRL(doacao['Preço']?.toInt() ?? 0.0))),
                      DataCell(Text(doacao['Categoria'] ?? '')),
                      DataCell(Text(doacao['Peso']?.toString() ?? '')),
                      DataCell(Text(doacao['Marca'] ?? '')),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(doacao['id']);
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAsBRL(int value) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'pt_BR', name: 'BRL');
    return formatCurrency.format(value);
  }
}
