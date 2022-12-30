import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> fetchCategories() async {
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
  Map<String, String> iconMap = {
    "Geography": 'assets/images/global.png',
    "Arts & Literature": 'assets/images/brush.png',
    "Film & TV": 'assets/images/videovertical.png',
    "Food & Drink": 'assets/images/milk.png',
    "General Knowledge": 'assets/images/book.png',
    "History": 'assets/images/courthouse.png',
    "Music": 'assets/images/music.png',
    "Science": 'assets/images/chemicalglass.png',
    "Society & Culture": 'assets/images/people.png',
    "Sport & Leisure": 'assets/images/dribbble.png'
  };

  void addQuiz(String categoryName, String pathToImage) {
    categories.add(categoryName);
    pathToImages.add(pathToImage);
  }

  @override
  void initState() {
    futureCategories = fetchCategories();
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

  Widget categoryButton(
      String categoryName, String categoryImage, double x, double y) {
    return ElevatedButton(
      onPressed: () {
        Get.back(result: categoryName);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan,
        fixedSize: Size(110 * x, 145 * y),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20 * y,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 1.0, right: 1.0),
            child: Center(
              child: Container(
                width: 62 * x,
                height: 62 * x,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage(categoryImage)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10 * y,
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
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                categories = snapshot.data!;
                if (search.isEmpty) {
                  search.addAll(categories);
                }

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
                              categoryButton(
                                  search.elementAt(i),
                                  iconMap[search.elementAt(i)] ??
                                      'assets/images/game.png',
                                  x,
                                  y),
                              categoryButton(
                                  search.elementAt(i + 1),
                                  iconMap[search.elementAt(i + 1)] ??
                                      'assets/images/game.png',
                                  x,
                                  y),
                              categoryButton(
                                  search.elementAt(i + 2),
                                  iconMap[search.elementAt(i + 2)] ??
                                      'assets/images/game.png',
                                  x,
                                  y),
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
                          categoryButton(
                              search.elementAt(search.length - 1),
                              iconMap[search.elementAt(search.length - 1)] ??
                                  'assets/images/game.png',
                              x,
                              y),
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
                          categoryButton(
                              search.elementAt(search.length - 2),
                              iconMap[search.elementAt(search.length - 2)] ??
                                  'assets/images/game.png',
                              x,
                              y),
                          categoryButton(
                              search.elementAt(search.length - 1),
                              iconMap[search.elementAt(search.length - 1)] ??
                                  'assets/images/game.png',
                              x,
                              y),
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
      ),
    ));
  }
}
