import 'package:flutter/material.dart';
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
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .06,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PieChart(
                dataMap: const {
                  "Total": 50,
                  "Recovered": 30,
                  "Deaths": 20,
                },
                animationDuration: const Duration(milliseconds: 1200),
                chartType: ChartType.ring,
                colorList: colorList,
                initialAngleInDegree: 90,
                legendOptions: const LegendOptions(
                  legendShape: BoxShape.rectangle,
                ),
                ringStrokeWidth: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .050,
                  horizontal: MediaQuery.of(context).size.width * .020),
              child: Card(
                child: Column(
                  children: [
                    ReusableRow(title: "Total", value: "20000"),
                    ReusableRow(title: "Total", value: "20000"),
                    ReusableRow(title: "Total", value: "20000"),
                    ReusableRow(title: "Total", value: "20000"),
                    ReusableRow(title: "Total", value: "20000"),
                    ReusableRow(title: "Total", value: "20000"),
                    ReusableRow(title: "Total", value: "20000"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * .020,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * .06,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colorList),
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
          const Divider(
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
