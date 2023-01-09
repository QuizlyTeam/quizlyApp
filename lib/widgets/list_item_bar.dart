import 'package:flutter/material.dart';

class ListItemBar extends StatefulWidget {
  final String title;
  final double x;
  final double y;
  const ListItemBar({
    super.key,
    required this.x,
    required this.y,
    required this.title,
  });

  @override
  State<ListItemBar> createState() => _ListItemBarState();
}

class _ListItemBarState extends State<ListItemBar> {
  Widget listItemBar(double x, double y, String title) {
    return SizedBox(
      width: 390 * x,
      height: 100 * y,
      child: Center(
          child: Container(
              width: 370 * x,
              height: 80 * y,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.cyan),
              child: Row(
                children: [
                  SizedBox(width: 10 * x),
                  Container(
                    width: 220 * x,
                    height: 60 * y,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.white),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(children: [
                          SizedBox(
                            width: 10 * x,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 20 * y, color: Colors.black),
                          ),
                        ])),
                  ),
                  SizedBox(width: 10 * x),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.edit_outlined),
                      iconSize: 45*y,
                      color: Colors.white),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.delete_forever_outlined),
                      iconSize: 45*y,
                      color: Colors.white)
                ],
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return listItemBar(widget.x, widget.y, widget.title);
  }
}
