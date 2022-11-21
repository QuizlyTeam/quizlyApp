import 'dart:collection';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'question.dart';

class Category {
  final images = [];
  final Map<String, String> categories = HashMap();
  Category();
  void addImage(String pathToImage) {
    images.add(pathToImage);
  }

  void addCategory(String categoryName, String pathToImage) {
    categories[categoryName] = pathToImage;
  }
}

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);
  final Category categories = Category();

  void addQuiz(String categoryName, String pathToImage) {
    categories.addCategory(categoryName, pathToImage);
  }

  void defaultCategories() {
    categories.addCategory("Film & TV", 'assets/images/game.png');
    categories.addCategory("Arts & Literature", 'assets/images/game.png');
    categories.addCategory("Food & Drink", 'assets/images/game.png');
    categories.addCategory("General Knowledge", 'assets/images/game.png');
    categories.addCategory("Geography", 'assets/images/game.png');
    categories.addCategory("History", 'assets/images/game.png');
    categories.addCategory("Music", 'assets/images/game.png');
    categories.addCategory("Science", 'assets/images/game.png');
    categories.addCategory("Society & Culture", 'assets/images/game.png');
    categories.addCategory("Sport & Leisure", 'assets/images/game.png');
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
            correctAnswer: "Kiribati"));
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
    defaultCategories();
    var keys = categories.categories.keys;
    var values = categories.categories.values;
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
                for (var i = 0; i < categories.categories.length - 3; i += 3)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          categoryButton(
                              keys.elementAt(i), values.elementAt(i)),
                          categoryButton(
                              keys.elementAt(i + 1), values.elementAt(i + 1)),
                          categoryButton(
                              keys.elementAt(i + 2), values.elementAt(i + 2))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                if (keys.length % 3 == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      categoryButton(keys.elementAt(keys.length - 1),
                          values.elementAt(keys.length - 1)),
                      const SizedBox(
                        width: 110,
                      ),
                      const SizedBox(
                        width: 110,
                      )
                    ],
                  ),
                if (keys.length % 3 == 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      categoryButton(keys.elementAt(keys.length - 2),
                          values.elementAt(keys.length - 2)),
                      categoryButton(keys.elementAt(keys.length - 1),
                          values.elementAt(keys.length - 1)),
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
