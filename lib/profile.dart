import 'package:flutter/material.dart';
import 'package:instagram/store.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<Store2>().name),
      ),
      body: ProfileHeader(),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey,
      ),
      Text('팔로워 ${context.watch<Store1>().follower}'),
      ElevatedButton(
        onPressed: () {
          context.read<Store1>().follow();
        },
        child: Text('팔로우'),
      ),
    ]);
  }
}
