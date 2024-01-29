import 'dart:io';

import 'package:expensive_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    // ignore: no_logic_in_create_state
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  // String _txtTitleValue = '';
  // String _txtAmountValue = '';
  final _txtTitleFieldControll = TextEditingController();
  final _txtAmountFieldControll = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.outros;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // TODO: MODE 1
    // showDatePicker(
    //   context: context,
    //   initialDate: now,
    //   firstDate: firstDate,
    //   lastDate: now,
    // ).then((value) {
    //   setState(() {
    //     _selectedDate = value;
    //   });
    // });
    // TODO: MODE 2
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate!;
    });
  }

  void _showDialog() {
    //TODO: CHECA A PLATAFORMA COM O PLATFORM DO PACOTE DART:IO E EXISTE O KISWEB QUE CHECA SE ESTA
    // SENDO EXECUTADO NA WEB
    
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Campos inválidos'),
                content: const Text(
                    'Verifique se os campos DESPESA, VALOR, DATA e CATEGORIA foram preenchidos corretamente!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Center(
                      child: Text('Entendi'),
                    ),
                  )
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Campos inválidos'),
                content: const Text(
                    'Verifique se os campos DESPESA, VALOR, DATA e CATEGORIA foram preenchidos corretamente!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Center(
                      child: Text('Entendi'),
                    ),
                  )
                ],
              ));
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
      _txtAmountFieldControll.text.replaceFirst(',', '.'),
    );
    final amountIsInvalid =
        enteredAmount == null || enteredAmount <= 0 || enteredAmount.isNaN;

    if (_txtTitleFieldControll.text.trim().isEmpty || amountIsInvalid) {
      _showDialog();
      return;
    }
    widget.onAddExpense(Expense(
      title: _txtTitleFieldControll.text,
      amount: enteredAmount,
      date: _selectedDate,
      category: _selectedCategory,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _txtTitleFieldControll.dispose();
    _txtAmountFieldControll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 19, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (constraints.maxWidth >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            // onChanged: (value) {
                            //   _txtTitleValue = value;
                            // },
                            controller: _txtTitleFieldControll,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Despesa'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: TextField(
                            // onChanged: (value) {
                            //   _txtAmountValue = value;
                            // },
                            controller: _txtAmountFieldControll,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Valor'),
                              prefixText: 'R\$ ',
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      // onChanged: (value) {
                      //   _txtTitleValue = value;
                      // },
                      controller: _txtTitleFieldControll,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Despesa'),
                      ),
                    ),
                  if (constraints.maxWidth <= 600)
                    TextField(
                      // onChanged: (value) {
                      //   _txtAmountValue = value;
                      // },
                      controller: _txtAmountFieldControll,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Valor'),
                        prefixText: 'R\$ ',
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values.map((vl) {
                          return DropdownMenuItem(
                            alignment: Alignment.center,
                            value: vl,
                            child: Text(
                              vl.name.toUpperCase(),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(formatter.format(_selectedDate)),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.cancel_outlined,
                            color: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.save_outlined),
                          onPressed: _submitExpenseData,
                          label: const Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
