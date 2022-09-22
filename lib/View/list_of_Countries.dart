import 'package:flutter/material.dart';

class CountryListView extends StatefulWidget {
  const CountryListView({super.key});

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(children: []),
      ),
    );
  }
}