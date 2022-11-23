import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'question.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<String> categories = [];
  late List<String> search = [];
  late List<String> pathToImages = ['assets/images/game.png'];

  void addQuiz(String categoryName, String pathToImage) {
    categories.add(categoryName);
    pathToImages.add(pathToImage);
  }

  @override
  void initState() {
    categories.add("Film & TV");
    categories.add("Food & Drink");
    categories.add("General Knowledge");
    categories.add("Geography");
    categories.add("History");
    categories.add("Music");
    categories.add("Science");
    categories.add("Society & culture");
    categories.add("Arts & Literature");
    categories.add("Sport & Leisure");
    search.addAll(categories);
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
          body: SingleChildScrollView(
            child: Column(
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
                              search.elementAt(i), pathToImages.elementAt(0)),
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
            ),
          ),
        ),
      ),
    );
  }
}
