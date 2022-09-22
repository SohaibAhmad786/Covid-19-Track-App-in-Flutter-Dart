import 'package:covid_19_app/Model/countries_list_model.dart';
import 'package:covid_19_app/Services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListView extends StatefulWidget {
  const CountryListView({super.key});

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

TextEditingController searchController = TextEditingController();

class _CountryListViewState extends State<CountryListView> {
  List<CountriesListModel> da = [];
  WorldStateService service = WorldStateService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search with Country Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: service.fetchCountriesListRecord(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade100,
                              ),
                              title: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              subtitle: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade700,
                              thickness: 1.3,
                            )
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String cname = snapshot.data![index]['country'];

                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data![index]['countryInfo']['flag']
                                    .toString()),
                              ),
                              title: Text(
                                  snapshot.data![index]['country'].toString()),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                            ),
                            Divider(
                              color: Colors.grey.shade700,
                              thickness: 1.3,
                            )
                          ],
                        );
                      } else if (cname
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data![index]['countryInfo']['flag']
                                    .toString()),
                              ),
                              title: Text(
                                  snapshot.data![index]['country'].toString()),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                            ),
                            Divider(
                              color: Colors.grey.shade700,
                              thickness: 1.3,
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
