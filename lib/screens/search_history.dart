import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryScreen extends StatefulWidget {
  @override
  _SearchHistoryScreenState createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends State<SearchHistoryScreen> {
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory = prefs.getStringList('search_history') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search History')),
      body: ListView.builder(
        itemCount: searchHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchHistory[index]),
            onTap: () {
              Navigator.pop(context, searchHistory[index]);
            },
          );
        },
      ),
    );
  }
}
