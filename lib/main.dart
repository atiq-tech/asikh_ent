import 'package:ashik_enterprise/auth/login_screen.dart';
import 'package:ashik_enterprise/hive/hive_adapter.dart';
import 'package:ashik_enterprise/home_page.dart';
import 'package:ashik_enterprise/provider/all_category_provider.dart';
import 'package:ashik_enterprise/provider/all_user_provider.dart';
import 'package:ashik_enterprise/provider/area_provider.dart';
import 'package:ashik_enterprise/provider/current_stock_provider.dart';
import 'package:ashik_enterprise/provider/customer_due_provider.dart';
import 'package:ashik_enterprise/provider/customer_list_provider.dart';
import 'package:ashik_enterprise/provider/employee_provider.dart';
import 'package:ashik_enterprise/provider/get_sales_provider.dart';
import 'package:ashik_enterprise/provider/product_list_provider.dart';
import 'package:ashik_enterprise/provider/sale_details_provider.dart';
import 'package:ashik_enterprise/provider/sales_record_provider.dart';
import 'package:ashik_enterprise/provider/user_data_provider.dart';
import 'package:ashik_enterprise/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await Hive.initFlutter();


  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('product');

  await Hive.openBox('profile');

  // /// Top
  // await Hive.openBox('todaySales');
  // await Hive.openBox('monthlySales');
  // await Hive.openBox('totalDue');
  // await Hive.openBox('cashBalance');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AreaProvider>(create: (_) => AreaProvider()),
        ChangeNotifierProvider<EmployeeProvider>(create: (_) => EmployeeProvider()),
        ChangeNotifierProvider<CustomerListProvider>(create: (_) => CustomerListProvider()),
        ChangeNotifierProvider<CurrentStockProvider>(create: (_) => CurrentStockProvider()),
        ChangeNotifierProvider<AllCategoryProvider>(create: (_) => AllCategoryProvider()),
        ChangeNotifierProvider<AllUserProvider>(create: (_) => AllUserProvider()),
        ChangeNotifierProvider<ProductListProvider>(create: (_) => ProductListProvider()),
        ChangeNotifierProvider<CustomerDueProvider>(create: (_) => CustomerDueProvider()),
        ChangeNotifierProvider<GetSalesProvider>(create: (_) => GetSalesProvider()),
        ChangeNotifierProvider<SalesRecordProvider>(create: (_) => SalesRecordProvider()),
        ChangeNotifierProvider<SaleDetailsProvider>(create: (_) => SaleDetailsProvider()),
        ChangeNotifierProvider<UserDataProvider>(create: (_) => UserDataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ashik Enterprise',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:AnimatedSplashScreen(),
      ),
    );
  }
}

