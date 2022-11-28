// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'dart:io';

class Post {
  int id;
  File image;
  int likes;
  String date;
  String content;
  bool liked;
  String user;

  Post(this.id, this.image, this.likes, this.date, this.content, this.liked,
      this.user);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'likes': likes,
      'date': date,
      'content': content,
      'liked': liked,
      'user': user
    };
  }
}

void main() {
  runApp(MaterialApp(
    theme: style.theme,
    // initialRoute: '/',
    // routes: {'/': (context) => MyApp(), '/upload': (context) => Upload()}
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
  var data = [];
  var userImage;
  var userContent;

  getData() async {
    final response = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load feed');
    }
  }

  changeUserContent(String content) {
    setState(() {
      userContent = content;
    });
  }

  addData(post) {
    setState(() {
      data.add(post);
    });
  }

  addUserData() {
    var newData = Post(
        data.length, userImage, 5, 'July 32', userContent, false, 'John Doe');
    // print(newData);
    setState(() {
      data.insert(0, newData.toMap());
    });
  }

  @override
  void initState() {
    super.initState();
    // Launched after first load
    getData();
  }

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
              onPressed: () async {
                var imgPicker = ImagePicker();
                var image =
                    await imgPicker.pickImage(source: ImageSource.gallery);
                setState(() {
                  userImage = File(image!.path);
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Upload(
                            userImage: userImage,
                            changeUserContent: changeUserContent,
                            addUserData: addUserData)));
              })
        ],
      ),
      body: [Home(data: data, addData: addData), Text('샵')][currentTab],
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

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatefulWidget {
  const Home({super.key, this.data, this.addData});
  final data;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();
  var currentPostNum = 3;
  var maxPostNum = 5;
  var apiPending = false;

  getMore() async {
    if (currentPostNum == maxPostNum || apiPending) return;

    setState(() {
      currentPostNum++;
    });
    apiPending = true;
    final response = await http.get(Uri.parse(
        'https://codingapple1.github.io/app/more${currentPostNum - 3}.json'));
    apiPending = false;
    if (response.statusCode == 200) {
      widget.addData(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load feed');
    }
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.data.length,
          controller: scroll,
          itemBuilder: (BuildContext ctx, int idx) {
            return Column(children: [
              widget.data[idx]['image'].runtimeType == String
                  ? Image.network(widget.data[idx]['image'])
                  : Image.file(widget.data[idx]['image']),
              Container(
                constraints: BoxConstraints(maxWidth: 600),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '좋아요 ${widget.data[idx]['likes']}',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(widget.data[idx]['user']),
                      Text(widget.data[idx]['content'])
                    ]),
              )
            ]);
          });
    } else {
      return CircularProgressIndicator();
    }
  }
}

class Upload extends StatelessWidget {
  const Upload(
      {Key? key, this.userImage, this.changeUserContent, this.addUserData})
      : super(key: key);
  final userImage;
  final changeUserContent;
  final addUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  addUserData();
                },
                icon: Icon(Icons.file_upload_outlined))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 300),
              child: Image.file(userImage),
            ),
            Text('이미지업로드화면'),
            TextField(
              onChanged: (value) => changeUserContent(value),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
          ],
        ));
  }
}
