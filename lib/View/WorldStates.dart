import 'package:covid_19_app/Model/world_states_model.dart';
import 'package:covid_19_app/Services/state_services.dart';
import 'package:covid_19_app/View/list_of_Countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xffD95AF3),
    const Color(0xffFE9539),
    const Color(0xff145369),
    const Color(0xff96be25),
  ];
  @override
  Widget build(BuildContext context) {
    WorldStateService service = WorldStateService();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .06,
            ),
            FutureBuilder(
              future: service.FetchWorldStateRecord(),
              builder: (context, AsyncSnapshot<WorldState> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      size: 50.0,
                      controller: _controller,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()) *
                                    45,
                            "Active":
                                double.parse(snapshot.data!.active.toString()) *
                                    25,
                          },
                          animationDuration: const Duration(seconds: 2),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          initialAngleInDegree: 90,
                          chartValuesOptions: ChartValuesOptions(
                            chartValueStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            decimalPlaces: 1,
                            showChartValueBackground: true,
                            chartValueBackgroundColor: Colors.grey.shade800,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                          ),
                          legendOptions: const LegendOptions(
                            legendShape: BoxShape.rectangle,
                          ),
                          ringStrokeWidth: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .050,
                            horizontal:
                                MediaQuery.of(context).size.width * .020),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: "Total",
                                  value: snapshot.data!.cases.toString()),
                              ReusableRow(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths.toString()),
                              ReusableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString()),
                              ReusableRow(
                                  title: "Active",
                                  value: snapshot.data!.active.toString()),
                              ReusableRow(
                                  title: "Critical",
                                  value: snapshot.data!.critical.toString()),
                              ReusableRow(
                                  title: "Today Deaths",
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(
                                  title: "Today Recovered",
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CountryListView(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * .020,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff145369),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                "Track Countries",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}
