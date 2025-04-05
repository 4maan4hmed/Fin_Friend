import 'package:flutter/material.dart';

import '../widgets/finance/company_tile.dart'; // Update with your correct path

class CompanySelectionPage extends StatefulWidget {
  final Function(List<CompanyData>) onCompaniesSelected;
  const CompanySelectionPage({
    super.key,
    required this.onCompaniesSelected,
  });

  @override
  State<CompanySelectionPage> createState() => _CompanySelectionPageState();
}

class _CompanySelectionPageState extends State<CompanySelectionPage>
    with SingleTickerProviderStateMixin {
  late List<CompanyData> companies;
  late AnimationController _pageAnimationController;
  late Animation<double> _pageAnimation;
  bool _isSelectionComplete = false;

  @override
  void initState() {
    super.initState();

    // Initialize sample companies - replace with your actual company data
    companies = [
      CompanyData(
        id: "tesla",
        name: "Tesla",
        logoPath: "assets/images/tesla_logo.png", // Update with correct path
        description: "Electric vehicles and clean energy",
      ),
      CompanyData(
        id: "apple",
        name: "Apple",
        logoPath: "assets/images/apple_logo.png", // Update with correct path
        description: "Consumer electronics and software",
      ),
      CompanyData(
        id: "google",
        name: "Google",
        logoPath: "assets/images/google_logo.png", // Update with correct path
        description: "Search engine and technology services",
      ),
      CompanyData(
        id: "amazon",
        name: "Amazon",
        logoPath: "assets/images/amazon_logo.png", // Update with correct path
        description: "E-commerce and cloud computing",
      ),
      CompanyData(
        id: "microsoft",
        name: "Microsoft",
        logoPath:
            "assets/images/microsoft_logo.png", // Update with correct path
        description: "Software and computing technology",
      ),
    ];

    // Initialize page animation controller
    _pageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _pageAnimation = CurvedAnimation(
      parent: _pageAnimationController,
      curve: Curves.easeInOut,
    );

    _pageAnimationController.forward();
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    super.dispose();
  }

  void _handleSelectionChanged(CompanyData company) {
    setState(() {
      // Update the selection state
      final index = companies.indexWhere((c) => c.id == company.id);
      if (index >= 0) {
        companies[index].isSelected = company.isSelected;
      }
    });
  }

  void _completeSelection() {
    setState(() {
      _isSelectionComplete = true;
    });

    // Reverse animation to exit
    _pageAnimationController.reverse().then((_) {
      // Get selected companies
      final selectedCompanies = companies.where((c) => c.isSelected).toList();

      // Call the callback with selected companies
      widget.onCompaniesSelected(selectedCompanies);

      // Navigate to next screen or close this one
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Select Companies'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _pageAnimation,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Please select companies you are interested in:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Expanded(
                child: AnimatedList(
                  initialItemCount: companies.length,
                  itemBuilder: (context, index, animation) {
                    // Add staggered animations for list items
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutQuad,
                      )),
                      child: CompanySelectionTile(
                        company: companies[index],
                        onSelectionChanged: _handleSelectionChanged,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: companies.any((c) => c.isSelected)
                        ? _completeSelection
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSelectionComplete
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
