import 'package:flutter/material.dart';
import 'package:test_request_api_flutter/network/network_request.dart';

import 'model/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListViewPage(),
    );
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  late Future<List<Data>?> futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = NetworkRequest.fetchGets();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('HTTP Request')),
      ),
      body: Center(
        child: FutureBuilder<List<Data>?>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListTile(
                            leading: const Icon(
                              Icons.food_bank_outlined,
                              color: Colors.amberAccent,
                            ),
                            isThreeLine: true,
                            title:
                            Text(snapshot.data![index].title ?? "Default"),
                            subtitle: Text(snapshot.data![index].decscription ??
                                "Default"),
                          ),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

