import 'package:flutter/material.dart';
import 'package:instagram/store.dart';
import 'package:instagram/wrapper.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
        onInit: context.read<Store2>().getData(),
        child: Scaffold(
            body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 160.0,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('SliverAppBar'),
                background: FlutterLogo(),
              ),
            ),
            ProfileHeader(),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        color: Colors.grey,
                        // child: context
                        //         .watch<Store2>()
                        //         .profileImage
                        //         .isNotEmpty
                        //     ? Image.network(
                        //         context.watch<Store2>().profileImage[index])
                        //     : Text('loading'),
                        child: Image.network(
                            context.watch<Store2>().profileImage[index]),
                      ),
                  childCount: context.watch<Store2>().profileImage.length),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            ),
          ],
        )));
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
    ]));
  }
}
