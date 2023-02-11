import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}


class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:  [
          ListTile(
            title: const Text("1 . user 1 ") ,
            onTap: (){},
            leading: const Icon((Icons.person)),
            trailing: const Icon(Icons.menu),
          ),

          ListTile(
            title: const Text("2 . user2") ,
            onTap: (){},
            leading: const Icon((Icons.person)),
            trailing: const Icon(Icons.menu),
          ),

          ListTile(
            title: const Text("3 . user3") ,
            onTap: (){},
            leading: const Icon((Icons.person)),
            trailing: const Icon(Icons.menu),
          ),

          ListTile(
            title: const Text("4 . user4") ,
            onTap: (){},
            leading: const Icon((Icons.person)),
            trailing: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}