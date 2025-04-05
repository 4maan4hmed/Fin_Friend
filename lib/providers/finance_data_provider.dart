import 'package:fintech_app/widgets/finance/company_tile.dart';
import 'package:flutter/material.dart';

import '../models/news_item.dart';
import '../models/stock_item.dart';

class FinanceDataProvider with ChangeNotifier {
  String _username = "Amaan";
  double _totalChange = -13.2;

  // Add this line to define the _selectedCompanies property
  List<CompanyData> _selectedCompanies = [];

  List<StockItem> _stocks = [
    StockItem(
      symbol: 'NFLX',
      name: 'Netflix, Inc',
      price: 688.91,
      percentageChange: -1.29,
      graphPoints: [10, 12, 11, 13, 14, 15, 16, 9, 6, 14, 18],
    ),
    StockItem(
      symbol: 'NFLX',
      name: 'Netflix, Inc',
      price: 688.91,
      percentageChange: -1.29,
      graphPoints: [10, 12, 11, 13, 14, 15, 16, 9, 6, 14, 18],
    ),
    StockItem(
      symbol: 'APPL',
      name: 'Apple, Inc',
      price: 688.91,
      percentageChange: 1.29,
      graphPoints: [10, 12, 11, 13, 14, 15, 16, 9, 6, 14, 18],
    ),
    // ... other stocks
  ];

  NewsItem _featuredNews = NewsItem(
    title: "US names India, China as 'state-actors' in fentanyl trafficking...",
    imageUrl: "assets/images/news_image.jpg",
    url: "https://example.com/news/1",
  );

  String get username => _username;
  double get totalChange => _totalChange;
  List<StockItem> get stocks => _stocks;
  NewsItem get featuredNews => _featuredNews;

  // Add a getter for selectedCompanies
  List<CompanyData> get selectedCompanies => _selectedCompanies;

  void updateUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void updateTotalChange(double change) {
    _totalChange = change;
    notifyListeners();
  }

  void updateStocks(List<StockItem> stocks) {
    _stocks = stocks;
    notifyListeners();
  }

  void updateFeaturedNews(NewsItem news) {
    _featuredNews = news;
    notifyListeners();
  }

  void setSelectedCompanies(List<CompanyData> companies) {
    _selectedCompanies = companies;
    notifyListeners();
  }
}
