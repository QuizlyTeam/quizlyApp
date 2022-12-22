import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'question.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

  Future<List<String>> fetchCategories(/*http.Client client*/) async {
    final response =
    await http.get(Uri.parse('http://10.0.2.2:8000/v1/quizzes/categories'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<String> categoriesFromAPI = [];
      for (var x in json['categories']) {
        categoriesFromAPI.add(x);
      }
      return categoriesFromAPI;
    } else {
      throw Exception('Failed to load categories');
    }
  }


class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<String> categories = [];
  late List<String> search = [];
  late List<String> pathToImages = ['assets/images/game.png'];
  late Future<List<String>> futureCategories;
  var helper = 0;

  void addQuiz(String categoryName, String pathToImage) {
    categories.add(categoryName);
    pathToImages.add(pathToImage);
  }

  @override
  void initState() {
    futureCategories = fetchCategories(/*http.Client()*/);
    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<String> help = [];
      for (var i in categories) {
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
        search.addAll(categories);
      });
    }
  }

  Widget categoryButton(String categoryName, String categoryImage) {
    return ElevatedButton(
      onPressed: () {
        Get.to(const Question(
          question: "Jakiego kraju \n to flaga?",
          ans1: "Kiribati",
          ans2: "Liberia",
          ans3: "Tuvalu",
          ans4: "Macedonia",
          correctAnswer: "Kiribati",
        ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan,
        fixedSize: const Size(110, 145),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 1.0, right: 1.0),
            child: Center(
              child: Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage(categoryImage)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            child: Text(
              categoryName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
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
          hintText: "Search for quiz...",
          prefixIcon: IconButton(
              icon: Image.asset('assets/images/searchnormal1.png'),
              onPressed: () {}),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
              leftIcon: 'assets/images/profile.png',
              rightIcon: 'assets/images/settings.png'),
        ),
        body: FutureBuilder<List<String>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                categories = snapshot.data!;
                search.addAll(categories);

                return SingleChildScrollView(
                    child: Column(
                      key: const Key("categoryButton"),
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
                              categoryButton(search.elementAt(i),
                                  pathToImages.elementAt(0)),
                              categoryButton(search.elementAt(i + 1),
                                  pathToImages.elementAt(0)),
                              categoryButton(search.elementAt(i + 2),
                                  pathToImages.elementAt(0)),
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
                          categoryButton(search.elementAt(search.length - 1),
                              pathToImages.elementAt(0)),
                          const SizedBox(
                            width: 110,
                          ),
                          const SizedBox(
                            width: 110,
                          )
                        ],
                      ),
                    if (search.length % 3 == 2)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          categoryButton(search.elementAt(search.length - 2),
                              pathToImages.elementAt(0)),
                          categoryButton(search.elementAt(search.length - 1),
                              pathToImages.elementAt(0)),
                          const SizedBox(
                            width: 110,
                          )
                        ],
                      ),
                  ],
                ));
              } else {
                return const Center(key: Key("CPR"), child: CircularProgressIndicator());
              }
            }),
      ),
    ));
  }
}
