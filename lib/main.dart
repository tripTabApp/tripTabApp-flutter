import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bill_list.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

//WidgetsFlutterBinding.ensureInitialized();
//await DatabaseConnection.connect();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BillsList(),
      child: MaterialApp(
        title: 'Bills App',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: LoginPage(),
      ),
    );
  }
}
