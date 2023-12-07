import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bill.dart';

class BillsList extends ChangeNotifier {
  double _predefinedTotal = 5000.0;
  List<Bill> _bills = [];

  double get predefinedTotal => _predefinedTotal;

  List<Bill> get bills => _bills;

  void addBill(String type, double amount) {
    final bill = Bill(type, amount);
    _bills.add(bill);
    _updatePredefinedTotal();
    notifyListeners();
  }

  double getSum() {
    return _bills.fold(0.0, (sum, bill) => sum + bill.amount);
  }

  Map<String, double> getBillTypeTotals() {
    final billTypeTotals = <String, double>{};

    for (final bill in _bills) {
      if (billTypeTotals.containsKey(bill.type)) {
        billTypeTotals[bill.type] = billTypeTotals[bill.type]! + bill.amount;
      } else {
        billTypeTotals[bill.type] = bill.amount;
      }
    }

    return billTypeTotals;
  }

  void _updatePredefinedTotal() {
    final sum = getSum();
    _predefinedTotal = (_predefinedTotal - sum);
  }
}
