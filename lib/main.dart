import 'package:fintech_app/providers/finance_data_provider.dart';
import 'package:fintech_app/screens/finance_home_screen.dart';
import 'package:fintech_app/screens/select_company_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinanceDataProvider(),
      child: MaterialApp(
        title: 'FinFriend',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CompanySelectionPage(
          onCompaniesSelected: (selectedCompanies) {
            // Get the provider without listening to changes
            final provider = Provider.of<FinanceDataProvider>(
              context, 
              listen: false
            );
            
            // Update the provider with selected companies
            provider.setSelectedCompanies(selectedCompanies);
            
            // Navigate to the home screen after selection
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const FinanceHomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}