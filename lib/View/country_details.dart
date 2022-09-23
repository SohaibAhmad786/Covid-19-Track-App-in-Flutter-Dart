import 'package:covid_19_app/View/WorldStates.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoutryDetail extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths, active, critical, todayRecovered, test;
  CoutryDetail({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<CoutryDetail> createState() => _CoutryDetailState();
}

class _CoutryDetailState extends State<CoutryDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        ReusableRow(
                            title: "Cases",
                            value: widget.totalCases.toString()),
                        ReusableRow(
                            title: "Deths",
                            value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: "Critical",
                            value: widget.critical.toString()),
                        ReusableRow(
                            title: "Today's Recovered",
                            value: widget.todayRecovered.toString()),
                        ReusableRow(
                            title: "Active ", value: widget.active.toString()),
                        ReusableRow(
                            title: "Test", value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
