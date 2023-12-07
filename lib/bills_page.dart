import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bill_list.dart';
import 'bill.dart';
import 'package:intl/intl.dart';

class BillsPage extends StatefulWidget {
  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  String _selectedType =
      Bill.getPredefinedTypes()[0]; // Initialize with the first type
  final _amountController = TextEditingController();
  bool _isCountingFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Predefined Total: \$${context.watch<BillsList>().predefinedTotal.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedType,
              onChanged: _isCountingFinished
                  ? null
                  : (String? newValue) {
                      setState(() {
                        _selectedType = newValue!;
                      });
                    },
              items: Bill.getPredefinedTypes()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              enabled: !_isCountingFinished,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isCountingFinished
                  ? null
                  : () {
                      final double amount =
                          double.tryParse(_amountController.text) ?? 0.0;

                      context.read<BillsList>().addBill(_selectedType, amount);

                      _amountController.clear();
                    },
              child: Text('Add Bill'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isCountingFinished
                  ? null
                  : () {
                      setState(() {
                        _isCountingFinished = true;
                      });
                    },
              child: Text('Finish Counting'),
            ),
            SizedBox(height: 16.0),
            if (_isCountingFinished) ..._buildBillTypeTotals(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBillTypeTotals(BuildContext context) {
    final billsList = context.watch<BillsList>();
    final totalSum = billsList.getSum();
    final billTypeTotals = billsList.getBillTypeTotals();
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final percentageFormat = NumberFormat.percentPattern();

    return billTypeTotals.entries.map((entry) {
      final billType = entry.key;
      final total = entry.value;
      final percentage = total / totalSum;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          '$billType: ${currencyFormat.format(total)} (${percentageFormat.format(percentage)})',
          style: TextStyle(fontSize: 16.0),
        ),
      );
    }).toList();
  }
}
