import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<bool> shaded = [];

Future<List<String>> fetchTags() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/v1/quizzes/tags'));
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    List<String> tagsFromAPI = [];
    for (var x in json['tags']) {
      if (x == "\nrock") {
        tagsFromAPI.add("rock");
      } else {
        tagsFromAPI.add(x);
      }
      shaded.add(false);
    }
    tagsFromAPI.sort();
    return tagsFromAPI;
  } else {
    throw Exception('Failed to load tags');
  }
}

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  late List<String> tags = [];
  late List<String> selectedTags = [];
  late List<String> search = [];
  late Future<List<String>> futureTags;
  var helper = 0;

  void addQuiz(String categoryName, String pathToImage) {
    tags.add(categoryName);
  }

  @override
  void initState() {
    futureTags = fetchTags();
    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<String> help = [];
      for (var i in tags) {
        if (i.toLowerCase().contains(query.toLowerCase())) {
          help.add(i);
        }
      }
      setState(() {
        search.clear();
        search.addAll(help);
      });
      return;
    } else {
      setState(() {
        search.clear();
        search.addAll(tags);
      });
    }
  }

  Widget tagButton(String tagName, double x, double y) {
    int indeks = tags.indexOf(tagName);
    return ElevatedButton(
      onPressed: () {
        if (!selectedTags.contains(tagName)) {
          selectedTags.add(tagName);
        } else {
          selectedTags.remove(tagName);
        }

        setState(() {
          shaded[indeks] = !shaded[indeks];
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: shaded[indeks] ? Colors.cyan.shade700 : Colors.cyan,
        fixedSize: Size(110 * x, 50 * y),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          alignment: Alignment.center,
          child: Text(
            tagName,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        onChanged: (value) {
          filterSearchResults(value);
        },
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(36.84),
              borderSide: BorderSide.none),
          hintText: "Search for tags...",
          prefixIcon: IconButton(
              icon: Image.asset('assets/images/searchnormal1.png'),
              onPressed: () {}),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70 * y),
            child: Header(
              leftIcon: 'assets/images/profile.png',
              rightIcon: 'assets/images/settings.png',
              y: y,
            ),
          ),
          body: FutureBuilder<List<String>>(
              future: futureTags,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  tags = snapshot.data!;
                  if (search.isEmpty) {
                    search.addAll(tags);
                  }

                  return SingleChildScrollView(
                      child: Column(
                    key: const Key("tagButton"),
                    children: [
                      SizedBox(
                        child: searchBar(),
                      ),
                      for (var i = 0; i <= search.length - 3; i += 3)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                tagButton(search.elementAt(i), x, y),
                                tagButton(search.elementAt(i + 1), x, y),
                                tagButton(search.elementAt(i + 2), x, y),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      if (search.length % 3 == 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            tagButton(
                                search.elementAt(search.length - 1), x, y),
                            SizedBox(
                              width: 110 * x,
                            ),
                            SizedBox(
                              width: 110 * x,
                            )
                          ],
                        ),
                      if (search.length % 3 == 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            tagButton(
                                search.elementAt(search.length - 2), x, y),
                            tagButton(
                                search.elementAt(search.length - 1), x, y),
                            SizedBox(
                              width: 110 * x,
                            )
                          ],
                        ),
                    ],
                  ));
                } else {
                  return const Center(
                      key: Key("CPR"), child: CircularProgressIndicator());
                }
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.back(result: selectedTags);
            },
            backgroundColor: Colors.cyan.shade800,
            child: const Icon(Icons.done_rounded),
          )),
    ));
  }
}
