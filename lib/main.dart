import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;

void main() {
  runApp(MaterialApp(
    theme: style.theme,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentTab = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instagram',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: [Home(), Text('샵')][currentTab],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) => {
                setState(() {
                  currentTab = value;
                })
              },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: '샵')
          ]),
    );
  }
}

class InstaBottomNav extends StatelessWidget {
  const InstaBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext ctx, int idx) {
          return Column(children: [
            Image.asset(
              'winter.webp',
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 600),
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '좋아요 100',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text('글쓴이'),
                    Text('글내용')
                  ]),
            )
          ]);
        });
  }
}
