import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _cityNames = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
    'Dallas',
    'San Jose',
    'Austin',
    'Jacksonville',
    'Fort Worth',
    'Columbus',
    'San Francisco',
    'Charlotte',
    'Indianapolis',
    'Seattle',
    'Denver',
    'Washington'
  ];
  List<String> _filteredCityNames = [];

  @override
  void initState() {
    super.initState();
    _filteredCityNames = _cityNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _filteredCityNames = _cityNames
                  .where((city) =>
                      city.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredCityNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_filteredCityNames[index]),
          );
        },
      ),
    );
  }
}
