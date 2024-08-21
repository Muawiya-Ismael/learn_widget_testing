import 'package:flutter/material.dart';

void main() {
  runApp( MyWidget(title: "HOME", message: "This is the home page.",items: List<String>.generate(10000, (i) => 'Item $i'),));
}
class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.title,
    required this.message,
    required this.items
  });

  final String title;
  final String message;

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget testing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness:  Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(message),
            ],
          ),
        ),
        body: ListView.builder(
          key: const Key('long_list'),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index],
                key: Key('item_${index}_text'),
              ),
            );
          },
        ),
      ),
    );
  }
}
